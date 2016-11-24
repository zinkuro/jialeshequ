//
//  JMChatViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMChatViewController.h"

@interface JMChatViewController ()

@end

@implementation JMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor greenColor];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(0);//使左边等于self.view的左边，间距为0
//        make.top.equalTo(self.view.mas_top).offset(0);//使顶部与self.view的间距为0
//        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);//设置宽度为self.view的一半，multipliedBy是倍数的意思，也就是，使宽度等于self.view宽度的0.5倍
//        make.height.equalTo(self.view.mas_height).multipliedBy(0.5);//设置高度为self.view高度的一半
        make.left.top.equalTo(@10);
        make.right.bottom.equalTo(@-10);
        
    }];
    // Do any additional setup after loading the view.
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
