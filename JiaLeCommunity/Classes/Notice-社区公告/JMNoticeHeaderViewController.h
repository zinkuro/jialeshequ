//
//  JMNoticeHeaderViewController.h
//  JiaLeCommunity
//
//  Created by Jin on 16/7/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMNoticeHeaderViewController : UIViewController

@property (nonatomic,strong) NSArray *headerImageArray;
@property (nonatomic,strong) NSArray *labelTextArray;


- (instancetype)initWithHeaderImageArray:(NSArray *)headerImageArray
                          labelTextArray:(NSArray *)labelTextArray;


@end
