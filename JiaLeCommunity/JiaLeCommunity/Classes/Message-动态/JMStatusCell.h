//
//  JMStatusCell.h
//  JiaLeCommunity
//
//  Created by Jin on 16/9/20.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMStatusModel;
@interface JMStatusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likedButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (nonatomic,assign) BOOL isDetail;

@property (nonatomic,strong) JMStatusModel *model;

@end
