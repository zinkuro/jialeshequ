//
//  UIImage+JMExtension.m
//  JiaLeCommunity
//
//  Created by Jin on 16/9/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "UIImage+JMExtension.h"

@implementation UIImage (JMExtension)

- (UIImage *)transformWidth:(CGFloat)width
                     height:(CGFloat)height {
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap =CGBitmapContextCreate(NULL, destW, destH, CGImageGetBitsPerComponent(imageRef), 4 * destW, CGImageGetColorSpace(imageRef), kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

@end
