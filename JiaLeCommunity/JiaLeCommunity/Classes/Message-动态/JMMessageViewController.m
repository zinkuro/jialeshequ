//
//  JMMessageViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/6/12.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMMessageViewController.h"
#import "JMContainerViewController.h"
#import "JMStatusTableViewController.h"
#import "JMClubsViewController.h"
#import "FFDropDownMenuView.h"
#import "JMPostMessageViewController.h"
#import <QRCodeReaderViewController.h>
@interface JMMessageViewController () <QRCodeReaderDelegate>

@property (nonatomic,strong) JMContainerViewController *container;

@property (nonatomic,strong) JMStatusTableViewController *statusTableViewController;

@property (nonatomic,strong) JMStatusTableViewController *weeklyTableViewController;

@property (nonatomic,strong) JMStatusTableViewController *messageTableViewController;

@property (nonatomic,strong) FFDropDownMenuView *dropDownMenu;

@end

@implementation JMMessageViewController

- (JMStatusTableViewController *)statusTableViewController {
    if (!_statusTableViewController) {
        _statusTableViewController = [[JMStatusTableViewController alloc]init];
        _statusTableViewController.requestDict = @{@"token":self.token};
        _statusTableViewController.requestURL = JIALE_DYNAMIC_URL;
        _statusTableViewController.title = @"动态";
        _statusTableViewController.token = self.token;
        _statusTableViewController.isTP = NO;
    }
    return _statusTableViewController;
}

- (JMStatusTableViewController *)weeklyTableViewController {
    if (!_weeklyTableViewController) {
        _weeklyTableViewController = [[JMStatusTableViewController alloc]init];
        _weeklyTableViewController.requestDict = @{@"token":self.token};
        _weeklyTableViewController.requestURL = JIALE_DYNAMIC_URL;
        _weeklyTableViewController.title = @"周刊";
        _weeklyTableViewController.token = self.token;
        _weeklyTableViewController.isTP = YES;
    }
    return _weeklyTableViewController;
}

//- (JMStatusTableViewController *)messageTableViewController {
//    if (!_messageTableViewController) {
//        _messageTableViewController = [[JMStatusTableViewController alloc]init];
//        _messageTableViewController.requestDict = @{@"token":self.token};
//        _messageTableViewController.requestURL = JIALE_DYNAMIC_URL;
//        _messageTableViewController.title = @"消息";
//        _messageTableViewController.token = self.token;
//    }
//    return _messageTableViewController;
//}
- (JMContainerViewController *)container {
    if (!_container) {
        
        _container = [[JMContainerViewController alloc]initWithControllers:@[self.statusTableViewController,self.weeklyTableViewController] topBarHeight:0 parentViewController:self];
        //        _container.contentScrollView.height = self.view.height - self.backgroundView.height - 50 - 45;
    }
    return _container;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDropDownMenu];
    self.dropDownMenu.menuAnimateType = FFDropDownMenuViewAnimateType_ScaleBasedTopLeft;
    [self.dropDownMenu setup];
    // Do any additional setup after loading the view
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(dropDownTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    [self.view addSubview:self.container.view];
}

- (void)setupDropDownMenu {
    
    NSArray *modelsArray = [self getMenuModelsArray];
    
    self.dropDownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:modelsArray menuWidth:self.view.width / 3.0f eachItemHeight:FFDefaultFloat menuRightMargin:self.view.width * 2 / 3.0f - 10 triangleRightMargin:self.view.width - 40];
}

/** 获取菜单模型数组 */
- (NSArray *)getMenuModelsArray {
    __weak typeof(self) weakSelf = self;
    
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"发帖子" menuItemIconName:@"msg"  menuBlock:^{
        JMPostMessageViewController *vc = [[JMPostMessageViewController alloc]init];
        vc.token = self.token;
        vc.navigationItem.title = @"发帖子";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    //菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"扫一扫" menuItemIconName:@"scan" menuBlock:^{
        QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
        vc.delegate = self;
//        [vc setCompletionWithBlock:^(NSString *resultAsString) {
//            [self dismissViewControllerAnimated:YES completion:^{
//                NSLog(@"%@", resultAsString);
//            }];
//        }];
        vc.navigationItem.title = @"扫一扫";
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    NSArray *menuModelArr = @[menuModel0, menuModel1];
    return menuModelArr;
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

/**
 * @abstract Tells the delegate that the user wants to stop scanning QRCodes.
 * @param reader The reader view controller that the user wants to stop.
 * @since 1.0.0
 */
- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dropDownTouched {
    [self.dropDownMenu showMenu];
}

- (void)searchButtonTouched {
    JMClubsViewController *clubs = [[JMClubsViewController alloc]init];
    clubs.token = self.token;
    [self.navigationController pushViewController:clubs animated:YES];
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
