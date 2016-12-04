//
//  JMMineDetailTableViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/27.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMMineDetailTableViewController.h"
#import "JMUserModel.h"
@interface JMMineDetailTableViewController ()

@end

@implementation JMMineDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (section == 1) {
        return 4;
    }else if (section == 2) {
        return 4;
    }else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailData"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailData"];
        if (indexPath.section == 0) {
            cell.textLabel.text = @"个人头像";
            UIImageView *avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            avatar.layer.masksToBounds = YES;
            avatar.layer.cornerRadius = 25;
            NSLog(@"http://www.jialeshequ.com/%@",self.model.pic);
            [avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.jialeshequ.com/%@",self.model.pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];;
            cell.accessoryView = avatar;
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"姓名";
                cell.detailTextLabel.text = self.model.name;
            }else if (indexPath.row == 1) {
                cell.textLabel.text  = @"账号";
            }else if (indexPath.row == 2) {
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = self.model.sex == 1?@"男":@"女";
            }else if (indexPath.row == 3) {
                cell.textLabel.text = @"个性签名";
                cell.detailTextLabel.text = self.model.desc;
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"地区";
//                cell.detailTextLabel.text = self.model.;
            }else if (indexPath.row == 1) {
                cell.textLabel.text  = @"所属大学";
                cell.detailTextLabel.text = self.model.school_name;
            }else if (indexPath.row == 2) {
                cell.textLabel.text = @"绑定邮箱";
//                cell.detailTextLabel.text = self.model.sex == 0?@"男":@"女";
            }else if (indexPath.row == 3) {
                cell.textLabel.text = @"修改密码";
//                cell.detailTextLabel.text = self.model.desc;
            }
        } else {
            cell.textLabel.text = @"版本更新";
        }
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
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
