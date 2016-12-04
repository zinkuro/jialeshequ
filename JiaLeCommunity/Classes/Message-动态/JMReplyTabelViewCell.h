//
//  JMReplyTabelViewCell.h
//  JiaLeCommunity
//
//  Created by Jin on 2016/11/24.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMReplyModel.h"
@interface JMReplyTabelViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *replyButon;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) JMReplyModel *model;

@end
