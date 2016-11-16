//
//  SecondViewController.m
//  photoTest
//
//  Created by Jin on 2016/11/16.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation SecondViewController



- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    self.scrollView = self.scrollView;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [imageView addGestureRecognizer:doubleTap];//添加双击手势
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    [self setImage:[UIImage imageNamed:@"5"]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setImage:(UIImage *)image{
    self.imageView.image = image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat maxHeight = self.scrollView.bounds.size.height;
    CGFloat maxWidth = self.scrollView.bounds.size.width;
    //如果图片尺寸大于view尺寸，按比例缩放
    if(width > maxWidth || height > width){
        CGFloat ratio = height / width;
        CGFloat maxRatio = maxHeight / maxWidth;
        if(ratio < maxRatio){
            width = maxWidth;
            height = width * ratio;
        }else{
            height = maxHeight;
            width = height / ratio;
        }
    }
    self.imageView.frame = CGRectMake((maxWidth - width) / 2.0f, (maxHeight - height)/2.0f, width, height);
}

#pragma mark UIScrollViewDelegate
//指定缩放UIScrolleView时，缩放UIImageView来适配
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

//缩放后让图片显示到屏幕中间
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize originalSize = self.scrollView.bounds.size;
    CGSize contentSize = self.scrollView.contentSize;
    CGFloat offsetX = originalSize.width > contentSize.width ? (originalSize.width - contentSize.width) / 2:0;
    CGFloat offsetY = originalSize.height > contentSize.height ? (originalSize.height - contentSize.height) / 2:0;
    self.imageView.center = CGPointMake(contentSize.width / 2 + offsetX, contentSize.height / 2 + offsetY);
}


- (void)handleDoubleTap:(UITapGestureRecognizer *)recongnizer
{
    UIGestureRecognizerState state = recongnizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            //以点击点为中心，放大图片
            CGPoint touchPoint = [recongnizer locationInView:recongnizer.view];
            BOOL zoomOut = self.scrollView.zoomScale == self.scrollView.minimumZoomScale;
            CGFloat scale = zoomOut ? self.scrollView.maximumZoomScale:self.scrollView.minimumZoomScale;
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.zoomScale = scale;
                if(zoomOut){
                    CGFloat x = touchPoint.x * scale - self.scrollView.bounds.size.width / 2;
                    CGFloat maxX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
                    CGFloat minX = 0;
                    x = x > maxX ? maxX:x;
                    x = x < minX ? minX:x;
                    
                    CGFloat y = touchPoint.y * scale - self.scrollView.bounds.size.height /2;
                    CGFloat maxY = self.scrollView.contentSize.height-self.scrollView.bounds.size.height;
                    CGFloat minY = 0;
                    y = y > maxY ? maxY:y;
                    y = y < minY ? minY:y;
                    self.scrollView.contentOffset = CGPointMake(x, y);
                }
            }];
            
        }
            break;
        default:break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
