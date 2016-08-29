//
//  JMSearchViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/7.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSearchViewController.h"
#import "JMSchoolModel.h"
#import "JMLabListViewController.h"
#import "JMContainerViewController.h"
#import "JMSearchResultViewController.h"
@interface JMSearchViewController () <UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation JMSearchViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

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
    
    [self getSchoolList];
    
    [self creatUI];
}

- (void)creatSchoolButtons {
    
    int count = 0;
    float buttonWidth = 0;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        JMSchoolModel *model = self.dataArray[i];
        NSString *schoolName = model.name;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor colorWithR:242 G:242 B:242]];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:schoolName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(schoolClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        
        NSDictionary *fontDict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        CGSize buttonSize = [schoolName sizeWithAttributes:fontDict];
        
        button.width = buttonSize.width + 15;
        button.height = buttonSize.height + 12;
        
        if (i == 0) {
            button.x = 20;
            buttonWidth += CGRectGetMaxX(button.frame);
        }else {
            buttonWidth += CGRectGetMaxX(button.frame) + 20;
            if (buttonWidth > self.view.width - 20) {
                count ++;
                button.x = 20;
                buttonWidth = CGRectGetMaxX(button.frame);
            }else {
                button.x += buttonWidth - button.width;
            }
        }
        button.y += count * (button.height + 10) + 10;
        [self.view addSubview:button];
        button.tag = 1000 + i;
    }
}

- (void)schoolClicked:(UIButton *)button {
    JMSchoolModel *schoolNameTest = self.dataArray[button.tag - 1000];
    NSLog(@"%@",schoolNameTest.name);
    JMSearchResultViewController *resultVC = [[JMSearchResultViewController alloc]init];
    resultVC.searchKey = button.titleLabel.text;
    [self.navigationController pushViewController:resultVC animated:YES];
    
}

- (void)getSchoolList {
    [self.manager GET:JIALE_SCHOOL_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingTask");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"这是全部数据%@",jsonStr);
        
        NSArray *responseData = responseObject[@"data"];
        NSArray *schoolArray = [NSArray yy_modelArrayWithClass:[JMSchoolModel class] json:responseData];
        NSLog(@"%@",schoolArray);
        
        [self.dataArray addObjectsFromArray:schoolArray];
        
        [self creatSchoolButtons];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
}

- (void)creatUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
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
