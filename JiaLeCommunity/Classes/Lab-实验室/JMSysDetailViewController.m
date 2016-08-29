//
//  JMSysDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/29.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSysDetailViewController.h"
#import "JMButton.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
static const NSInteger TAG_NUM = 100;

@interface JMSysDetailViewController ()

@end

@implementation JMSysDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    NSLog(@"%@",self.model);
    NSArray *labelTextArray = @[self.model.group_name,self.model.credit,self.model.uname,[NSString stringWithFormat:@"%zd",self.model.num],self.model.school_name,self.model.sys_name,self.model.stime,self.model.etime];
    for (int j = 0; j < 8; j++) {
        
//        NSLog(@"-%d--%d",j%4,j%2);
        
        JMButton *btn = [[JMButton alloc]initWithFrame:CGRectMake((j % 4) * WIDTH / 4, 200 + (j / 4) * WIDTH / 4 * 10 / 9, WIDTH / 4, WIDTH / 4 * 10 / 9)];
//        btn.backgroundColor = [UIColor redColor];
        
        btn.backgroundColor = [UIColor clearColor];
        btn.roundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d",j + 1]];
        btn.labelView.font = [UIFont systemFontOfSize:11];

        btn.labelView.text = labelTextArray[j];
        
        btn.labelView.width = WIDTH / 4;
        btn.labelView.numberOfLines = 0;
        
        [self.view addSubview:btn];
        btn.tag = j + TAG_NUM;
        btn.userInteractionEnabled = NO;
        [self.view addSubview:btn];
    }
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, 200)];
//    imageView.image = [UIImage imageNamed:@"199"];
//    [self.view addSubview:imageView];
    
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    statusView.backgroundColor = [UIColor colorWithR:24 G:154 B:202];
    [self.view addSubview:statusView];
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
//    leftButton.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    self.navigationItem.rightBarButtonItem = nil;
    
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
