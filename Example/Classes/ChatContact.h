//
//  Header.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/5.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatContact : NSObject

@property (nonatomic,strong) UIImageView * personPortal;
@property (nonatomic,copy) NSString *personName;

@property (nonatomic,copy) NSString *personID;
#pragma mark 姓
@property (nonatomic,copy) NSString *personSkill;

#pragma mark ID
@property (nonatomic,assign) NSInteger chatID;

#pragma mark 带参数的构造函数
-(ChatContact *)initWithName:(NSString *)personName andSkill:(NSString *)personSkll;

#pragma mark 取得姓名
-(NSString *)getName;


#pragma mark 带参数的静态对象初始化方法
+(ChatContact *)initWithName:(NSString *)personName andSkill:(NSString *)personSkll;
@end