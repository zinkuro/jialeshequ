//
//  JMPostMessageViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/19.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMPostMessageViewController.h"
#import "CLPhotosVIew.h"
#import "CLTextView.h"
#import "KxMenu.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "TZImagePickerController.h"

#import "FFDropDownMenuView.h"

@interface JMPostMessageViewController () <UITextViewDelegate>

@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (strong,nonatomic) UITextField *titleTextField;

//@property (strong,nonatomic) UITextField *contentTextField;

@property (nonatomic,weak) CLPhotosVIew *phontView;

@property (nonatomic,strong) NSMutableArray *imgArr;

@property (nonatomic,strong) FFDropDownMenuView *dropDownMenu;

@property (nonatomic,strong) UILabel *chooseLabel;

@property (nonatomic,strong) CLTextView *textView;

@end

@implementation JMPostMessageViewController

- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.titleTextField.placeholder = @"标题...";
    self.titleTextField.font = [UIFont systemFontOfSize:14.0];
    self.titleTextField.backgroundColor = [UIColor whiteColor];
    self.titleTextField.leftViewMode = UITextFieldViewModeAlways;
    self.titleTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    [self.view addSubview:self.titleTextField];
    
//    self.contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 60, self.view.width, 150)];
//    self.contentTextField.placeholder = @"说点什么吧...";
//    self.contentTextField.backgroundColor = [UIColor whiteColor];
//    self.contentTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.contentTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
//    [self.view addSubview:self.contentTextField];
    
    
    self.view.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(postMessage)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view.
    
    [self setUpPhotoView];
}

- (void)setUpPhotoView {
    
    self.textView = [[CLTextView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, 300)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.delegate = self;
    self.textView.placehoder = @"说点什么吧...";
    
    [self.view addSubview:self.textView];
    
    self.chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 365, self.view.width, 40)];
    self.chooseLabel.text = @"  社团选择: 请选择...";
    self.chooseLabel.backgroundColor = [UIColor whiteColor];
    self.chooseLabel.font = [UIFont systemFontOfSize:14];
    self.chooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTaped)];
    [self.chooseLabel addGestureRecognizer:tap];
    [self.view addSubview:self.chooseLabel];
    
    CLPhotosVIew *photosView = [[CLPhotosVIew alloc] initWithFrame:CGRectMake(10, 50, self.textView.frame.size.width - 20, 250)];
    self.phontView = photosView;
    photosView.photoArray = @[[UIImage imageNamed:@"images_01"]];
    __weak typeof(self) weakself = self;

    photosView.clickcloseImage = ^(NSInteger index){
        [weakself.imgArr removeObjectAtIndex:index];
    };
    photosView.clickChooseView = ^{
        // 直接调用相册
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [weakself.imgArr addObjectsFromArray:photos];
            NSArray *arr = [weakself.imgArr arrayByAddingObjectsFromArray:@[[UIImage imageNamed:@"images_01"]]];
            weakself.phontView.photoArray = arr;
        }];
        [weakself.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
    };
    [self.textView addSubview:photosView];
}

- (void)labelTaped {
    NSLog(@"bbb");
    [self.manager GET:JIALE_JOINED_CLUB_URL parameters:@{@"token":self.token} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)postMessage {
    NSLog(@"%@",self.titleTextField.text);
    NSLog(@"%@",self.textView.text);
    NSLog(@"%@",self.phontView.photoArray);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.token forKey:@"token"];
    [dict setObject:@"91" forKey:@"noteid"];
    [dict setObject:self.titleTextField.text forKey:@"title"];
    [dict setObject:self.textView.text forKey:@"content"];
    NSLog(@"%@",dict);
    [self.manager POST:JIALE_POST_MSG_URL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"posting");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"这是全部bbs数据%@",jsonStr);
        NSLog(@"postResponseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma  mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat textH = [textView.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGRect frame = self.phontView.frame;
    frame.origin.y = 50 + textH;
    self.phontView.frame = frame;
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
