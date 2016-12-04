//
//  JMMineListTableViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/24.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMUserModel;
@protocol JMHeaderViewChangeDelegate <NSObject>

- (void)hideHeaderView;
- (void)showHeaderView;

@end

@interface JMMineListTableViewController : UITableViewController

@property (nonatomic,weak) id<JMHeaderViewChangeDelegate> delegate;
@property (nonatomic,strong) JMUserModel *model;
@end
