//
//  JMStatusTableViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/9/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMStatusTableViewController.h"
#import "JMStatusDetailViewController.h"
#import "JMStatusCell.h"
#import "JMStatusModel.h"
@interface JMStatusTableViewController () <UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isMore;
}

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (strong,nonatomic) NSMutableArray *dataArray;

@property (assign,nonatomic) NSInteger page;

@end

@implementation JMStatusTableViewController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60 - 49 - 45)];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isMore = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    
    [self creatRefresh];
    [self.tableView.mj_header beginRefreshing];
    
    
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//
//    self.tableView.tableFooterView = [[UIView alloc]init];
    
//    self.tableView.frame = CGRectMake(0, 0, self.view.width,45);
//    self.tableView.backgroundColor = [UIColor cyanColor];
//    [self.tableView registerNib:[UINib nibWithNibName:@"JMStatusCell" bundle:nil] forCellReuseIdentifier:@"status"];//采用了estimatedHeight就不能使用先注册的方法了,因为这种方法会提前做出高度
//    NSLog(@"token==============%@",self.token);

    //    self.container.contentScrollView.canCancelContentTouches = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)requestDataWithLen:(NSInteger)len
                      page:(NSInteger)page {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.requestDict];
    NSString *TP = [NSString string];
    if (self.isTP == YES) {
        TP = @"1";
    }else {
        TP = @"0";
    }
    [dict setObject:TP forKey:@"tp"];
    [dict setObject:[NSString stringWithFormat:@"%zd",page] forKey:@"page"];
    [dict setObject:[NSString stringWithFormat:@"%zd",len] forKey:@"len"];
//    NSLog(@"page = %zd,len = %zd",page,len);
//    NSLog(@"request:%@",dict);

    [self.manager GET:self.requestURL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingTask");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.isTP == YES) {
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            NSLog(@"这是全部数据%@",jsonStr);
        }
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
        }else {
            NSArray *resultArray = responseObject[@"data"][@"list"];
            NSArray *statusArray = [NSArray yy_modelArrayWithClass:[JMStatusModel class] json:resultArray];
            if (self.dataArray.count > 0 && !_isMore) {
                [self.dataArray removeAllObjects];
            }else {
                if (_isMore) {
                    _isMore = NO;
                }
            }
            [SVProgressHUD showSuccessWithStatus:@"加载完成"];
            [self.dataArray addObjectsFromArray:statusArray];
        }
        [self.tableView reloadData];
  
//        [self.tableView reloadData];
//        NSLog(@"%@",statusArray);
//        NSLog(@"%@",self.dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}



- (void)creatRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    //self.newsTableView.mj_footer.hidden = YES;
}

- (void)loadNewStatus {
    NSInteger len = 6;
    self.page = 1;
    [self requestDataWithLen:len page:self.page];
    [self.tableView.mj_header endRefreshing];
//    [self.tableView reloadData];

}

- (void)loadMoreStatus {
    _isMore = YES;
    NSInteger len = 6;
    NSLog(@"%zd",self.page);
    self.page = (self.page + 1);
    [self requestDataWithLen:len page:self.page];
    [self.tableView.mj_footer endRefreshing];
//    [self.tableView reloadData];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [cell setSeparatorInset:UIEdgeInsetsZero];
//    [cell setLayoutMargins:UIEdgeInsetsZero];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"estimate");
    return 500;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cellHeight");
    JMStatusModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cellCreat");
    
    JMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];

    if (cell == nil) {
        //采用了estimatedHeight的话就必须在这里进行cell创建的时候加载,而不能在viewDidLoad里面进行注册,否则方法顺序会出错
        //estimateHeight就是为了让cell在创建的时候再决定高度
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JMStatusCell" owner:nil options:nil]lastObject];

    }
    
    // Configure the cell...
    JMStatusModel *model = self.dataArray[indexPath.row];
    cell.model = model;
//    cell.commentButton.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JMStatusDetailViewController *detail = [[JMStatusDetailViewController alloc]init];
    JMStatusModel *model = self.dataArray[indexPath.row];
    detail.model = model;
    detail.token = self.token;
    [self presentViewController:detail animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
