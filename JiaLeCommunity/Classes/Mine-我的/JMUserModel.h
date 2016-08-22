//
//  JMUserModel.h
//  JiaLeCommunity
//
//  Created by Jin on 16/8/22.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMUserModel : NSObject

@property (nonatomic,strong) NSString *group_id;
@property (nonatomic,strong) NSString *dsid;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,assign) NSInteger school;
@property (nonatomic,strong) NSString *majorl_name;
@property (nonatomic,assign) NSInteger major;
@property (nonatomic,assign) NSInteger major_type;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *school_name;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *pwd;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *uptime;
@property (nonatomic,strong) NSString *crtime;
@property (nonatomic,strong) NSString *credit;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,assign) NSInteger online;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
