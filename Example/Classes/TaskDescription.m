//
//  KCContactGroup.m
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "TaskDescription.h"

@implementation TaskDescription
#pragma mark 带参数个构造函数
-(TaskDescription *)initWithName:(NSString *)palName andLocationSite:(NSString *)locationSite andPal:(NSInteger *)rqsID andTask:(NSString *)task andStatus:(NSString *)status{
    if(self=[super init]){
        self.palName=palName;
        self.locationSite=locationSite;
        self.rqsID=rqsID;
        self.task=task;
        self.status=status;
        self.taskAll = [@"" stringByAppendingFormat:@"PalName: %@  \nTask: %@",palName,task] ;
    }
    return self;
}
-(NSString *)getName{
    return self.palName;
}
-(NSString *)getLocation{
    return self.locationSite;
}
-(NSString *)getTask{
    return self.task;
}
-(NSString *)getStatus{
    return self.status;
}
-(NSString *)getAll{
    return self.taskAll;
}


#pragma mark 静态初始化方法
+(TaskDescription *)initWithName:(NSString *)palName andLocationSite:(NSString *)locationSite andPal:(NSInteger *)rqsID andTask:(NSString *)task andStatus:(NSString *)status{
    TaskDescription *task1 =[[TaskDescription alloc] initWithName:palName andLocationSite:locationSite andPal:rqsID andTask:task andStatus:status];
    return task1;
}

@end