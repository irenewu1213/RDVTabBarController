//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/7.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ShowNotificationController.h"
#import "TaskDescription.h"
#import "KeyBoardVIew.h"
#import "NSString+DocumentPath.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"
#import "NoteCell.h"
#import "NoteCellFrame.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "ChatRecorderViewController.h"
#import "ChatViewController.h"

extern NSString * IPaddress;
NSInteger palID;
extern bool haspush;

@interface ShowNotificationController()<UITableViewDataSource,UITableViewDelegate,KeyBoardVIewDelegate,NoteCellDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_tasks;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cellsForTask;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) KeyBordVIew *keyBordView;

-(void) getNewTask:(id) sender;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@end

static NSString *const cellIdentifier=@"NoteIdentifier";

@implementation ShowNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"Notification";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStylePlain];
    [self.tableView registerClass:[NoteCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    [self performSelector:@selector(getNewTask:) withObject:self afterDelay:0.1f];
    
    self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-108, self.view.frame.size.width, 44)];
    self.keyBordView.delegate=self;
    [self.view addSubview:self.keyBordView];
    [self initData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES];
    
}
/*
- (void)viewWillDisappear:(BOOL)animated {
    //    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    [super viewWillDisappear:animated];
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellsForTask.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.cellFrame=self.cellsForTask[indexPath.row];
    UISwitch *sw=[[UISwitch alloc]init];
    [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView=sw;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellsForTask[indexPath.row] cellHeight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 加载数据
-(void)initData{
    _tasks = [[NSMutableArray alloc]init];
}

/*
#import <Foundation/Foundation.h>
#import "ShowNotificationController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"
#import "RDVTabBarController.h"
#import "TaskDescription.h"

@interface ShowNotificationController()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_tasks;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}
-(void) getNewTask:(id) sender;
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@end

@implementation ShowNotificationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self rdv_tabBarController] setTabBarHidden:1];
    self.title=@"Notefication";
    //初始化数据
    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    [self performSelector:@selector(getNewTask:) withObject:self afterDelay:0.2f];
    /*
    UIButton *acceptButton=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [acceptButton setFrame:CGRectMake(100, 200, 100, 400)];
    [acceptButton setTitle:@"     " forState:UIControlStateNormal];

    [acceptButton addTarget:self action:@selector(getNewTask:) forControlEvents:UIControlEventTouchUpInside];
 
//    [self.view addSubview:acceptButton];
    
}
*/

/*
#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    NSLog(@"计算分组数");
    return _tasks.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSLog(@"计算每组(组%li)行数",section);
    return 5;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0)
        return 25;
    else if(indexPath.row==1)
        return 40;
    else if(indexPath.row==2)
        return 40;
    else if(indexPath.row==3)
        return 40;
    else
        return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskDescription * task1 = _tasks[indexPath.section];
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row==0) {
        cell.detailTextLabel.textColor= [[UIColor alloc]initWithRed:131.0f/255.0f green:175.0f/255.0f blue:155.0f/255.0f alpha:1];
        cell.textLabel.text=@"";
        cell.detailTextLabel.text=@"New Task";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"PalName";
        cell.detailTextLabel.text=[task1 getName];
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"Location";
        cell.detailTextLabel.text=[task1 getLocation];
    }
    if (indexPath.row==3) {
        cell.textLabel.text=@"Task";
        cell.detailTextLabel.text=[task1 getAll];
    }
    return cell;
}
*/

-(void)viewWillDisappear:(BOOL)animated
{
    [self performSelector:@selector(getNewTask:) withObject:self afterDelay:0.0f];
    NSLog(@"----------in showNoti------------");
    
    [[self rdv_tabBarController] setTabBarHidden:0];
}

-(void)getNewTask:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/tasklist.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}
/*
-(void)reloadTaskNum:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/changeStatus.php"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
}
*/
//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{
    NSString * taskcontent = [request responseString];
    NSLog(taskcontent);
    
    NSRange startofjson = [taskcontent rangeOfString:@"{" options:NULL];
    NSInteger index = startofjson.location;
    NSString * datatest = [taskcontent substringFromIndex:index];
    NSData  *data1  =  [datatest  dataUsingEncoding : NSUTF8StringEncoding];
    NSError  *error  =  nil ;
    NSDictionary * dictionary  =  [[CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
    NSMutableArray *task_list = [dictionary objectForKey:@"task_list"];
    TaskDescription *task2;
    
    self.cellsForTask=[NSMutableArray array];
    for(NSDictionary * dict in task_list)
    {
        NSString * Requester_Id = [dict objectForKey:@"Requester_Id"];
        NSInteger rqsID = [Requester_Id integerValue];
        NSString * Name = [dict objectForKey:@"Name"];
        NSLog(Name);
        NSString * Status = [dict objectForKey:@"Status"];
        NSString * Detail = [dict objectForKey:@"Detail"];
        task2 = [TaskDescription initWithName:Name andLocationSite:@"Beijing" andPal:rqsID andTask:Detail andStatus:Status];
        [_tasks addObject:task2];
        
        NoteCellFrame *cellFrame=[[NoteCellFrame alloc]init];
        cellFrame.noteMessage = task2;
        [self.cellsForTask addObject:cellFrame];
    }
    [_tableView reloadData];
    
    return;
}

//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"HttpErr");
    UIAlertView * alertinput = [[UIAlertView alloc]initWithTitle:@"LogIn Failed" message:@"Network error!"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alertinput.alertViewStyle=UIAlertViewStyleDefault;
    [alertinput show];
}
/*
#pragma mark 点击行

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        ChatRecorderViewController *viewController = [[ChatRecorderViewController alloc] init];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
 */
@end
