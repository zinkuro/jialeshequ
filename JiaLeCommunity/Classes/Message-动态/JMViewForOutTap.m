//
//  JMViewForOutTap.m
//  JiaLeCommunity
//
//  Created by Jin on 16/11/10.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMViewForOutTap.h"

@implementation JMViewForOutTap

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];

    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

@end
