//
//  RDVDetailsViewController.h
//  RDVTabBarController
//
//  Created by Robert Dimitrov on 11/8/14.
//  Copyright (c) 2014 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CJSONDeserializer.h"


NSDictionary  * dictionary;
@interface LogInViewController : UIViewController<ASIHTTPRequestDelegate,UIAlertViewDelegate> {

    UITextField *username;
    UITextField *password;
    
}

@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
