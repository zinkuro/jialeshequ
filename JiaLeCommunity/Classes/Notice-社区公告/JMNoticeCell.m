//
//  JMNoticeCell.m
//  JiaLeCommunity
//
//  Created by Jin on 16/7/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMNoticeCell.h"
#import "JMNoticeCellModel.h"
@interface JMNoticeCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation JMNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(JMNoticeCellModel *)model {
    self.titleLabel.text = model.titleText;
    self.detailLabel.text = model.detailText;
    self.detailLabel.numberOfLines = 0;
    self.commentLabel.text = model.numberText;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
