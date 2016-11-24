//
//  JMStatusModel.h
//  JiaLeCommunity
//
//  Created by Jin on 16/9/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMStatusModel : NSObject

@property (nonatomic,assign) NSInteger post_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,assign) NSInteger zan_num;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger comment_num;
@property (nonatomic,assign) NSInteger sc_num;
@property (nonatomic,strong) NSArray *imgs;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *note_key;
@property (nonatomic,strong) NSString *uptime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *seeTime;
@property (nonatomic,assign) CGFloat cellHeight;

@end
