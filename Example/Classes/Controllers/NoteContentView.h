//
//  Header.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TaskDescription.h"

@class NoteContentView,TaskDescription;

@protocol NoteContentViewDelegate <NSObject>

@end

@interface NoteContentView : UIView
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) TaskDescription *taskDescription;
@property (nonatomic,assign) id <NoteContentViewDelegate> delegate;
@end