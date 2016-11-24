//
//  JMClubCell.m
//  JiaLeCommunity
//
//  Created by Jin on 16/10/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import "JMClubCell.h"
#import "JMClubModel.h"
@interface JMClubCell ()

@property (weak, nonatomic) IBOutlet UIImageView *clubCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *clubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberNumberLabel;

@end

@implementation JMClubCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"rightCell";
    JMClubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JMClubCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

- (void)setModel:(JMClubModel *)model {
    self.clubCoverImageView.clipsToBounds = YES;
    self.clubCoverImageView.layer.cornerRadius = 8;
    
    [self.clubCoverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.jialeshequ.com/%@",model.pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_loading"]];
    self.memberNumberLabel.text = [NSString stringWithFormat:@"成员: %zd人",model.user_num];
    self.clubNameLabel.text = model.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
