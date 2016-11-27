//
//  JMReplyTabelViewCell.m
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/24.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMReplyTabelViewCell.h"

@implementation JMReplyTabelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    self.avatarImageView.layer.cornerRadius = 15;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setModel:(JMReplyModel *)model {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
    self.contentLabel.text = model.content;
    self.nameLabel.text = model.uname;
//    [self.replyButon setTitle:@"" forState:UIControlStateNormal];
    [self.replyButon addTarget:self action:@selector(reply) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reply {
    NSLog(@"reply");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
