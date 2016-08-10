//
//  JMMineTableViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/7/8.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMHeaderViewChangeDelegate <NSObject>

- (void)hideHeaderView;
- (void)showHeaderView;

@end

@interface JMMineTableViewController : UITableViewController

@property (nonatomic,weak) id<JMHeaderViewChangeDelegate> delegate;

@end
