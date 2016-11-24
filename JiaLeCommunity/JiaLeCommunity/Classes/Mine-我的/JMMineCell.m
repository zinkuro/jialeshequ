//
//  JMMineCell.m
//  JiaLeCommunity
//
//  Created by Jin on 16/7/8.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMMineCell.h"

@interface JMMineCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JMMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.width / 2;
}

- (void)setModel:(JMMineCellModel *)model {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@""]];
    self.timeLabel.text = model.timeString;
    self.timeLabel.textColor = [UIColor colorWithR:183 G:183 B:183];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.text = model.nameString;
    self.statusLabel.attributedText = model.statusString;
    self.statusLabel.adjustsFontSizeToFitWidth = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
