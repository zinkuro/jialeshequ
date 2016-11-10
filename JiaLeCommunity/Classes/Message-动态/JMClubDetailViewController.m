//
//  JMClubDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/6.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMClubDetailViewController.h"
#import "JMStatusCell.h"
#import "JMStatusModel.h"
#import "JMClubModel.h"
#import "JMClubInfoViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCALE (SCREEN_WIDTH / 414)

@interface JMClubDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) UIImageView *avatarView;

@property (strong,nonatomic) UILabel *remarkLabel;

@property (strong,nonatomic) UILabel *nameLabel;

@property (strong,nonatomic) UIView *headerView;

@property (nonatomic,strong) JMClubModel *model;

@property (nonatomic,strong) UIButton *joinButton;

@end

@implementation JMClubDetailViewController

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 23 / 64, SCREEN_WIDTH * 5 / 8 / 10, SCREEN_WIDTH * 9 / 32, SCREEN_WIDTH * 9 / 32)];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = SCREEN_WIDTH * 9 / 64;
    }
    return _avatarView;
}

- (UILabel *)remarkLabel {
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        _signLabel.backgroundColor = [UIColor orangeColor];
        _remarkLabel.adjustsFontSizeToFitWidth = YES;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.textColor = [UIColor whiteColor];
//        _remarkLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remarkLabel;
}

- (void)headerViewTapped {
    JMClubInfoViewController *infoVc = [[JMClubInfoViewController alloc]init];
    infoVc.model = self.model;
    [self.navigationController pushViewController:infoVc animated:YES];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        //        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:20 * SCALE];
    }
    return _nameLabel;
}

- (UIView *)headerView {
    if (!_headerView) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 3 / 8.0f)];
        UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:_headerView.frame];
        headerImageView.image = [UIImage imageNamed:@"199"];
        [_headerView addSubview:headerImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewTapped)];
        [_headerView addGestureRecognizer:tapGesture];
        
    }
    return _headerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60 - 49)];
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
    self.joinButton.userInteractionEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
//    self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    
    [self.headerView addSubview:self.avatarView];
    [self.headerView addSubview:self.nameLabel];
    [self.headerView addSubview:self.remarkLabel];
    
    __weak typeof(self) weakself = self;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.avatarView.mas_bottom).offset(12.0f * SCALE);
        make.left.equalTo(weakself.headerView);
        make.right.equalTo(weakself.headerView);
        make.bottom.equalTo(weakself.nameLabel.mas_top).offset(weakself.view.width * 9 / 32 / 5);
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(8.0f * SCALE);
        make.left.equalTo(weakself.headerView).offset(weakself.view.width / 8.0f);
        make.right.equalTo(weakself.headerView).offset(- weakself.view.width / 8.0f);
        make.bottom.equalTo(weakself.headerView.mas_bottom).offset(- 10.0f * SCALE);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    //
    //    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //    self.tableView.frame = CGRectMake(0, 0, self.view.width,45);
    //    self.tableView.backgroundColor = [UIColor cyanColor];
    //    [self.tableView registerNib:[UINib nibWithNibName:@"JMStatusCell" bundle:nil] forCellReuseIdentifier:@"status"];//采用了estimatedHeight就不能使用先注册的方法了,因为这种方法会提前做出高度
//    NSLog(@"token==============%@",self.token);
    [self.manager GET:self.requestURL parameters:self.requestDict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingTask");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"这是全部bbs数据%@",jsonStr);
        
        NSArray *resultArray = responseObject[@"data"][@"list"];
        NSLog(@"?????????????????%@",responseObject[@"data"][@"quan"]);
        NSArray *statusArray = [NSArray yy_modelArrayWithClass:[JMStatusModel class] json:resultArray];
        
        JMClubModel *model = [JMClubModel yy_modelWithJSON:responseObject[@"data"][@"quan"]];
        
        NSLog(@"quan%@",model);
        self.model = model;
        [self creatHeaderView];
        NSLog(@"%@",self.model);
        
        NSLog(@"----!----%zd",self.model.is_menber);
        if (self.model.is_menber == 0) {
            [self.joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
            [self.joinButton setTitle:@"退出社团" forState:UIControlStateSelected];

        }else {
            [self.joinButton setTitle:@"退出社团" forState:UIControlStateNormal];
            [self.joinButton setTitle:@"加入社团" forState:UIControlStateSelected];

        }

//        NSLog(@"%@",sysArray);
        self.joinButton.userInteractionEnabled = YES;
        [self.dataArray addObjectsFromArray:statusArray];
        [self.tableView reloadData];
//        NSLog(@"%@",self.dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    //    self.container.contentScrollView.canCancelContentTouches = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - 45 - 64  , self.view.width, 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    self.joinButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 7.5, self.view.width - 24, 30)];
    self.joinButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.joinButton.clipsToBounds = YES;
    self.joinButton.layer.cornerRadius = 3;
    self.joinButton.backgroundColor = [UIColor colorWithR:24 G:154 B:202];
    
    [self.joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:self.joinButton];
    
    [self.view addSubview:bottomView];
}

- (void)joinButtonClicked:(UIButton *)button {
    NSDictionary *dict = [[NSDictionary alloc]init];

    if (self.model.is_menber == 1) {
        NSLog(@"点击退出");
        dict = @{@"token":self.token,@"noteid":self.model.club_id,@"is_out":@"1"};
        self.model.is_menber = 0;
    } else {
        NSLog(@"点击加入");
        dict = @{@"token":self.token,@"noteid":self.model.club_id,@"is_out":@"0"};
        self.model.is_menber = 1;

    }
    
    NSLog(@"dictPostJoin%@",dict);
    
    [self.manager POST:JIALE_CLUB_JOIN_URL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"joining");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"joinResponse%@",jsonStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    button.selected = !button.selected;
}

- (void)creatHeaderView {
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.jialeshequ.com/%@",self.model.pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
    
    self.nameLabel.text = self.model.name;
    
    if (self.model.remark.length <= 52 && self.model.remark.length > 0) {
        self.remarkLabel.text = self.model.remark;
    } else {
        self.remarkLabel.text = [[self.model.remark substringWithRange:NSMakeRange(0, 52)] stringByAppendingString:@"..."];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"estimate");
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMStatusModel *model = self.dataArray[indexPath.row];

    NSLog(@"cellHeight = %.2f",model.cellHeight);
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellCreat");
    
    JMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];
    if (cell == nil) {
        //采用了estimatedHeight的话就必须在这里进行cell创建的时候加载,而不能在viewDidLoad里面进行注册,否则方法顺序会出错
        //estimateHeight就是为了让cell在创建的时候再决定高度
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JMStatusCell" owner:nil options:nil]lastObject];
    }
    
    // Configure the cell...
    cell.model = self.dataArray[indexPath.row];
    return cell;
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
