//
//  JMClubInfoViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/9.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMClubInfoViewController.h"
#import "JMClubModel.h"
#import "JMClubTypeModel.h"
@interface JMClubInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *headerView;

@property (strong,nonatomic) UIImageView *avatarView;

@property (strong,nonatomic) UILabel *nameLabel;

@end

@implementation JMClubInfoViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *infoIden = @"info";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoIden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoIden];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"分类";
            NSLog(@"%@",self.model);
            cell.detailTextLabel.text = self.model.typeName;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"标签";
            //        cell.detailTextLabel.text = self.model.typeModel.
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"简介";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"地区";
//            cell.detailTextLabel.text
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"所属大学";
        }
    }
    
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
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
