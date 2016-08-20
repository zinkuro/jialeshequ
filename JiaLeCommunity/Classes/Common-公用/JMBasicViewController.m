//
//  JMBasicViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMBasicViewController.h"
#import "AppDelegate.h"
@interface JMBasicViewController ()


@end

@implementation JMBasicViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.token = delegate.token;
    NSLog(@"%@",self.token);
    [self creatUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithR:24 G:154 B:202]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)creatUI {
    UILabel *customTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    customTitle.backgroundColor = [UIColor clearColor];
    customTitle.textAlignment = NSTextAlignmentCenter;
    customTitle.font = [UIFont systemFontOfSize:18];
    customTitle.text = self.navigationItem.title;
    self.navigationItem.titleView = customTitle;
    customTitle.textColor = [UIColor whiteColor];
    
    [self creatNavButtonWithImage:@"menu" selectedImage:@"" isRight:NO];
    [self creatNavButtonWithImage:@"search" selectedImage:@"" isRight:YES];
}

- (void)creatNavButtonWithImage:(NSString *)image
                  selectedImage:(NSString *)selectedImage
                        isRight:(BOOL)isRight {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    if (isRight) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
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
