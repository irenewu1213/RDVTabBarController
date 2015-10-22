//
//  RDVDetailsViewController.m
//  RDVTabBarController
//
//  Created by Robert Dimitrov on 11/8/14.
//  Copyright (c) 2014 Robert Dimitrov. All rights reserved.
//

#import "LogInViewController.h"
#import "RDVTabBarController.h"
#import "ASIFormDataRequest.h"
#import "RDVAppDelegate.h"
extern NSString * IPaddress;
extern NSInteger palID;

@interface LogInViewController ()
-(void) login:(id)sender;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@end

@implementation LogInViewController
@synthesize username,password;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LogIn";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *txt1 = [[UILabel alloc] initWithFrame:CGRectMake(30,100,80,30)];
    [txt1 setText:@"Username"];
    [txt1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:txt1];
    
    UILabel *txt2 = [[UILabel alloc] initWithFrame:CGRectMake(30,140,80,30)];
    [txt2 setText:@"Password"];
    [txt2 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:txt2];
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(130,100, 150, 30)];
    [username setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:username];
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(130,140, 150, 30)];
    [password setBorderStyle:UITextBorderStyleRoundedRect];
    [password setSecureTextEntry:YES];
    [self.view addSubview:password];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"LogIn" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(90, 180, 150, 40)];
    [self.view addSubview:btn];
    
    
}


-(void) login:(id)sender
{
    //表单提交前的验证
    if (username.text.length==0||password.text.length==0 ) {
        UIAlertView * alertinput = [[UIAlertView alloc]initWithTitle:@"ALERT" message:@"Username and password must not be null!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alertinput.alertViewStyle=UIAlertViewStyleDefault;
        [alertinput show];
        return;
    }
    //隐藏键盘
    [username resignFirstResponder];
    [password resignFirstResponder];
    
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/login.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    //设置表单提交项
    [request setPostValue:username.text forKey:@"usernameid"];
    [request setPostValue:username.text forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
    palID = [username.text integerValue];
}

//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSString * requestcontent = [request responseString];
    NSLog(requestcontent);
    NSRange startofjson = [requestcontent rangeOfString:@"{" options:NULL];
    NSInteger index = startofjson.location;
    NSString * datatest = [requestcontent substringFromIndex:index];
    NSData  *data1  =  [datatest  dataUsingEncoding : NSUTF8StringEncoding];
    NSLog(datatest);
    NSError  *error  =  nil ;
    dictionary  =  [ [ CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
    NSString * yes = [dictionary objectForKey:@"yes"];
    NSString * name = [dictionary objectForKey:@"Name"];
    NSLog(yes);
    NSLog(name);
    if ([dictionary objectForKey:@"yes"]) {
        [self dismissViewControllerAnimated:YES completion:^(){
        }];
        NSLog(@"loginsucceed");

    }
    else if ([dictionary objectForKey:@"error"] != [NSNull null]) {
        NSLog(@"loginfailed");
        UIAlertView * alertinput = [[UIAlertView alloc]initWithTitle:@"LogIn Failed" message:@"Username or password error!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alertinput.alertViewStyle=UIAlertViewStyleDefault;
        [alertinput show];
    }

    return;
}

//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"HttpErr");
    UIAlertView * alertinput = [[UIAlertView alloc]initWithTitle:@"LogIn Failed" message:@"Network error!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alertinput.alertViewStyle=UIAlertViewStyleDefault;
    [alertinput show];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
/*
-(void) dealloc
{
    [username release];
    [password release];
    [super dealloc];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
