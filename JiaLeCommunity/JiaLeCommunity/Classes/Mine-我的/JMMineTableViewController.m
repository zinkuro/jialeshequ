//
//  JMMineTableViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/7/8.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMMineTableViewController.h"
#import "JMMineCell.h"
#import "JMMineCellModel.h"
@interface JMMineTableViewController ()

@property (nonatomic,strong) JMMineCellModel *model;

@end

@implementation JMMineTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _model = [[JMMineCellModel alloc]init];
    _model.imageURL = @"http://i0.hdslb.com/bfs/face/2bc3fdc36fe82aa26a85ff8187d903d3e5987c35.jpg";
    _model.timeString = @"2016-06-25 09:06";
    _model.nameString = @"嘿嘿";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"参加了活动 [元旦高新摄影比赛]测试换行功能测试换行功能换行测试换行测试换行测试换行测试"];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithR:95 G:151 B:182] range:NSMakeRange(6, 10)];
//    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:0] range:NSMakeRange(0, (attri.length - 1))];
    

    _model.statusString = attri;
    self.tableView.separatorStyle = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMMineCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _model;
    // Configure the cell...
    
    return cell;
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
