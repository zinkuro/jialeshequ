//
//  JMTabBarController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMTabBarController.h"
#import "JMNoticeViewController.h"
#import "JMMessageViewController.h"
#import "JMLabViewController.h"
#import "JMChatViewController.h"
#import "JMMineViewController.h"

@interface JMTabBarController ()

@end

@implementation JMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatChildControllerWithVc:[[JMNoticeViewController alloc]init] Title:@"社区公告" image:@"notice" selectedImage:@""];
    
    [self creatChildControllerWithVc:[[JMMessageViewController alloc]init] Title:@"动态" image:@"message" selectedImage:@""];
    
    [self creatChildControllerWithVc:[[JMLabViewController alloc]init] Title:@"实验室" image:@"lab" selectedImage:@""];
    
    [self creatChildControllerWithVc:[[JMChatViewController alloc]init] Title:@"聊天" image:@"chat" selectedImage:@""];
    
    [self creatChildControllerWithVc:[[JMMineViewController alloc]init] Title:@"个人中心" image:@"mine" selectedImage:@""];
    // Do any additional setup after loading the view.
}

- (void)creatChildControllerWithVc:(UIViewController *)vc
                             Title:(NSString *)title
                                image:(NSString *)image
                     selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    vc.view.backgroundColor = [UIColor colorWithR:arc4random()%256 G:arc4random()%256 B:arc4random()%256];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
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
