//
//  JMClubTypeModel.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/4.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMClubTypeModel.h"

@implementation JMClubTypeModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type_id" : @"id"};
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.type_id = value;
//    }
//}


@end
