//
//  JMExpDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/30.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMExpDetailViewController.h"
#import "JMButton.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width

@interface JMExpDetailViewController ()

@end

@implementation JMExpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
////#warning Incomplete implementation, return the number of sections
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return WIDTH / 4 * 10 / 9 * 2;
    }else if (indexPath.row == 1) {
        return [self getHeightWithDesc:self.model.desc font:[UIFont systemFontOfSize:self.view.width * 12 / 320.0f]];
    }
    return 50;
}

- (CGFloat)getHeightWithDesc:(NSString *)desc
                        font:(UIFont *)font {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width - 24, 0)];
    label.text = desc;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height + 50;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    NSArray *labelTextArray = @[self.model.group_name,self.model.credit,self.model.uname,[NSString stringWithFormat:@"%zd",self.model.num],self.model.school_name,self.model.sys_name,self.model.stime,self.model.etime];
    if (indexPath.row == 0) {
        for (int j = 0; j < 8; j++) {
            
            //        NSLog(@"-%d--%d",j%4,j/4);
            
            JMButton *btn = [[JMButton alloc]initWithFrame:CGRectMake((j % 4) * WIDTH / 4, (j / 4) * WIDTH / 4 * 10 / 9, WIDTH / 4, WIDTH / 4 * 10 / 9)];
            //        btn.backgroundColor = [UIColor redColor];
            
            btn.backgroundColor = [UIColor clearColor];
            btn.roundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d",j + 1]];
            btn.labelView.font = [UIFont systemFontOfSize:11];
            
            btn.labelView.text = labelTextArray[j];
            
            btn.labelView.width = WIDTH / 4;
            btn.labelView.numberOfLines = 0;
            
            [cell.contentView addSubview:btn];
            btn.userInteractionEnabled = NO;
        }

    }
    
    if (indexPath.row == 1) {
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, cell.contentView.width, 12)];
        headLabel.text = @"实验简介";
        headLabel.font = [UIFont systemFontOfSize:self.view.width * 12 / 320.0f];
        [cell.contentView addSubview:headLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = [UIFont systemFontOfSize:self.view.width * 12 / 320.0f];
        label.textColor = [UIColor colorWithR:113 G:113 B:113];
        label.numberOfLines = 0;
        label.text = self.model.desc;
        [label sizeToFit];
        [cell.contentView addSubview:label];
//        __weak typeof(self) weakself = self;
//        label.backgroundColor = [UIColor grayColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(12);
            make.right.equalTo(cell.contentView).offset(- 12);
            make.top.equalTo(cell.contentView).offset(12);
            make.bottom.equalTo(cell.contentView).offset(- 12);
        }];
    }
    
    if (indexPath.row == 2) {
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, cell.contentView.width, 12)];
        headLabel.text = @"附件下载";
        headLabel.font = [UIFont systemFontOfSize:self.view.width * 12 / 320.0f];
        [cell.contentView addSubview:headLabel];
        
        UILabel *attachLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, cell.contentView.width, 12)];
        attachLabel.textColor = [UIColor colorWithR:26 G:143 B:183];
        attachLabel.font = [UIFont systemFontOfSize:self.view.width * 12 / 320.0f];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"附件"]];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        
        attachLabel.attributedText = content;
        [cell.contentView addSubview:attachLabel];

    }
    
    if (indexPath.row == 3) {
    
    }
    
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
