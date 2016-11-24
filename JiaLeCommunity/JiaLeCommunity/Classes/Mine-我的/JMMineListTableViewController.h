//
//  JMMineListTableViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/24.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMHeaderViewChangeDelegate <NSObject>

- (void)hideHeaderView;
- (void)showHeaderView;

@end

@interface JMMineListTableViewController : UITableViewController

@property (nonatomic,weak) id<JMHeaderViewChangeDelegate> delegate;

@end
