//
//  JMSearchViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/7.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSearchViewController.h"

@interface JMSearchViewController () <UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation JMSearchViewController

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _searchBar.showsCancelButton = NO;
        _searchBar.placeholder = @"搜索实验";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)cancelClick {
    [self.navigationController popViewControllerAnimated:NO];
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
