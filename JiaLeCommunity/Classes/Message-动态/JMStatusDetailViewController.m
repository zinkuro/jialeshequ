//
//  JMStatusDetailViewController.m
//  JiaLeCommunity
//
//  Created by Jin on 16/11/10.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMStatusDetailViewController.h"
#import "JMStatusModel.h"
#import "JMStatusCell.h"
#import "JMReplyModel.h"
#import "JMReplyTabelViewCell.h"
#import "JMReplyDetailTableViewController.h"
#import "JSONKit.h"
#import "CoreTextView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface CustomRenderer : NSObject<HTMLRenderer>
@property(nonatomic,assign) CGSize size;
@property(nonatomic,copy) NSString* type;
@end

@implementation CustomRenderer
-(void)renderInContext:(CGContextRef)context rect:(CGRect)rect
{
    if ([self.type isEqualToString:@"circle"])
    {
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillEllipseInRect(context, rect);
    }
    else if ([self.type isEqualToString:@"square"])
    {
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillRect(context, rect);
    }
}

@end

@interface JMStatusDetailViewController () <UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>
{
    CoreTextView *m_coreText;
}


@property (strong,nonatomic) AFHTTPSessionManager *manager;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) JMStatusModel *newModel;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *listDataArray;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;


@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likedButton;
@property (nonatomic, strong) UIButton *collectButton;


@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation JMStatusDetailViewController

- (NSMutableArray *)listDataArray {
    if (!_listDataArray) {
        _listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (JMStatusModel *)newModel{
    if (!_newModel) {
        _newModel = [[JMStatusModel alloc]init];
    }
    return _newModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    }
    return _tableView;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _manager;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)creatHtmlScroll {
    
    NSString *html = self.newModel.content;
    
    NSRegularExpression *regular;
    regular = [[NSRegularExpression alloc] initWithPattern:@"<video.*?src"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
    html = [regular stringByReplacingMatchesInString:html options:0 range:NSMakeRange(0, [html length]) withTemplate:@"<a href"];
    regular = [[NSRegularExpression alloc] initWithPattern:@"<source.*?>"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
    html = [regular stringByReplacingMatchesInString:html options:0 range:NSMakeRange(0, [html length]) withTemplate:@""];
    regular = [[NSRegularExpression alloc] initWithPattern:@"</video>"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
    html = [regular stringByReplacingMatchesInString:html options:0 range:NSMakeRange(0, [html length]) withTemplate:@"</a>"];
    
    m_coreText=[[CoreTextView alloc] initWithFrame:CGRectZero];
    m_coreText.backgroundColor=[UIColor clearColor];
    m_coreText.contentInset=UIEdgeInsetsMake(80, 10, 10, 10);//上左下右的顺序。
    //NSString* html=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"view" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];//这里是读取本地文件。
    //NSLog(@"%@",html);
    m_coreText.attributedString=[NSAttributedString attributedStringWithHTML:html renderer:^id<HTMLRenderer>(NSMutableDictionary* attributes)
                                 {
                                     CustomRenderer* renderer=[[CustomRenderer alloc] init];
                                     renderer.type=attributes[@"type"];
                                     renderer.size=CGSizeMake(16, 16);
                                     return renderer;
                                 }];
    
    
    
    m_coreText.frame=CGRectMake(0, 0, self.view.bounds.size.width, [m_coreText sizeThatFits:CGSizeMake(self.view.bounds.size.width-20, MAXFLOAT)].height);
    self.scroll.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.scroll.scrollEnabled = NO;
    self.scroll.contentSize = m_coreText.frame.size;
    [self.scroll addSubview:m_coreText];
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",self.model.comment_num] forState:UIControlStateNormal];
    [self.likedButton setTitle:[NSString stringWithFormat:@"%zd",self.model.zan_num] forState:UIControlStateNormal];
    [self.collectButton setTitle:@"" forState:UIControlStateNormal];
    
    [self.scroll addSubview:self.likedButton];
    [self.scroll addSubview:self.commentButton];
    [self.scroll addSubview:self.collectButton];
    
    __weak typeof(self) weakself = self;
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(m_coreText.mas_bottom).offset(0);
        make.left.equalTo(weakself.scroll.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3.0f);
        make.height.equalTo(@30);
    }];
    [self.likedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(m_coreText.mas_bottom).offset(0);
        make.left.equalTo(weakself.commentButton.mas_right).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3.0f);
        make.height.equalTo(@30);
    }];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(m_coreText.mas_bottom).offset(0);
        make.left.equalTo(weakself.likedButton.mas_right).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3.0f);
        make.height.equalTo(@30);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithR:225.0 G:225.0 B:225.0];
    [self.scroll addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.likedButton.mas_bottom).offset(0);
        make.left.equalTo(weakself.commentButton.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.equalTo(@1);
    }];
    UIView *wildView = [[UIView alloc]init];
    wildView.backgroundColor = [UIColor colorWithR:249.0 G:249.0 B:249.0];
    [self.scroll addSubview:wildView];

    [wildView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.equalTo(weakself.commentButton.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.equalTo(@10);
    }];
    UIView *bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = [UIColor colorWithR:225.0 G:225.0 B:225.0];
    [self.scroll addSubview:bottomLineView];

    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wildView.mas_bottom).offset(0);
        make.left.equalTo(weakself.commentButton.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.equalTo(@1);
    }];
    
    
    self.tableView.tableHeaderView = self.scroll;
    /*[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(m_coreText.mas_bottom).offset(30);
        make.left.equalTo(weakself.scroll.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(100);
    }];
    
    [self.tableView reloadData];
    self.scroll.backgroundColor = [UIColor redColor];
    CGSize oldSize = self.scroll.size;
    CGSize addTableSize = CGSizeMake(SCREEN_WIDTH, oldSize.height + self.tableView.contentSize.height);
    self.scroll.size = addTableSize;*/
    // [self.view addSubview:self.scroll];

}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc]init];
        [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_commentButton setImage:[UIImage imageNamed:@"评论M"] forState:UIControlStateNormal];
    }
    return _commentButton;
}
- (UIButton *)likedButton {
    if (!_likedButton) {
        _likedButton = [[UIButton alloc]init];
        [_likedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likedButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_likedButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    }
    return _likedButton;
}
- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [[UIButton alloc]init];
        [_collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _collectButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_collectButton setImage:[UIImage imageNamed:@"收藏亮"] forState:UIControlStateNormal];
    }
    return _collectButton;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 23;
    }
    return _avatarImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
    }
    return _timeLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
    }
    return _typeLabel;
}

