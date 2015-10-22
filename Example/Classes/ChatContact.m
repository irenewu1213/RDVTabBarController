//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/5.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatContact.h"

@implementation ChatContact

#pragma mark 带参数的构造函数
-(ChatContact *)initWithName:(NSString *)personName andSkill:(NSString *)personSkll;{
    if(self=[super init]){
        self.personName=personName;
        self.personSkill=personSkll;
    }
    return self;
}

#pragma mark 取得姓名
-(NSString *)getName{
    return self.personName;
}


#pragma mark 带参数的静态对象初始化方法
+(ChatContact *)initWithName:(NSString *)personName andSkill:(NSString *)personSkll;{
    ChatContact *contact1=[[ChatContact alloc]initWithName:personName andSkill:personSkll];
    return contact1;
}

@end