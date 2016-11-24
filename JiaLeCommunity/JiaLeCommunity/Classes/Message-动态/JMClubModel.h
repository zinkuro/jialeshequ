//
//  JMClubModel.h
//  JiaLeCommunity
//
//  Created by Jin on 16/10/5.
//  Copyright © 2016年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JMClubModel : NSObject

@property (nonatomic,strong) NSString *typeName;

@property (nonatomic,assign) NSInteger join_type;
//"mid" : "9",
@property (nonatomic,strong) NSString *keyword;

@property (nonatomic,assign) NSInteger fid;
//"sort" : "0",
@property (nonatomic,strong) NSString *uname;

@property (nonatomic,assign) NSInteger user_num;

@property (nonatomic,strong) NSString *pic;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) NSString *remark;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *club_id;

@property (nonatomic,assign) NSInteger is_menber;

//"pic_native" : "upload\/note\/20160905\/147308248792032.png",
//"post_num" : "0",
//"name" : "健美操协会",
//"type" : "5",
//"is_kanwu" : "0",
//"id" : "82",
//"pic" : "upload\/note\/20160905\/147308248792032_300x.png",
//"uid" : "27449",
//"pic_800" : "upload\/note\/20160905\/147308248792032.png",
//"uptime" : "2016-09-05 21:34:47",
//"crtime" : "2016-09-05 21:34:47",
//"bgpic" : "upload\/note\/20160905\/bg\/147308248721937.jpg",
//"is_sheng" : "1",
//"remark" : "童鞋们，想要过一个不一样的大学生活吗?\r\n你还在为自己没有特长而感到自卑吗？\r\n你还因为没有展示的地方而焦虑吗？\r\n你是否曾经渴望着对舞蹈的追求，\r\n你是否依然执着着对运动的热爱，\r\n你是否怀揣健身健美的梦想……\r\n来吧！加入我们！\r\n在这里，能让你感受到活力四射欢快的舞步。\r\n在这里，能让你在锻炼的同时去感受舞蹈所带来的快乐。\r\n在这里，能让你用身体跳出真正的青春与健康之美！\r\n还在等什么?\r\n来吧！让我们随着青春的舞曲跳跃起来吧！"

@end
