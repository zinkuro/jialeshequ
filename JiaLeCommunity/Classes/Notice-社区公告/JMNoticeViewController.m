//
//  JMNoticeViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMNoticeViewController.h"
#import "JMNoticeHeaderViewController.h"
#import "JMNoticeCell.h"
#import "JMNoticeCellModel.h"

@interface JMNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) JMNoticeCellModel *model;


@end

@implementation JMNoticeViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)creatUI {
    [super creatUI];
    //需要加载网络数据得出模型=======================
    _model = [[JMNoticeCellModel alloc]init];
    _model.titleText = @"周末台球比赛";
    _model.detailText = @"2016-1-20,周末台球比赛,聚餐等精彩活动等你来玩哦";
    _model.numberText = @"1235";
    _model.imageURL = @"http://i2.hdslb.com/bfs/archive/e49626dee5ccb2a88e36c599b68a756b3ae7d09c.jpg_320x200.jpg";
    
    
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"JMNoticeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    JMNoticeHeaderViewController *headerViewController = [[JMNoticeHeaderViewController alloc]initWithHeaderImageArray:@[@"h0",@"h1",@"h2"] labelTextArray:@[@"社区公告",@"聊天",@"实验室",@"交友"]];
    headerViewController.view.backgroundColor = [UIColor whiteColor];
    headerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 14 / 32.0f + self.view.frame.size.width / 4 * 10 / 9.0f);
    [self.view addSubview:headerViewController.view];
    self.tableView.tableHeaderView = headerViewController.view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithR:230 G:230 B:230];
    
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 12)];
    blankView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 15, 19)];
    imageView.image = [UIImage imageNamed:@"n0"];
    
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 20, 100, 20)];
    sectionLabel.text = @"社区公告";
    
    [sectionView addSubview:blankView];
    [sectionView addSubview:sectionLabel];
    [sectionView addSubview:lineView];
    [sectionView addSubview:imageView];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
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
