//
//  JMLabListViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/7.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMLabListViewController.h"
#import "JMLabCollectionViewCell.h"
#import "AppDelegate.h"
#import "JMSysModel.h"
#import "JMSysDetailViewController.h"
@interface JMLabListViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation JMLabListViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (void)labListRequest {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.token = delegate.token;
    
    NSDictionary *dict = @{@"token":self.token,@"school":@16};
    
    [self.manager GET:JIALE_TASK_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"labListLoading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *resultArray = responseObject[@"data"];
//        NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSArray *sysArray = [NSArray yy_modelArrayWithClass:[JMSysModel class] json:resultArray];
        NSLog(@"%@",sysArray);
        
        [self.dataArray addObjectsFromArray:sysArray];
        NSLog(@"%@",self.dataArray);
        [self.collectionView reloadData];
//        NSString *jsonStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"这是全部数据%@",jsonStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height - 64 - 45 - 49) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self labListRequest];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"JMLabCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    // Do any additional setup after loading the view.
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat W = (self.view.size.width - 35) / 2.0f;
    CGFloat H = W * 132 / 142.0f;
    
    return CGSizeMake(W, H);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMLabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    JMSysModel *model = self.dataArray[indexPath.row];
//    NSLog(@"%@",model);
    cell.model = model;
    cell.layer.cornerRadius = 8.0f;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JMSysModel *model = self.dataArray[indexPath.row];
    JMSysDetailViewController *detailVC = [[JMSysDetailViewController alloc]init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
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
