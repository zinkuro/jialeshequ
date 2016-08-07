//
//  JMLabCollectionViewCell.m
//  searchBarTest
//
//  Created by Jin on 16/8/4.
//  Copyright © 2016年 Jin. All rights reserved.
//h

#import "JMLabCollectionViewCell.h"

@interface JMLabCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *labNameLabel;

@end

@implementation JMLabCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"labelShouldChangeSize");
    self.labNameLabel.font = [UIFont systemFontOfSize:[[UIScreen mainScreen] bounds].size.width * 14 / 414.0];
    // Initialization code
}

@end
