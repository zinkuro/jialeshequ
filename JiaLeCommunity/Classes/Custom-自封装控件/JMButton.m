//
//  JMButton.m
//  JMButton
//
//  Created by Jin on 16/7/4.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMButton.h"

@implementation JMButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _roundImageView = [[UIImageView alloc]init];
        _roundImageView.frame = CGRectMake(0, 0, frame.size.height / 2, frame.size.height / 2);
        _roundImageView.center = CGPointMake(frame.size.width / 2, frame.size.height * 5 / 12);
        //_roundImageView.layer.masksToBounds = YES;
        //_roundImageView.layer.cornerRadius = _roundImageView.frame.size.height / 2;
        [self addSubview:_roundImageView];
        
        _labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height * 2 / 3, frame.size.width, frame.size.height / 3)];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.font = [UIFont systemFontOfSize:14];
        _labelView.textColor = [UIColor colorWithR:102 G:102 B:102];
        [self addSubview:_labelView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
