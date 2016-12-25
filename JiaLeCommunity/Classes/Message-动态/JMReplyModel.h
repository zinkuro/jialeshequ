//
//  replyModel.h
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/24.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMReplyModel : NSObject

@property (nonatomic,strong) NSString *reply_id;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *uname;
@property (nonatomic,strong) NSString *fname;

@property (nonatomic,strong) NSArray <JMReplyModel *> *child;

@property (nonatomic,assign) CGFloat cellHeight;

@end
