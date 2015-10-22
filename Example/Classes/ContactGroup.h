//
//  KCContactGroup.h
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatContact.h"
#import "PersonalInfo.h"

@interface ContactGroup : NSObject

#pragma mark 组名
@property (nonatomic,copy) NSString *name;

#pragma mark 联系人
@property (nonatomic,strong) NSMutableArray *persons;

#pragma mark 带参数个构造函数
-(ContactGroup *)initWithTitle:(NSString*) titleName andPersons:(NSMutableArray *)persons;
-(ContactGroup *)addPals:(ChatContact *)person1;
#pragma mark 静态初始化方法
+(ContactGroup *)initWithTitle:(NSString*) titleName andPersons:(NSMutableArray *)persons;

@end
