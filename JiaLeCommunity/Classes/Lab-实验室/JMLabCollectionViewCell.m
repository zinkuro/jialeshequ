//
//  JMLabCollectionViewCell.m
//  searchBarTest
//
//  Created by Jin on 16/8/4.
//  Copyright © 2016年 Jin. All rights reserved.
//h

#import "JMLabCollectionViewCell.h"
#import "JMTaskModel.h"
@interface JMLabCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *labNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation JMLabCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labNameLabel.font = [UIFont systemFontOfSize:[[UIScreen mainScreen] bounds].size.width * 14 / 414.0];
    
    // Initialization code
}

- (void)setModel:(JMTaskModel *)model {
//    [self.coverImageView setImageWithURL:[NSURL URLWithString:model.imgs[0]] placeholderImage:[UIImage imageNamed:@""]];
//    self.model = model;
    self.coverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cover%d",arc4random()%3]];
    self.labNameLabel.text = model.title;
    self.typeLabel.text = model.group_name;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@学分",model.credit];
}

@end
