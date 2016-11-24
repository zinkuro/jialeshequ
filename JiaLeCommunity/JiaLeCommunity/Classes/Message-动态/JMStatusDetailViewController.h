//
//  JMStatusDetailViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/11/10.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMStatusModel;

@interface JMStatusDetailViewController : UIViewController

@property (nonatomic,strong) NSString *token;

@property (nonatomic,strong) NSDictionary *requestDict;

@property (nonatomic,strong) NSString *requestURL;

@property (nonatomic,strong) JMStatusModel *model;

@end
