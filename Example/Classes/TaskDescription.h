//
//  KCContactGroup.h
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalInfo.h"

@interface TaskDescription : NSObject

@property (nonatomic,assign) NSInteger rqsID;
#pragma mark 时间YYMMDDHHSS
//@property (nonatomic,copy) NSString *time;
#pragma mark 地点
@property (nonatomic,copy) NSString *locationSite;
#pragma mark 联系人
@property (nonatomic,copy) NSString *palName;
#pragma mark 任务
@property (nonatomic,copy) NSString *task;
#pragma mark 消息内容
@property (nonatomic,copy) NSString *taskAll;
#pragma mark 状态
@property (nonatomic,assign) NSString *status;

#pragma mark 带参数个构造函数
-(TaskDescription *)initWithName:(NSString *)palName andLocationSite:(NSString *)locationSite andPal:(NSInteger *)rqsID andTask:(NSString *)task andStatus:(NSString *)status;
-(NSString *)getName;
-(NSString *)getLocation;
-(NSString *)getTask;
-(NSString *)getStatus;
-(NSString *)getAll;

#pragma mark 静态初始化方法
+(TaskDescription *)initWithName:(NSString *)palName andLocationSite:(NSString *)locationSite andPal:(NSInteger *)rqsID andTask:(NSString *)task andStatus:(NSString *)status;

@end
