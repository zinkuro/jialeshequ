//
//  JMLabListViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/7.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMLabListViewController.h"
#import "JMLabCollectionViewCell.h"
@interface JMLabListViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation JMLabListViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMLabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 8.0f;
    return cell;
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
