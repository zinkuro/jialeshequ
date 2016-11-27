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
@property (nonatomic,strong) NSMutableArray *schoolArray;
@property (nonatomic,strong) NSMutableArray *labArray;

@property (nonatomic,strong) UIScrollView *schoolScrollView;
@property (nonatomic,strong) UIScrollView *labScrollView;

@end

@implementation JMSearchViewController

- (UIScrollView *)schoolScrollView {
    if (!_schoolScrollView) {
        _schoolScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width / 2, self.view.bounds.size.height - 49 - 30)];
        _schoolScrollView.showsVerticalScrollIndicator = NO;

    }
    return _schoolScrollView;
}

- (UIScrollView *)labScrollView {
    if (!_labScrollView) {
        _labScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 30, self.view.bounds.size.width / 2, self.view.bounds.size.height - 49 - 30)];
        _labScrollView.showsVerticalScrollIndicator = NO;
    }
    return _labScrollView;
}

- (NSMutableArray *)schoolArray {
    if (!_schoolArray) {
        _schoolArray = [NSMutableArray array];
    }
    return _schoolArray;
}

- (NSMutableArray *)labArray {
    if (!_labArray) {
        _labArray = [NSMutableArray array];
    }
    return _labArray;
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
    [self creatUI];
    
    [self.view addSubview:self.schoolScrollView];
    [self.view addSubview:self.labScrollView];
    
    [self getSchoolList];
    UITapGestureRecognizer *resignTextTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignText)];
    [self.schoolScrollView addGestureRecognizer:resignTextTap];
    [self.labScrollView addGestureRecognizer:resignTextTap];
}

- (void)creatSysButtons {
    for (UIButton *button in self.labScrollView.subviews) {
        [button removeFromSuperview];
    }
    
    [self creatButtonsWithArray:self.labArray inScorllView:self.labScrollView];
}

- (void)creatSchoolButtons {
    [self creatButtonsWithArray:self.schoolArray inScorllView:self.schoolScrollView];
}

- (void)creatButtonsWithArray:(NSMutableArray *)array
                 inScorllView:(UIScrollView *)scrollView {
    
    //    int count = 0;
    //    float buttonWidth = 0;
    for (int i = 0; i < array.count; i++) {
        JMSchoolModel *model = array[i];
        NSString *schoolName = model.name;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor colorWithR:242 G:242 B:242]];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:schoolName forState:UIControlStateNormal];
        if ([array isEqualToArray:self.schoolArray]) {
            [button addTarget:self action:@selector(schoolClicked:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [button addTarget:self action:@selector(sysClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        
        NSDictionary *fontDict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
        CGSize buttonSize = [schoolName sizeWithAttributes:fontDict];
        
        button.width = buttonSize.width + 15;
        button.height = buttonSize.height + 12;
        button.center = CGPointMake(self.view.width / 4, 30 * i + 20);
        //
        //        if (i == 0) {
        //            button.x = 20;
        //            buttonWidth += CGRectGetMaxX(button.frame);
        //        }else {
        //            buttonWidth += CGRectGetMaxX(button.frame) + 20;
        //            if (buttonWidth > self.view.width - 20) {
        //                count ++;
        //                button.x = 20;
        //                buttonWidth = CGRectGetMaxX(button.frame);
        //            }else {
        //                button.x += buttonWidth - button.width;
        //            }
        //        }
        //        button.y += count * (button.height + 10) + 10;
        [scrollView addSubview:button];
        button.tag = 1000 + i;
    }
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width / 2, array.count * 35);
    if ([array isEqualToArray:self.labArray]) {
        [array removeAllObjects];
    }
}

- (void) sysClicked:(UIButton *)button {
    
        JMSearchResultViewController *resultVC = [[JMSearchResultViewController alloc]init];
        resultVC.searchKey = button.titleLabel.text;
        [self.navigationController pushViewController:resultVC animated:YES];
}

- (void)schoolClicked:(UIButton *)button {
    JMSchoolModel *school = self.schoolArray[button.tag - 1000];
    NSLog(@"%zd",school.school_id);
    
    [self getSysListWithSchoolID:school.school_id];
    
    
}

- (void)getSysListWithSchoolID:(NSInteger)school_id {
    NSDictionary *dict = @{@"schoolid":[NSNumber numberWithInteger:school_id]};
    [self.manager GET:JIALE_SYS_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"sysGetting");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *responseData = responseObject[@"data"];
        NSArray *sysDataArray = [NSArray yy_modelArrayWithClass:[JMSchoolModel class] json:responseData];
        if (sysDataArray.count > 0) {
            [self.labArray addObjectsFromArray:sysDataArray];
        }else {
            [self.labArray removeAllObjects];
        }
        
        [self creatSysButtons];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)getSchoolList {
    [self.manager GET:JIALE_SCHOOL_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"gettingTask");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"这是全部数据%@",jsonStr);
        
        NSArray *responseData = responseObject[@"data"];
        NSArray *schoolDataArray = [NSArray yy_modelArrayWithClass:[JMSchoolModel class] json:responseData];
        
        [self.schoolArray addObjectsFromArray:schoolDataArray];
        
        [self creatSchoolButtons];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
}

- (void)creatUI {
    NSArray *labelArray = @[@"选择学院",@"选择实验室"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * self.view.width / 2, 0, self.view.width / 2, 30)];
        [button setTitle:labelArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(schoolLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor colorWithR:242 G:242 B:242]] forState:UIControlStateHighlighted];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor whiteColor];
//        button.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
        button.tag = 500 + i;
        
        [self.view addSubview:button];
    }
    
    [self.view addSubview:self.schoolScrollView];
    
    self.labScrollView.contentSize = CGSizeMake(self.view.bounds.size.width / 2, self.view.bounds.size.height);
    [self.view addSubview:self.labScrollView];
    
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

- (void)schoolLabelClick:(UIButton *)button {
}

- (void)cancelClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resignText {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
