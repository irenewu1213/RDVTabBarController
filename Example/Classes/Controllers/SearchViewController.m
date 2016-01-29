// RDVSecondViewController.m
// RDVTabBarController
//
// Copyright (c) 2013 Robert Dimitrov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SearchViewController.h"
#import "RDVTabBarController.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "LogInViewController.h"
#import "ZLImageViewDisplayView.h"
#import "UIImageView+WebCache.h"
extern NSString * IPaddress;

@interface SearchViewController()<UITextFieldDelegate>{
    
}
- (void) SearchButtonClick:(id)sender;
- (void) GetErr:(ASIHTTPRequest *)request;
- (void) GetResult:(ASIHTTPRequest *)request;
@end


@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"HelPal";
    }
    return self;
}

#pragma mark - View lifecycle
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView  *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(100, 60, 120, 120)];
    [imageView setImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:imageView];
    
    UILabel *logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 180, 80, 40)];
    logoLabel.text=@"HelPal";
    [logoLabel setTextColor:[UIColor blueColor]];
    [self.view addSubview:logoLabel];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 220.0f, 170.0f, 30.0f)];
    textField.delegate = self;
    [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    textField.placeholder = @"search"; //默认显示的字
    
    [self.view addSubview:textField];
    
    UIButton  *searchButton =[[UIButton alloc] initWithFrame:CGRectMake(250, 220, 25, 25)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"SearchIcon@2x.png"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(SearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 150, 20)];
    label.textColor = [[UIColor alloc]initWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.7f];
    label.text = @"Help you around.";
    [self.view addSubview:label];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView  *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 120, 120)];
    [imageView setImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:imageView];
    
    UILabel *logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 150, 80, 40)];
    logoLabel.text=@"HelPal";
    logoLabel.textColor = [[UIColor alloc]initWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    [self.view addSubview:logoLabel];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 200.0f, 170.0f, 30.0f)];
    textField.delegate = self;
    [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    textField.placeholder = @"search"; //默认显示的字
    
    [self.view addSubview:textField];
    
    UIButton  *searchButton =[[UIButton alloc] initWithFrame:CGRectMake(250, 200, 25, 25)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"SearchIcon@2x.png"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(SearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 150, 20)];
    label.textColor = [[UIColor alloc]initWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.7f];
    label.text = @"Help you around.";
    [self.view addSubview:label];
    
    //recommendation
    //获取要显示的位置
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    CGRect frame = CGRectMake(30, 300, screenFrame.size.width - 60, 100);
    
    NSArray *imageArray = @[@"001.jpg", @"002.jpg", @"003.jpg", @"004.jpg", @"005.jpg", @"006.jpg"];
    
    //初始化控件
    ZLImageViewDisplayView *imageViewDisplay = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:frame];
    imageViewDisplay.imageViewArray = imageArray;
    imageViewDisplay.scrollInterval = 3;
    imageViewDisplay.animationInterVale = 0.6;
    [self.view addSubview:imageViewDisplay];
    
    [imageViewDisplay addTapEventForImageWithBlock:^(NSInteger imageIndex) {
        NSString *str = [NSString stringWithFormat:@"我是第%ld张图片", imageIndex];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }];
    
    
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Methods

- (void)SearchButtonClick:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString:  @"/AppDemo/query.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    //设置表单提交项
    [request setPostValue:textField.text forKey:@"query_content"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    NSLog(@"send a request...");
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
    NSDictionary * dictionary  =  [ [ CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
    NSString * yes = [dictionary objectForKey:@"yes"];
  
    if ([dictionary objectForKey:@"yes"]) {
        UIAlertView * sendSucceed = [[UIAlertView alloc]initWithTitle:@"Info" message:@"Your request has been sent to 5 Pals!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        sendSucceed.alertViewStyle=UIAlertViewStyleDefault;
        [sendSucceed show];
        textField.text = @"";
    }
    
    return;
}

//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"HttpErr");
    UIAlertView * netError = [[UIAlertView alloc]initWithTitle:@"ALERT" message:@"Network Error!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    netError.alertViewStyle=UIAlertViewStyleDefault;
    [netError show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    return YES;
}

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
