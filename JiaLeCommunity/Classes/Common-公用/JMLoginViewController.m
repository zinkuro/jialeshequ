//
//  JMLoginViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMLoginViewController.h"
#import "JMTabBarController.h"
#import "AppDelegate.h"
@interface JMLoginViewController ()

@end

@implementation JMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [button addTarget:self action:@selector(touchButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"jump" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    NSDictionary *dict = @{@"sid":@"5120140223",@"password":@"123123"};

    [self postDataWithUrl:JIALE_LOGIN_URL Dict:dict];
    
}

- (void)postDataWithUrl:(NSString *)url
                  Dict:(NSDictionary *)dict {
    
    [self.manager POST:url parameters:(NSDictionary *)dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        //        NSLog(@"%@",responseObject[@"msg"]);
//        NSLog(@"%@",responseObject);
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        delegate.token = responseObject[@"data"][@"token"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)touchButton {
    JMTabBarController *tabBarVC = [[JMTabBarController alloc]init];
    [self presentViewController:tabBarVC animated:YES completion:nil];
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
