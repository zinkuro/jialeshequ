//
//  JMNoticeHeaderViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/7/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMNoticeHeaderViewController.h"
#import "JMButton.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
static const NSInteger TAG_NUM = 100;

@interface JMNoticeHeaderViewController() <UIScrollViewDelegate> {
    NSTimer *_timer;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation JMNoticeHeaderViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 14 / 32)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((WIDTH - 30) / 2, WIDTH * 14 / 32 - 22, 30, 15)];
    }
    return _pageControl;
}

- (instancetype)initWithHeaderImageArray:(NSArray *)headerImageArray
                          labelTextArray:(NSArray *)labelTextArray {
    if (self = [super init]) {
        _headerImageArray = headerImageArray;
        _labelTextArray = labelTextArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(timerGo) userInfo:@"???" repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
}

- (void)scrollTimer {
    
}

- (void)creatUI {
    
    for (int i = 0; i <= self.headerImageArray.count + 1; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, WIDTH * 14 / 32)];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:self.headerImageArray[self.headerImageArray.count - 1]];
        }else if (i == self.headerImageArray.count + 1) {
            imageView.image = [UIImage imageNamed:self.headerImageArray[0]];
        }else {
            imageView.image = [UIImage imageNamed:self.headerImageArray[i - 1]];
        }
        
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(WIDTH * (self.headerImageArray.count + 2), WIDTH * 14 / 32);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    [self.view addSubview:self.scrollView];
    
    self.pageControl.numberOfPages = self.headerImageArray.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    [self.pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    //btn按照接口 最好改为可变的count=========================================
    for (int j = 0; j < 4; j++) {
        JMButton *btn = [[JMButton alloc]initWithFrame:CGRectMake(j * WIDTH / 4, WIDTH * 14 / 32, WIDTH / 4, WIDTH / 4 * 10 / 9)];
        btn.backgroundColor = [UIColor clearColor];
        btn.roundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"i%d",j]];
        btn.labelView.text = self.labelTextArray[j];
        [self.view addSubview:btn];
        btn.tag = j + TAG_NUM;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    for (int k = 1; k < 4; k++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(k * WIDTH / 4.0f - 0.25, self.scrollView.frame.size.height + WIDTH * 10 / 4 / 9 / 9.0f, 0.5,WIDTH * 10 * 7 / 4 / 9 / 9.0f)];
        line.backgroundColor = [UIColor colorWithR:230 G:230 B:230];
        [self.view addSubview:line];
    }

}

- (void)click:(JMButton *)button {
    NSLog(@"%ld",button.tag);
}

- (void)timerGo {
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + WIDTH, 0);
    }];
    
    if (self.scrollView.contentOffset.x > WIDTH * self.headerImageArray.count) {
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
    
    int i = self.scrollView.contentOffset.x / WIDTH;
    self.pageControl.currentPage = i - 1;
}
#pragma mark - UIPageControl的事件
- (void)pageControlClick:(UIPageControl *)pageControl {
    
    NSInteger i = self.pageControl.currentPage;
    
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(WIDTH * (i + 1), 0);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger i = self.scrollView.contentOffset.x / WIDTH;
    if (i == 0) {
        i = self.headerImageArray.count;
    }else if (i == self.headerImageArray.count + 1){
        i = 1;
    }
    
    self.pageControl.currentPage = i - 1;
    
    self.scrollView.contentOffset = CGPointMake(WIDTH * i, 0);
    
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
