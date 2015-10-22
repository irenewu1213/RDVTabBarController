//
//  Header.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskDescription.h"

@interface NoteCellFrame : NSObject
@property (nonatomic,assign) CGRect iconRect;
@property (nonatomic,assign) CGRect noteViewRect;
@property (nonatomic,strong) TaskDescription *noteMessage;
@property (nonatomic, assign) CGFloat cellHeight; //cell高度
@end