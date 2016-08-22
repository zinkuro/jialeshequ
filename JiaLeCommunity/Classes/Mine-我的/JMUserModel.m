//
//  JMUserModel.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/22.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMUserModel.h"

@implementation JMUserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.user_id = value;
    }
}

@end
