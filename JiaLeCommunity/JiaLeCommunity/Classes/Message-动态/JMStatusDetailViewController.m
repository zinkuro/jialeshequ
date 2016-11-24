//
//  JMStatusDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/11/10.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMStatusDetailViewController.h"
#import "JMStatusModel.h"
#import "JMStatusCell.h"
#import "JMReplyModel.h"
#import "JMReplyTabelViewCell.h"
@interface JMStatusDetailViewController () <UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) JMStatusModel *newModel;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation JMStatusDetailViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (JMStatusModel *)newModel{
    if (!_newModel) {
        _newModel = [[JMStatusModel alloc]init];
    }
    return _newModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _tableView;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.manager GET:JIALE_CLUB_BBS_INFO_URL parameters:@{@"token":self.token,@"id":[NSString stringWithFormat:@"%zd",self.model.post_id]} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        //        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSLog(@"这是全部数据???%@",jsonStr);
        self.newModel = self.model;
        NSLog(@"%@",responseObject[@"data"]);
        
        NSArray *resultArray = responseObject[@"data"][@"ilist"][@"list"];
        if (resultArray.count > 0) {
            NSArray *statusArray = [NSArray yy_modelArrayWithClass:[JMReplyModel class] json:resultArray];
            [self.dataArray addObjectsFromArray:statusArray];
        }
        NSLog(@"%@",self.dataArray);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        JMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];
        
        if (cell == nil) {
            //采用了estimatedHeight的话就必须在这里进行cell创建的时候加载,而不能在viewDidLoad里面进行注册,否则方法顺序会出错
            //estimateHeight就是为了让cell在创建的时候再决定高度
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JMStatusCell" owner:nil options:nil]lastObject];
            
        }
        cell.commentButton.hidden = NO;
        cell.likedButton.hidden = NO;
        cell.collectButton.hidden = NO;
        cell.model = self.newModel;
        return cell;
    } else {
        JMReplyTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reply"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JMReplyTabelViewCell" owner:nil options:nil]lastObject];
        }
        cell.model = self.dataArray[indexPath.row];
        //        cell.textLabel.text = @"nimabihoutaijiushigeshabi";
        return cell;
    }     // Configure the cell...
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return self.newModel.cellHeight;
    } else {
        return 76;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
