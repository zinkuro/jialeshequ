//
//  JMStatusCell.m
//  JiaLeCommunity
//
//  Created by Jin on 16/9/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMStatusCell.h"
#import "JMStatusModel.h"
#import "SDWebImageManager+MJ.h"
#import "UIImageView+MJWebCache.h"
#import "JMViewForOutTap.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define TAG_NUM 1000
@interface JMStatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//@property (weak, nonatomic) IBOutlet UIButton *likedButton;
//@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet JMViewForOutTap *imagesView;

@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation JMStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentButton.hidden = YES;
    self.likedButton.hidden = YES;
    self.collectButton.hidden = YES;

    
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.height / 2;
    // Initialization code
}
- (IBAction)testButton:(UIButton *)sender {
    NSLog(@"test!!!!!!");
}

- (void)setIsDetail:(BOOL)isDetail {
    if (isDetail) {
        self.imagesView.hidden = YES;
    }else {
        self.imagesView.hidden = NO;
    }
    _isDetail = isDetail;
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}


- (void)setModel:(JMStatusModel *)model {
//    NSLog(@"contentcaonima%@",model.cur[@"content"]);
    
//    NSLog(@"imgs:============%@",model.imgs);
    [self.imagesArray removeAllObjects];
    [self.imagesArray addObjectsFromArray:model.imgs];
    
    NSString *avatarString = [NSString stringWithFormat:@"http://www.jialeshequ.com/%@",model.pic];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarString] placeholderImage:nil];
    self.nameLabel.text = model.name;
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",model.comment_num] forState:UIControlStateNormal];
    [self.likedButton setTitle:[NSString stringWithFormat:@"%zd",model.zan_num] forState:UIControlStateNormal];
    [self.collectButton setTitle:@"" forState:UIControlStateNormal];
    
    self.timeLabel.text = model.seeTime;
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor colorWithR:151 G:151 B:151];
    
    //1.首先你需要创建一个可变的AttributeString,里面存入你需要的字符串
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",model.note_key]];
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
    [attrF addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, model.note_key.length + 2)];
    //-->注意一下字符串的长度,我偷懒使用了一个空格设置间距,记得在length里面加上;
    [attrF addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, model.note_key.length + 2)];
    //5.最后给label赋予富文本字符,此处若是UIButton,则为setAttributedTitle
    [self.typeLabel setAttributedText:attrF];
    
    self.typeLabel.textColor = [UIColor colorWithR:109 G:109 B:109];
    
    NSString *contentStr = [NSString string];
    NSLog(@"content == %@",model.content);
    if (model.content.length > 0 && self.isDetail) {
        NSLog(@"shouldshowhtmlText");
        NSString * htmlString = model.content;
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
//        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"#%@# %@",model.title,contentStr]];
//        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithR:81 G:168 B:233] range:NSMakeRange(0, model.title.length + 2)];
//        
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//        [paragraphStyle setLineSpacing:4];
//        
//        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, model.title.length + 3 + contentStr.length)];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.title.length + 3 + contentStr.length)];
        
        self.contentLabel.attributedText = attrStr;
        
    } else {
//        self.imagesView.hidden = NO;
//        [self layoutIfNeeded];
        contentStr = model.remark;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"#%@# %@",model.title,contentStr]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithR:81 G:168 B:233] range:NSMakeRange(0, model.title.length + 2)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:4];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, model.title.length + 3 + contentStr.length)];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.title.length + 3 + contentStr.length)];
        
        self.contentLabel.attributedText = attributedString;
    }
    
    
    [self layoutIfNeeded];
    
    CGFloat cellHeightWithoutImages = CGRectGetMaxY(self.contentLabel.frame) + 12 + 13 + 10 + 10;
    
    CGFloat totalImagesHeight = 0;
    
    for (UIImageView *image in self.imagesView.subviews) {
        [image removeFromSuperview];
    }
//    self.imagesView.backgroundColor = [UIColor cyanColor];
    
    if (model.imgs.count > 0) {
        self.imagesView.hidden = NO;
        // 1.创建9个UIImageView,添加到特定view上
        UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
        
        CGFloat margin = 10;
        CGFloat startX = 10;
        CGFloat startY = 10;
        
        if (model.imgs.count < 3) {
            for (int i = 0; i < model.imgs.count; i++) {
                
                CGFloat width = (SCREEN_WIDTH - margin * (model.imgs.count + 1)) / model.imgs.count;
                CGFloat height = width;
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [self.imagesView addSubview:imageView];
                
                // 计算位置
                int row = i / model.imgs.count;
                int column = i % model.imgs.count;
                CGFloat x = startX + column * (width + margin);
                CGFloat y = startY + row * (height + margin);
                imageView.frame = CGRectMake(x, y, width, height);
                
                // 下载图片
                [imageView setImageURLStr:model.imgs[i] placeholder:placeholder];
                
                // 事件监听
                imageView.tag = i + TAG_NUM;
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
                
                // 内容模式
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                
                totalImagesHeight = width + margin;
            }

        } else if (model.imgs.count > 3) {
            
            for (int i = 0; i < 3; i++) {
                
                CGFloat width = (SCREEN_WIDTH - 4 * margin) / 3.0f;
                CGFloat height = width;
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [self.imagesView addSubview:imageView];
                
                // 计算位置
                int row = i / 3;
                int column = i % 3;
                CGFloat x = startX + column * (width + margin);
                CGFloat y = startY + row * (height + margin);
                imageView.frame = CGRectMake(x, y, width, height);
                
                // 下载图片
                [imageView setImageURLStr:model.imgs[i] placeholder:placeholder];
                
                // 事件监听
                imageView.tag = i + TAG_NUM;
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
                
                // 内容模式
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                
                totalImagesHeight = width + margin;
            }
        }

    } else if (model.imgs.count == 0) {
        
        self.imagesView.hidden = YES;
        
        totalImagesHeight = 0;
    }
//    NSLog(@"totalImageHeight =  %.2f", totalImagesHeight);
    model.cellHeight = cellHeightWithoutImages + totalImagesHeight;
//    NSLog(@"%.2f",model.cellHeight);
//    [self layoutIfNeeded];

}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = self.imagesArray.count;
//    NSLog(@"%@",self.imagesArray);
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:9];
    
    int lenth;
    
    if (count > 3) {
        lenth = 3;
    } else if (count <= 3 && count > 0) {
        lenth = (int)self.imagesArray.count;
    }
    
    for (int i = 0; i < lenth; i++) {
        // 替换为中等尺寸图片
        NSString *url = [self.imagesArray[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.imagesView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSLog(@"%zd",tap.view.tag);
    browser.currentPhotoIndex = tap.view.tag - TAG_NUM; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
