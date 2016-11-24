//
//  JMSysDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/8/29.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMSysDetailViewController.h"
#import "JMButton.h"
#import "JMContainerViewController.h"
#import "JMExpDetailViewController.h"
#import "JMExpMemberViewController.h"
#import "JMExpCommentViewController.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width

@interface JMSysDetailViewController ()

@property (nonatomic,strong) JMContainerViewController *container;

@property (nonatomic,strong) JMExpDetailViewController *detailVC;
@property (nonatomic,strong) JMExpMemberViewController *memberVC;
@property (nonatomic,strong) JMExpCommentViewController *commentVC;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UIView *expView;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UIButton *shareButton;
@property (nonatomic,strong) UIButton *messageButton;

@property (nonatomic,strong) UIView *headerView;

@end

@implementation JMSysDetailViewController

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _locationLabel.adjustsFontSizeToFitWidth = YES;
        _locationLabel.font = [UIFont systemFontOfSize:12];
    }
    return _locationLabel;
}

- (UIView *)expView {
    if (!_expView) {
        _expView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _expView.backgroundColor = [UIColor whiteColor];
//        _expView.clipsToBounds = YES;
        _expView.layer.cornerRadius = 8;
    }
    return _expView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.view.height * 190 / 568)];
        _headerView.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    }
    return _headerView;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc]init];
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:self.view.width * 8 / 320];
        _commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, - 8, 0, 0);
//        _commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    }
    return _commentButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc]init];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:self.view.width * 8 / 320];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, - 8, 0, 0);
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    }
    return _shareButton;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [[UIButton alloc]init];
        [_messageButton setTitle:@"消息" forState:UIControlStateNormal];
        _messageButton.titleLabel.font = [UIFont systemFontOfSize:self.view.width * 8 / 320];
        _messageButton.imageEdgeInsets = UIEdgeInsetsMake(0, - 8, 0, 0);
        [_messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_messageButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    }
    return _messageButton;
}

- (JMContainerViewController *)container {
    if (!_container) {
        _detailVC = [[JMExpDetailViewController alloc]init];
        _detailVC.title = @"详情";
        _detailVC.model = self.model;
        
        _commentVC = [[JMExpCommentViewController alloc]init];
        _commentVC.title = @"评论";
        
        _memberVC = [[JMExpMemberViewController alloc]init];
        _memberVC.title = @"成员";
        _container = [[JMContainerViewController alloc]initWithControllers:@[_detailVC,_commentVC,_memberVC] topBarHeight:self.headerView.height parentViewController:self];
        //        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    
    // Do any additional setup after loading the view.
//    self.container.view.frame = CGRectMake(0, 150, self.view.width, self.view.height - 145 - 45 - 49);
//    self.container.contentScrollView.height = self.view.height - 145 - 49 - 45;
//    self.container.contentScrollView.height = self.view.height - self.headerView.height - 50 - 45;
    self.container.menuItemFont = [UIFont systemFontOfSize:self.view.size.width * 17 / 414.0f];
    
    [self creatHeaderView];
    
    [self.container.view addSubview:self.headerView];
    
    [self.view addSubview:self.container.view];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - 45, self.view.width, 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(12, 7.5, self.view.width - 24, 30)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 3;
    button.backgroundColor = [UIColor colorWithR:24 G:154 B:202];
    [button setTitle:@"立即报名" forState:UIControlStateNormal];
    [bottomView addSubview:button];

    [self.view addSubview:bottomView];
    
    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    statusView.backgroundColor = [UIColor colorWithR:24 G:154 B:202];
    [self.view addSubview:statusView];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
//    leftButton.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void)creatHeaderView {
    _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.width,self.view.height * 125 / 568)];
    NSLog(@"%.2f",self.view.height);
    _headerImageView.image = [UIImage imageNamed:@"bg"];
    
    self.titleLabel.text = self.model.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    //1.首先你需要创建一个可变的AttributeString,里面存入你需要的字符串
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",self.model.adress]];
    //2.其次需要创建附件,这个附件是用来存放图片的
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach = [[NSTextAttachment alloc]init];
    //-->给附件传入图片
    attach.image = [UIImage imageNamed:@"实验室位置"];
    //-->给附件一个frame,默认是和普通的文字一样的坐标,如果觉得没有对齐,可以在这里更改x和y值
    //(此处小图片的宽高我进行了屏幕适配,乘以了比例)
    attach.bounds = CGRectMake(0, - 2, 10 * self.view.width / 320.0f, 12 * self.view.width / 320.0f);
    //-->将附件转换成AttributeString,供后面拼接
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
    //3.然后将附件和文字拼接起来
    NSMutableAttributedString *attrF = [[NSMutableAttributedString alloc]initWithAttributedString:imgStr];
    [attrF appendAttributedString:attri];
    //4.接下来对新生成的拼接富文本进行进一步的文本属性设置,可设置颜色,字体等;
    [attrF addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 * self.view.width / 320.0f] range:NSMakeRange(0, self.model.adress.length + 2)];
    //-->注意一下字符串的长度,我偷懒使用了一个空格设置间距,记得在length里面加上;
    [attrF addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.model.adress.length + 2)];
    //5.最后给label赋予富文本字符,此处若是UIButton,则为setAttributedTitle
    [self.locationLabel setAttributedText:attrF];
    
    self.locationLabel.textColor = [UIColor whiteColor];
