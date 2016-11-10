//
//  JMClubCell.h
//  JiaLeCommunity
//
//  Created by Jin on 16/10/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMClubModel;

@interface JMClubCell : UITableViewCell

@property (nonatomic,strong) JMClubModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
