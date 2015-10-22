//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyBoardVIew.h"

@interface KeyBoardVIew()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;
@end

@implementation KeyBoardVIew
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}
/*
//委托方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -=126;
    frame.size.height +=126;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    return YES;
}

 - (void)textFieldDidBeginEditing:(UITextField *)textField{
 //开始编辑时触发，文本字段将成为first responder
 //键盘遮住了文本字段，视图整体上移
     CGRect frame = self.view.frame;
     frame.origin.y -=30;
     frame.size.height +=30;
     self.view.frame = frame;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    NSLog(@"here is code: %@",textField.text);
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y +=126;
    frame.size. height -=126;
    self.view.frame = frame;
    //self.view移回原位置
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return true;
}
 */
@end