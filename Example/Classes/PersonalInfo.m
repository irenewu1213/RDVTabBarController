//
//  Contact.m
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "PersonalInfo.h"

@implementation PersonalInfo

-(PersonalInfo *)initWithid:(NSInteger) idNumber FirstName:(NSString *)firstName andLastName:(NSString *)lastName andGender:(NSString *)gender andLocation:(NSString *)location{
    if(self=[super init]){
        self.idNumber=idNumber;
        self.firstName=firstName;
        self.lastName=lastName;
        self.gender=gender;
        self.location=location;
        self.skillTag=[[NSMutableArray alloc]init];
        self.extraMoney = 0.0;
    }
    return self;
}

-(void)addSkillTag:(NSString *)skillName{
    [self.skillTag addObject:skillName];
//    NSLog(@"ADD Skill");
}
-(void)addPortalObject:(UIImage *)portal{

}

-(NSString *)getSkillTag{
    NSString *skill;
    skill = [self.skillTag componentsJoinedByString:@","];
//    NSLog(@"%@",[self.skillTag objectAtIndex:0]);
//    NSLog(@"%@",skill);
    return skill;
}
-(NSString *)getName{
    return [NSString stringWithFormat:@"%@ %@",_lastName,_firstName];
//    return [NSString stringWithFormat:@"Irene"];
}
-(NSString *)getGender{
    return self.gender;
}
-(NSString *)getLocation{
    return self.location;
}
-(float)getExtraMoney{
    return self.extraMoney;
}

+(PersonalInfo *)initWithid:(NSInteger) idNumber FirstName:(NSString *)firstName andLastName:(NSString *)lastName andGender:(NSString *)gender andLocation:(NSString *)location{
    PersonalInfo *person1=[[PersonalInfo alloc]initWithid:(NSInteger) idNumber FirstName:firstName andLastName:lastName andGender:gender andLocation:location];
    return person1;
}

@end


