//
//  JMStatusTableViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/9/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMStatusTableViewController : UIViewController

@property (nonatomic,assign) BOOL isTP;

@property (nonatomic,strong) NSString *token;

@property (nonatomic,strong) NSDictionary *requestDict;

@property (nonatomic,strong) NSString *requestURL;

@property (strong,nonatomic) UITableView *tableView;

@end
