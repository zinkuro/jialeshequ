//
//  JMTaskModel.h
//  JiaLeCommunity
//
//  Created by Jin on 16/8/27.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMTaskModel : NSObject

@property (nonatomic,assign) NSInteger success;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger group_id;

@property (nonatomic,assign) CGFloat money;
@property (nonatomic,strong) NSString *style;

@property (nonatomic,strong) NSString *group_name;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,assign) NSInteger school;

@property (nonatomic,strong) NSString *success_name;
@property (nonatomic,assign) NSInteger zuanye;

@property (nonatomic,strong) NSString *uname;
@property (nonatomic,strong) NSString *sys_name;

@property (nonatomic,assign) NSInteger sys;
@property (nonatomic,strong) NSString *school_name;

@property (nonatomic,assign) NSInteger sys_id;

@property (nonatomic,strong) NSString *etime;
@property (nonatomic,strong) NSString *pic;

@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,assign) NSInteger num;

@property (nonatomic,strong) NSString *stime;
@property (nonatomic,strong) NSString *uptime;
@property (nonatomic,strong) NSString *adress;
@property (nonatomic,strong) NSString *crtime;

@property (nonatomic,strong) NSString *status_name;
@property (nonatomic,strong) NSString *credit;

@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *remark;

@end
