//
//  JMBasicViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPSessionManager.h>
@interface JMBasicViewController : UIViewController

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (nonatomic,strong) NSString *token;

- (void)creatUI;

@end
