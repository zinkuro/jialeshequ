//
//  JMMineViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMMineViewController.h"
#import "JMMineTableViewController.h"
#import "JMContainerViewController.h"
#import "JMMineTableViewController.h"
#import "JMUserModel.h"
#import "JMMineListTableViewController.h"
#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCALE (WIDTH / 414)

@interface JMMineViewController ()<JMHeaderViewChangeDelegate> {
    BOOL _isHide;
}

@property (nonatomic,strong) UIButton *editButton;

@property (nonatomic,strong) JMContainerViewController *container;

@property (nonatomic,strong) JMMineListTableViewController *statusTableViewController;

@property (nonatomic,strong) JMUserModel *userModel;

@end

@implementation JMMineViewController

- (JMMineListTableViewController *)statusTableViewController {
    if (!_statusTableViewController) {
        _statusTableViewController = [[JMMineListTableViewController alloc]init];
        _statusTableViewController.title = @"个人中心";
        _statusTableViewController.delegate = self;
    }
    return _statusTableViewController;
}

- (JMContainerViewController *)container {
    if (!_container) {
        
        _container = [[JMContainerViewController alloc]initWithControllers:@[self.statusTableViewController] topBarHeight:self.backgroundView.height parentViewController:self];
//        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 5 / 8)];
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.backgroundView.frame];
        
    }
    return _backgroundImageView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 23 / 64, WIDTH * 5 / 8 / 10, WIDTH * 9 / 32, WIDTH * 9 / 32)];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = WIDTH * 9 / 64;
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:20 * SCALE];
    }
    return _nameLabel;
}

- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        _signLabel.backgroundColor = [UIColor orangeColor];
        _signLabel.adjustsFontSizeToFitWidth = YES;
        _signLabel.numberOfLines = 0;
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _signLabel;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _editButton.backgroundColor = [UIColor clearColor];
    }
    return _editButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //value需要等待登录界面的逻辑
    NSDictionary *dict = @{@"type":@"sid",@"value":@"5120140223",@"token":self.token};
    [self.manager GET:JIALE_USER_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"userGetting");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = responseObject[@"data"][0];
//        NSLog(@"%@",responseObject[@"dict"]);
        
        _userModel = [[JMUserModel alloc]initWithDict:dataDict];
        NSLog(@"%@",_userModel);
        NSLog(@"%@",self.userModel);
        
        self.backgroundImageView.image = [UIImage imageNamed:@"199"];
        [self.avatarView sd_setImageWithURL:[NSURL URLWithString:@"http://i0.hdslb.com/bfs/face/2bc3fdc36fe82aa26a85ff8187d903d3e5987c35.jpg"] placeholderImage:[UIImage imageNamed:@""]];
        self.nameLabel.text = self.userModel.name;
        self.signLabel.text = self.userModel.desc;
//        NSData *jasonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *jasonStr = [[NSString alloc]initWithData:jasonData encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",jasonStr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errorMsg:%@",error);
    }];
//    NSLog(@"%.2f",WIDTH);
    // Do any additional setup after loading the view.
//    table.view.frame = CGRectMake(0, 0, WIDTH, self.view.height - self.backgroundView.height);
//    table.view.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:table.view];
////    [self addChildViewController:table];
    [self.view addSubview:self.container.view];
//    [self addChildViewController:self.container];
}

- (void)creatUI {
    [super creatUI];
    
    _isHide = NO;
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@" 编辑"];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 * SCALE] range:NSMakeRange(0, 3)];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"write"];
    attach.bounds = CGRectMake(0, 0, 12 * SCALE, 12 * SCALE);
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attrF = [[NSMutableAttributedString alloc]initWithAttributedString:imgStr];
    [attrF appendAttributedString:attri];
    
    [self.editButton setAttributedTitle:attrF forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTap:)];
//    [self.backgroundView addGestureRecognizer:tap];
    
    self.container.menuItemFont = [UIFont systemFontOfSize:self.view.size.width * 17 / 414.0f];
    [self.container.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.backgroundImageView];
    [self.backgroundView addSubview:self.avatarView];
    [self.backgroundView addSubview:self.nameLabel];
    [self.backgroundView addSubview:self.signLabel];
    [self.backgroundView addSubview:self.editButton];

    __weak typeof(self) weakself = self;//=============================weakself 赋值
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.avatarView.mas_bottom).offset(12 * SCALE);
        make.left.equalTo(weakself.backgroundView);
        make.right.equalTo(weakself.backgroundView);
        make.bottom.equalTo(weakself.nameLabel.mas_top).offset(weakself.view.width * 9 / 32 / 5);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(8 * SCALE);
        make.left.equalTo(weakself.backgroundView).offset(weakself.view.width / 4);
        make.right.equalTo(weakself.backgroundView).offset(- weakself.view.width / 4);
        make.bottom.equalTo(weakself.signLabel.mas_top).offset(30 * SCALE);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.signLabel.mas_bottom).offset(8 * SCALE);
        make.centerX.equalTo(weakself.signLabel);
        make.width.mas_equalTo(weakself.view.size.width / 6);
        make.bottom.equalTo(weakself.editButton.mas_top).offset(16 * SCALE);

    }];
}

- (void)editButtonClick:(UIButton *)btn {
    NSLog(@"editClicked");
}

//- (void)backgroundViewTap:(UITapGestureRecognizer *)tap {
//    NSLog(@"ViewTaped");
//    __weak typeof(self) weakself = self;
//    [UIView animateWithDuration:0.5 animations:^{
//        if (_isHide) {
//            [weakself.container.view setY:0];
//            weakself.container.contentScrollView.height = weakself.view.height - weakself.backgroundView.height - 50 - 45;
//        }else {
//            [weakself.container.view setY:- weakself.backgroundView.height + 16];
//            weakself.container.contentScrollView.height = weakself.view.height - 16 - 50 - 45;
//        }
//        _isHide = !_isHide;
//        
//    }];
//}

- (void)showHeaderView {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakself.container.view setY:0];
        weakself.container.contentScrollView.height = weakself.view.height - weakself.backgroundView.height - 50 - 45;
    }];
}

- (void)hideHeaderView {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakself.container.view setY:- weakself.backgroundView.height];
        weakself.container.contentScrollView.height = weakself.view.height - 50 - 45;
    }];
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
