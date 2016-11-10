//
//  JMClubDetailViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/10/6.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMClubModel;

@interface JMClubDetailViewController : UIViewController

@property (nonatomic,strong) NSString *token;

@property (nonatomic,strong) NSDictionary *requestDict;

@property (nonatomic,strong) NSString *requestURL;

@property (strong,nonatomic) UITableView *tableView;


@end
