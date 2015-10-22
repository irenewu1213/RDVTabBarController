//
//  KeyBoardView.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyBoardVIew;

@protocol KeyBoardVIewDelegate <NSObject>

//-(void)KeyBoardView:(KeyBoardVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled;
//-(void)KeyBoardView:(KeyBoardVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled;

@end

@interface KeyBoardVIew : UIView
@property (nonatomic,assign) id<KeyBoardVIewDelegate>delegate;
@end
