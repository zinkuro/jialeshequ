//
//  JMReplyDetailTableViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 2016/12/4.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMReplyModel;
@interface JMReplyDetailTableViewController : UITableViewController
@property (nonatomic,strong) JMReplyModel *model;
@property (nonatomic,strong) NSString *token;
@end
