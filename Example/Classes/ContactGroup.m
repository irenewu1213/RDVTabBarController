//
//  KCContactGroup.m
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "ContactGroup.h"

@implementation ContactGroup


-(ContactGroup *)initWithTitle:(NSString*) titleName andPersons:(NSMutableArray *)persons{
    if (self=[super init]) {
        self.name=titleName;
        self.persons=persons;
    }
    return self;
}
-(ContactGroup *)addPals:(ChatContact *)person1{
    if (self) {
        [self.persons addObject:person1];
    }
    return self;
}
+(ContactGroup *)initWithTitle:(NSString*) titleName andPersons:(NSMutableArray *)persons{
    ContactGroup *group1=[[ContactGroup alloc]initWithTitle:(NSString*) titleName andPersons:persons];
    return group1;
}
@end
