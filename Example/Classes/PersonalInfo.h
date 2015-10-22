//
//  Contact.h
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 用户个数
static NSInteger totalUser=0;
@interface PersonalInfo : NSObject
#pragma mark ID
@property (nonatomic,assign) NSInteger idNumber;
#pragma mark 姓
@property (nonatomic,copy) NSString *firstName;
#pragma mark 名
@property (nonatomic,copy) NSString *lastName;
#pragma mark gender 0 for Female 1 for Male
@property (nonatomic,copy) NSString * gender;
#pragma mark 姓
@property (nonatomic,retain) NSMutableArray *skillTag;
#pragma mark 手机号码
@property (nonatomic,copy) NSString *location;
#pragma mark 余额
@property (nonatomic,assign) float extraMoney;
#pragma mark 位置
@property (nonatomic,assign) float locationxy;
#pragma mark 头像
@property (nonatomic,retain) UIImage * portal;

#pragma mark 带参数的构造函数
-(PersonalInfo *)initWithid:(NSInteger) idNumber FirstName:(NSString *)firstName andLastName:(NSString *)lastName andGender:(NSString *)gender andLocation:(NSString *)location;

-(void)addSkillTag:(NSString *)skillName;
-(void)addPortalObject:(UIImage *)portal;
-(NSString *)getSkillTag;
-(NSString *)getName;
-(NSString *)getGender;
-(NSString *)getLocation;
-(float)getExtraMoney;

#pragma mark 带参数的静态对象初始化方法
+(PersonalInfo *)initWithid:(NSInteger) idNumber FirstName:(NSString *)firstName andLastName:(NSString *)lastName andGender:(NSString *)gender andLocation:(NSString *)location;
@end