- (void)creatHeaderView {
    
    self.scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
    
    NSString *avatarString = [NSString stringWithFormat:@"http://www.jialeshequ.com/%@",self.model.pic];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarString] placeholderImage:nil];
    self.nameLabel.text = self.model.name;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.text = self.model.seeTime;
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor colorWithR:151 G:151 B:151];
    
    //1.首先你需要创建一个可变的AttributeString,里面存入你需要的字符串
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",self.model.note_key]];
    //2.其次需要创建附件,这个附件是用来存放图片的
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach = [[NSTextAttachment alloc]init];
    //-->给附件传入图片
    attach.image = [UIImage imageNamed:@"标签"];
    //-->给附件一个frame,默认是和普通的文字一样的坐标,如果觉得没有对齐,可以在这里更改x和y值
    //(此处小图片的宽高我进行了屏幕适配,乘以了比例)
    attach.bounds = CGRectMake(0, - 2, 12, 12);
    //-->将附件转换成AttributeString,供后面拼接
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
    //3.然后将附件和文字拼接起来
    NSMutableAttributedString *attrF = [[NSMutableAttributedString alloc]initWithAttributedString:imgStr];
    [attrF appendAttributedString:attri];
    //4.接下来对新生成的拼接富文本进行进一步的文本属性设置,可设置颜色,字体等;
    [attrF addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, self.model.note_key.length + 2)];
    //-->注意一下字符串的长度,我偷懒使用了一个空格设置间距,记得在length里面加上;
    [attrF addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.model.note_key.length + 2)];
    //5.最后给label赋予富文本字符,此处若是UIButton,则为setAttributedTitle
    [self.typeLabel setAttributedText:attrF];
    
    self.typeLabel.textColor = [UIColor colorWithR:109 G:109 B:109];
    
    [self.scroll addSubview:self.nameLabel];
    [self.scroll addSubview:self.timeLabel];
    [self.scroll addSubview:self.typeLabel];
    [self.scroll addSubview:self.avatarImageView];
    
    __weak typeof(self) weakself = self;

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.scroll.mas_left).offset(14);
        make.top.equalTo(weakself.scroll.mas_top).offset(12);
        make.width.equalTo(@46);
        make.height.equalTo(@46);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.avatarImageView.mas_right).offset(10);
        make.top.equalTo(weakself.scroll.mas_top).offset(20);
        make.height.equalTo(@15);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.avatarImageView.mas_right).offset(10);
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(10);
        make.height.equalTo(@12);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.avatarImageView.mas_right).offset(200);
        make.top.equalTo(weakself.scroll.mas_top).offset(10);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeaderView];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.manager GET:JIALE_CLUB_BBS_INFO_URL parameters:@{@"token":self.token,@"id":[NSString stringWithFormat:@"%zd",self.model.post_id]} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        //        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSLog(@"这是全部数据???%@",jsonStr);
        
        self.newModel = self.model;
//        NSLog(@"---------------%@",self.newModel);
//        NSLog(@"%@",responseObject[@"data"]);
        
        self.newModel.content = responseObject[@"data"][@"cur"][@"content"];
        [self creatHtmlScroll];
        NSArray *resultArray = responseObject[@"data"][@"ilist"][@"list"];
        
        if (![resultArray isKindOfClass:NSClassFromString(@"NSNull")]) {
            NSArray *statusArray = [NSArray yy_modelArrayWithClass:[JMReplyModel class] json:resultArray];
            [self.dataArray addObjectsFromArray:statusArray];
        }
        NSLog(@"%@",self.dataArray);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    if (indexPath.section == 0 && indexPath.row == 0) {
        JMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];
        
        if (cell == nil) {
            //采用了estimatedHeight的话就必须在这里进行cell创建的时候加载,而不能在viewDidLoad里面进行注册,否则方法顺序会出错
            //estimateHeight就是为了让cell在创建的时候再决定高度
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JMStatusCell" owner:nil options:nil]lastObject];
            
        }
        cell.commentButton.hidden = NO;
        cell.likedButton.hidden = NO;
        cell.collectButton.hidden = NO;
        cell.isDetail = YES;
        cell.model = self.newModel;
        
        return cell;
    } else {*/
        JMReplyTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reply"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"JMReplyTabelViewCell" owner:nil options:nil]lastObject];
        }
        cell.model = self.dataArray[indexPath.row];
        //        cell.textLabel.text = @"nimabihoutaijiushigeshabi";
        return cell;
    //}     // Configure the cell...
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JMReplyDetailTableViewController *detailReply = [[JMReplyDetailTableViewController alloc]init];
    detailReply.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailReply animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    if (indexPath.section == 0 && indexPath.row == 0) {
        return self.newModel.cellHeight;
    } else {*/
        JMReplyModel *model = self.dataArray[indexPath.row];
        return model.cellHeight;
   // }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"estimate");
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*if (section == 0) {
        return 1;
    } else {*/
        return self.dataArray.count;
    //}
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
