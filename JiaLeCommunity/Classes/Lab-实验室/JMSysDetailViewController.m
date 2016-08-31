//
//  JMSysDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/29.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSysDetailViewController.h"
#import "JMButton.h"
#import "JMContainerViewController.h"
#import "JMExpDetailViewController.h"

@interface JMSysDetailViewController ()

@property (nonatomic,strong) JMContainerViewController *container;

@property (nonatomic,strong) JMExpDetailViewController *expDetail;

@end

@implementation JMSysDetailViewController

- (JMContainerViewController *)container {
    if (!_container) {
        _expDetail = [[JMExpDetailViewController alloc]init];
        _expDetail.title = @"进行中实验";
        _expDetail.model = self.model;
        
        _container = [[JMContainerViewController alloc]initWithControllers:@[_expDetail] topBarHeight:0 parentViewController:self];
        //        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
    self.container.view.frame = CGRectMake(0, 150, self.view.width, self.view.height - 145 - 45 - 49);
    self.container.contentScrollView.height = self.view.height - 145 - 49 - 45;
    NSLog(@"%@",self.model);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, 125)];
    imageView.image = [UIImage imageNamed:@"199"];
    [self.view addSubview:imageView];
    
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    statusView.backgroundColor = [UIColor colorWithR:24 G:154 B:202];
    [self.view addSubview:statusView];
    
    [self.view addSubview:self.container.view];
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
//    leftButton.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void)creatUI {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, self.view.width, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.clipsToBounds = YES;

}

- (void)cancelClick {
    [self.navigationController popViewControllerAnimated:YES];
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
