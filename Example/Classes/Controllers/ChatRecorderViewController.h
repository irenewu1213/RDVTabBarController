//
//  ChatRecorder.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/6.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBordVIew.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ASIHTTPRequest.h"
@interface ChatRecorderViewController :UIViewController{
    UITextField *textField;
}

@property(nonatomic) long chatID;
@property (nonatomic,retain) UITextField *textField;
-(void) btnClick:(id)sender;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@end