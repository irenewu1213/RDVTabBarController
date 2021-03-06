//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/6.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"
#import "ChatRecorderViewController.h"
#import "ChartMessage.h"
#import "ChartCellFrame.h"
#import "ChartCell.h"
#import "KeyBordVIew.h"
#import "NSString+DocumentPath.h"
#import "SettingContentViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"

extern NSInteger palID;
extern NSString * IPaddress;
extern NSString * chatwithIDNum;
NSString * sendContent;

@interface ChatRecorderViewController ()<UITableViewDataSource,UITableViewDelegate,KeyBordVIewDelegate,ChartCellDelegate,AVAudioPlayerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_contacts;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行

}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic,strong) KeyBordVIew *keyBordView;
@property (nonatomic,assign) BOOL recording;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;

@end

static NSString *const cellIdentifier=@"QQChart";

@implementation ChatRecorderViewController

 - (void)viewDidLoad {
     [super viewDidLoad];

     self.title=@"Pal chat";
     self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStylePlain];
     [self.tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];
     self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     self.tableView.allowsSelection = NO;
     self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
     self.tableView.dataSource=self;
     self.tableView.delegate=self;
     [self.view addSubview:self.tableView];
     
     
     self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-108, self.view.frame.size.width, 44)];
     self.keyBordView.delegate=self;
     [self.view addSubview:self.keyBordView];
     
     [self initwithData];
     
     
     UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [btn setTitle:@"    " forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(viewWillAppear:) forControlEvents:UIControlEventTouchUpInside];
     [btn setFrame:CGRectMake(90, 180, 300, 300)];
     [self.view addSubview:btn];
 }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(btnClick:) withObject:self afterDelay:0.2f];
    
    [[self rdv_tabBarController] setTabBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)initwithData
{
    self.cellFrames=[NSMutableArray array];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.cellFrame=self.cellFrames[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}

-(void)chartCell:(ChartCell *)chartCell tapContent:(NSString *)content
{
    if(self.player.isPlaying){
        
        [self.player stop];
    }
    //播放
    NSString *filePath=[NSString documentPathWith:content];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];

}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice]setProximityMonitoringEnabled:NO];
    [self.player stop];
    self.player=nil;
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
 
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
 
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
 
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled
{
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int fromto = 1;
    if(fromto){
        NSString * myid = [NSString stringWithFormat:@"%d", palID];
        chartMessage.icon=[myid stringByAppendingString:@".png"];
        chartMessage.messageType=1;
        chartMessage.content=textFiled.text;
        sendContent = textFiled.text;
        cellFrame.chartMessage=chartMessage;
        [self performSelector:@selector(sendMessage:) withObject:self afterDelay:0.2f];
        [self.cellFrames addObject:cellFrame];
        [self.tableView reloadData];
    }
    //滚动到当前行
    [self tableViewScrollCurrentIndexPath];
    textFiled.text=@"";
}
- (void)sendMessage:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/send.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
//  NSString * id = [NSString stringWithFormat:@"%ld",palID ];
    NSLog(@"send!!!");
    NSLog(chatwithIDNum);
    NSLog(sendContent);
    [request setPostValue:chatwithIDNum forKey:@"sendId"];
    [request setPostValue:sendContent forKey:@"sendContent"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResultSend:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}
- (void)btnClick:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/chat.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [request setPostValue:chatwithIDNum forKey:@"chatId"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}

//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{
//    NSString * taskcontent = @"{\"yes\": \"succeed\", \"ID\": \"2\", \"detail\": [{\"ID\": \"1\", \"content\": \"hello\"}, {\"ID\": \"1\", \"content\": \"hello\"}, {\"ID\": \"2\", \"content\": \"heloo\"}]}";
    [self initwithData];
    NSString * taskcontent = [request responseString];
    NSLog(taskcontent);
    NSRange startofjson = [taskcontent rangeOfString:@"{" options:NULL];
    NSInteger index = startofjson.location;
    NSString * datatest = [taskcontent substringFromIndex:index];
    NSData  *data1  =  [datatest  dataUsingEncoding : NSUTF8StringEncoding];
    NSError  *error  =  nil ;
    NSDictionary * dictionary  =  [[CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
    NSString * yes = [dictionary objectForKey:@"yes"];
    NSString * palid = [dictionary objectForKey:@"id"];
    NSMutableArray * detail = [dictionary objectForKey:@"detail"];
    for(NSDictionary * dict in detail)
    {
        NSString * chatid = [dict objectForKey:@"ID"];
        NSString * icon = [chatid stringByAppendingString:@".png"];
        NSString * content = [dict objectForKey:@"content"];
        NSString * messageType;
        if(palID == [chatid integerValue])
            messageType = @"1";
        else
            messageType = @"0";
        ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
        ChartMessage *chartMessage=[[ChartMessage alloc]init];
        chartMessage.dict = @{@"icon":icon,@"content":content,@"type":messageType};
        cellFrame.chartMessage=chartMessage;
        [self.cellFrames addObject:cellFrame];
    }
    
    [_tableView reloadData];
    return;
}
//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"HttpErr");
    
}

//获取请求结果
- (void)GetResultSend:(ASIHTTPRequest *)request{

    NSString * taskcontent = [request responseString];
    NSLog(@"result....");
    NSLog(taskcontent);
    NSRange startofjson = [taskcontent rangeOfString:@"{" options:NULL];
    NSInteger index = startofjson.location;
    NSString * datatest = [taskcontent substringFromIndex:index];
    NSData  *data1  =  [datatest  dataUsingEncoding : NSUTF8StringEncoding];
    NSError  *error  =  nil ;
    NSDictionary * dictionary  =  [[CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
    NSString * yes = [dictionary objectForKey:@"ID"];
    NSString * palid = [dictionary objectForKey:@"content"];
    [_tableView reloadData];
    return;
}

-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled
{
    [self tableViewScrollCurrentIndexPath];
    
}
-(void)tableViewScrollCurrentIndexPath
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellFrames.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)beginRecord
{
    if(self.recording)return;
    
    self.recording=YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
}
-(void)finishRecord
{
    self.recording=NO;
    [self.recorder stop];
    self.recorder=nil;
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    chartMessage.icon=[NSString stringWithFormat:@"icon%02d.png",random+1];
    chartMessage.messageType=random;
    chartMessage.content=self.fileName;
    cellFrame.chartMessage=chartMessage;
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    [self tableViewScrollCurrentIndexPath];
    
}

-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