//    self.locationLabel.backgroundColor = [UIColor redColor];

    [self.headerView addSubview:_headerImageView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.locationLabel];
    [self.headerView addSubview:self.expView];
    
    __weak typeof(self) weakself = self;
    UIImageView *expImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    expImageView.image = [UIImage imageNamed:@"cv"];
    expImageView.clipsToBounds = YES;
    expImageView.layer.cornerRadius = 7;
    [self.expView addSubview:expImageView];
    
    [self.expView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.headerView).offset(12);
        make.bottom.equalTo(weakself.headerView).offset(- 12);
        make.width.and.height.equalTo(weakself.headerView.mas_width).multipliedBy(96 / 320.0f);
    }];
    
    [expImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.expView).offset(1);
        make.right.equalTo(weakself.expView).offset(- 1);
        make.top.equalTo(weakself.expView).offset(1);
        make.bottom.equalTo(weakself.expView).offset(- 1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.expView.mas_right).offset(12);
        make.top.equalTo(weakself.expView);
        make.width.equalTo(weakself.headerView.mas_width).multipliedBy(3 / 8.0f);
        make.height.equalTo(weakself.headerView.mas_height).multipliedBy(1 / 5.0f);
    }];
    
//    self.locationLabel.backgroundColor = [UIColor redColor];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titleLabel);
        make.bottom.equalTo(weakself.headerImageView.mas_bottom).offset(- self.view.width * 5 / 320);
        make.width.equalTo(weakself.headerView.mas_width).multipliedBy(3 / 5.0f);
        make.height.equalTo(weakself.headerView.mas_height).multipliedBy(1 / 15.0f);
    }];

    [self.commentButton setContentMode:UIViewContentModeScaleToFill];
    
    [self.headerView addSubview:self.commentButton];
    [self.headerView addSubview:self.shareButton];
    [self.headerView addSubview:self.messageButton];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.expView.mas_right).offset(12);
        make.top.equalTo(weakself.headerImageView.mas_bottom);
        make.bottom.equalTo(weakself.headerView.mas_bottom);
        make.width.mas_equalTo((weakself.headerView.width - 24 - weakself.headerView.width * 96 / 320.0f) / 3.0f);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.commentButton.mas_right);
        make.top.equalTo(weakself.headerImageView.mas_bottom);
        make.bottom.equalTo(weakself.headerView.mas_bottom);
        make.width.equalTo(weakself.commentButton);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.shareButton.mas_right);
        make.top.equalTo(weakself.headerImageView.mas_bottom);
        make.bottom.equalTo(weakself.headerView.mas_bottom);
        make.width.equalTo(weakself.commentButton);
    }];
    
}

- (void)creatUI {
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, self.view.width, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.clipsToBounds = YES;

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
