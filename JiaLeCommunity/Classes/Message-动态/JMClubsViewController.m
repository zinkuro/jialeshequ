//
//  JMClubsViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/3.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMClubsViewController.h"
#import "JMClubTypeModel.h"
#import "JMClubModel.h"
#import "JMClubCell.h"
#import "JMStatusTableViewController.h"
#import "JMClubDetailViewController.h"

#define SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface JMClubsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (strong,nonatomic) UITableView *leftTableView;

@property (strong,nonatomic) UITableView *rightTableView;

@property (strong,nonatomic) NSMutableArray *leftDataArray;

@property (strong,nonatomic) NSMutableArray *rightDataArray;

@end

@implementation JMClubsViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 5.0f, SCREEN_HEIGTH) style:UITableViewStylePlain];
    }
    _leftTableView.backgroundColor = [UIColor colorWithR:246 G:246 B:246];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 5.0f, 0, SCREEN_WIDTH * 4 / 5.0f, SCREEN_HEIGTH - 45 - 60) style:UITableViewStylePlain];
    }
//    _rightTableView.backgroundColor = [UIColor cyanColor];
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    return _rightTableView;
}

- (NSMutableArray *)leftDataArray {
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableArray *)rightDataArray {
    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftDataArray.count + 1;
    } else {
        return self.rightDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iden"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 5.0f, 50)];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iden"];
            [cell.contentView addSubview:label];
        }
        
        if (indexPath.row == 0) {
            label.text = @"全部社团";
        } else {
            
            JMClubTypeModel *model = self.leftDataArray[indexPath.row - 1];
            label.text = model.name;
        }
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor colorWithR:246 G:246 B:246];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
        
    } else {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//        }
        JMClubModel *model = self.rightDataArray[indexPath.row];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.jialeshequ.com/%@",model.pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"成员: %zd人",model.user_num];
//        cell.textLabel.text = model.name;
        JMClubCell *cell = [JMClubCell cellWithTableView:tableView];
        
        cell.model = model;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rightTableView) {
        return 100;
    }
    return 50;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict = @{@"token":self.token};
    [self getLeftDataWithDict:dict];
    [self getRightDataWithDict:dict];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *requestDict = [[NSDictionary alloc]init];

    if (tableView == self.leftTableView) {
        [self.rightDataArray removeAllObjects];
        if (indexPath.row == 0) {
            requestDict = @{@"token":self.token};
        } else {
            JMClubTypeModel *model = self.leftDataArray[indexPath.row - 1];
            requestDict = @{@"type":model.type_id};
        }
        [self getRightDataWithDict:requestDict];
    } else if (tableView == self.rightTableView) {
        JMClubModel *model = self.rightDataArray[indexPath.row];
        NSLog(@"%@",model.club_id);
        
        JMClubDetailViewController *vc = [[JMClubDetailViewController alloc]init];
        vc.requestURL = JIALE_CLUB_BBS_URL;
        vc.requestDict = @{@"noteid":model.club_id,@"token":self.token};
        vc.token = self.token;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
//        UIView *clubHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH * 5 / 8.0f)];
//        clubHeaderView.backgroundColor = [UIColor redColor];
//        
//        clubStatus.tableView.backgroundColor = [UIColor redColor];
//
//        [self.navigationController pushViewController:clubStatus animated:YES];
//        
    }
    

}

- (void)getLeftDataWithDict:(NSDictionary *)dict {
    [self.manager GET:JIALE_CLUBS_TYPE_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingClubs");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"这是clubType数据%@",jsonStr);
        
        
        NSArray *resultArray = responseObject[@"data"];
        NSArray *typeArray = [NSArray yy_modelArrayWithClass:[JMClubTypeModel class] json:resultArray];
//        NSLog(@"%@",typeArray);
        
        [self.leftDataArray addObjectsFromArray:typeArray];
        [self.leftTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

- (void)getRightDataWithDict:(NSDictionary *)dict {
    [self.manager GET:JIALE_CLUBS_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingClub");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"这是club数据%@",jsonStr);
        
        NSLog(@"%@",[responseObject[@"status"] class]);
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]] isEqualToString:@"0"]) {
            NSLog(@"noData");
            
        } else {
            
            NSArray *resultArray = responseObject[@"data"][@"list"];
            NSArray *clubsArray = [NSArray yy_modelArrayWithClass:[JMClubModel class] json:resultArray];
            
            
            [self.rightDataArray addObjectsFromArray:clubsArray];
            [self.rightTableView reloadData];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

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
