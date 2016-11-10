//
//  JMLoginViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/9/25.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMLoginViewController.h"
#import "JMTabBarController.h"
#import "AppDelegate.h"
#import "JMButton.h"
#import "JMPostMessageViewController.h"
#import "CustomPresentAnimationCotroller.h"


@interface JMLoginViewController () <UIViewControllerTransitioningDelegate>



@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong,nonatomic) UIButton *isHiddenButton;
@property (assign,nonatomic) BOOL isHiddenPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation JMLoginViewController
static id _instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithR:0 G:0 B:0 alpha:.5]];
    [SVProgressHUD setMinimumDismissTimeInterval:.5];
    
    
    CGFloat buttonWidth = 80.0;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 3 * buttonWidth) / 4.0;

    //Xib创建出来的东西用MJExtention返回的会是Xib里面的尺寸
    NSArray *logos = @[@"QQ",@"wechat",@"sina"];
    NSArray *names = @[@"QQ",@"微信",@"新浪"];
    for (int i = 0; i < 3; i ++) {
        
        JMButton *thirdButton = [[JMButton alloc]initWithFrame:CGRectMake(i * buttonWidth + (i + 1) * margin, [UIScreen mainScreen].bounds.size.height - 40 - buttonWidth, buttonWidth, buttonWidth)];
//        margin; 0
//        2 * margin + 100; 1
//        3 * margin + 2 * 100; 2
//        thirdButton.backgroundColor = [UIColor cyanColor];
        thirdButton.roundImageView.image = [UIImage imageNamed:logos[i]];
        thirdButton.labelView.text = names[i];
        thirdButton.labelView.textColor = [UIColor colorWithR:144 G:144 B:144];
        [self.view addSubview:thirdButton];
        
    }
    
    self.avatarImageView.layer.cornerRadius = 40;
    self.loginButton.layer.cornerRadius = 5;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    self.avatarImageView.image = [UIImage imageNamed:@"logo"];
    self.idTextField.placeholder = @"账号/手机号/邮箱";
    self.idTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.idTextField.text = [user valueForKey:@"userId"];
    
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.text = [user valueForKey:@"userPassword"];
    
    self.isHiddenButton = [self.passwordTextField valueForKey:@"_clearButton"];
    [self.isHiddenButton addTarget:self action:@selector(showPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.isHiddenButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
    [self.isHiddenButton setImage:[UIImage imageNamed:@"shown"] forState:UIControlStateHighlighted];
    self.isHiddenPassword = NO;

    UITapGestureRecognizer *tapToResign = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignText)];
    [self.view addGestureRecognizer:tapToResign];
    
}

- (void)resignText {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}

- (IBAction)loginButtonTouched:(UIButton *)sender {
    
    if (self.idTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"账号或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //    NSDictionary *dict = @{@"sid":@"5120140223",@"password":@"123123"};
        
        NSDictionary *dict = @{@"sid":self.idTextField.text,@"password":self.passwordTextField.text};
        //    }
        
        [self postDataWithUrl:JIALE_LOGIN_URL Dict:dict];

    }
    
}

- (void)postDataWithUrl:(NSString *)url
                   Dict:(NSDictionary *)dict {
    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    delegate.token = @"tokenTest";
  
//    JMTabBarController *tabBarVC = [[JMTabBarController alloc]init];
//    [self presentViewController:tabBarVC animated:YES completion:nil];
//
    [self.manager POST:url parameters:(NSDictionary *)dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"login");
        [SVProgressHUD showWithStatus:@"登录中"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        NSLog(@"%@",responseObject[@"msg"]);
        if ([[NSString stringWithFormat:@"%@",responseObject[@"status"]]isEqualToString:@"0"]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:(NSString *)responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            //    NSLog(@"%@",user);
            //    if (user == nil) {
            NSLog(@"first");
            [user setObject:self.idTextField.text forKey:@"userId"];
            [user setObject:self.passwordTextField.text forKey:@"userPassword"];
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            delegate.token = responseObject[@"data"][@"token"];
            
            JMTabBarController *tabBarVC = [[JMTabBarController alloc]init];
            tabBarVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            tabBarVC.transitioningDelegate = self;
//            delegate.window.rootViewController = [[JMLoginViewController alloc]init];
            [self presentViewController:tabBarVC animated:YES completion:nil];
            
            

        }
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误,请重试"];
        NSLog(@"%@",error);
    }];
}

- (void)showPassword {
    if (self.isHiddenPassword == YES) {
        [self.isHiddenButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateNormal];
        [self.isHiddenButton setImage:[UIImage imageNamed:@"shown"] forState:UIControlStateHighlighted];
        self.passwordTextField.secureTextEntry = YES;
    } else {
        [self.isHiddenButton setImage:[UIImage imageNamed:@"shown"] forState:UIControlStateNormal];
        [self.isHiddenButton setImage:[UIImage imageNamed:@"hidden"] forState:UIControlStateHighlighted];
        self.passwordTextField.secureTextEntry = NO;
    }
    
    self.isHiddenPassword = !self.isHiddenPassword;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    CustomPresentAnimationCotroller *presentAnimation = [CustomPresentAnimationCotroller new];
    presentAnimation.dismiss = NO;
    return presentAnimation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    CustomPresentAnimationCotroller *presentAnimation = [CustomPresentAnimationCotroller new];
    presentAnimation.dismiss = YES;
    return presentAnimation;
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
