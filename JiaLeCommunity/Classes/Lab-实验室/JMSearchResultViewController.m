//
//  JMSearchResultViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/25.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSearchResultViewController.h"
#import "JMContainerViewController.h"
#import "JMLabListViewController.h"
@interface JMSearchResultViewController ()

@property (nonatomic,strong) JMContainerViewController *container;

@property (nonatomic,strong) JMLabListViewController *resultList;

@end

@implementation JMSearchResultViewController

- (JMContainerViewController *)container {
    if (!_container) {
        _resultList = [[JMLabListViewController alloc]init];
        _resultList.title = self.searchKey;
        
        _container = [[JMContainerViewController alloc]initWithControllers:@[_resultList] topBarHeight:0 parentViewController:self];
        _container.menuItemFont = [UIFont systemFontOfSize:12];
        //        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索结果";
    [super creatUI];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    leftButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.navigationItem.rightBarButtonItem = nil;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.container.view];
    // Do any additional setup after loading the view.
}

- (void)cancelClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
