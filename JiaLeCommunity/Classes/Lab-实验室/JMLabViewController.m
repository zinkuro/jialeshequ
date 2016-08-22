//
//  JMLabViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMLabViewController.h"
#import "JMContainerViewController.h"
#import "JMLabListViewController.h"
#import "JMSearchViewController.h"
@interface JMLabViewController () <UISearchBarDelegate>

@property (nonatomic,strong) JMContainerViewController *container;
@property (nonatomic,strong) JMLabListViewController *labList;
@property (nonatomic,strong) JMLabListViewController *myLabList;
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation JMLabViewController


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _searchBar.showsCancelButton = NO;
        _searchBar.placeholder = @"搜索实验";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (JMContainerViewController *)container {
    if (!_container) {
        _labList = [[JMLabListViewController alloc]init];
        _labList.title = @"进行中实验";
        _myLabList = [[JMLabListViewController alloc]init];
        _myLabList.title = @"已完成实验";
        _container = [[JMContainerViewController alloc]initWithControllers:@[_labList,_myLabList] topBarHeight:0 parentViewController:self];
        //        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.container.menuItemFont = [UIFont systemFontOfSize:self.view.size.width * 15 / 414.0f];
    self.navigationItem.titleView = self.searchBar;
    NSLog(@"%@",self.token);
    NSDictionary *dict = @{@"school":@"16",@"token":self.token};
    [self.manager GET:JIALE_TASK_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingTask");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"这是全部数据%@",jsonStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
//    self.container.contentScrollView.canCancelContentTouches = NO;
    [self.view addSubview:self.container.view];
    

    // Do any additional setup after loading the view.
}

- (void)searchClick {
    [self jumpToSearchViewController];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self jumpToSearchViewController];
}

- (void)jumpToSearchViewController {
    
    JMSearchViewController *searchVC = [[JMSearchViewController alloc]init];

    [self.navigationController pushViewController:searchVC animated:NO];

}

- (void)creatUI {
    [super creatUI];
    
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
