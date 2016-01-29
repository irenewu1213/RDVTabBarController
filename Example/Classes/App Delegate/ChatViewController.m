//
//  KCMainViewController.m
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatContact.h"
#import "ContactGroup.h"
#import "ChatRecorderViewController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"
#import "SettingContentViewController.h"
#import "LogInViewController.h"
#import "ShowNotificationController.h"
#import "PersonalInfo.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

extern NSInteger palID;
extern NSString * IPaddress;
NSMutableArray * chatwithID;
NSString * chatwithIDNum;
NSInteger myBadge;
bool haspush ;

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_contacts;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
    UIViewController *_login;
}
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Pals";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    LogInViewController * _login = [[LogInViewController alloc]init];
    [self presentViewController:_login animated:YES completion:^(void){
        NSLog(@"return page done...");
    }];
    //初始化数据
//    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"    " forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(viewWillAppear:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(90, 180, 300, 300)];
    [self.view addSubview:btn];
    
}

- (void)viewWillAppear:(BOOL)animated {
//    if (shown < 2) {
        [self performSelector:@selector(getNewTask:) withObject:self afterDelay:0.1f];
    
 
//    }
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    [super viewWillDisappear:animated];
}

#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    PersonalInfo *notificationList = [PersonalInfo initWithid:0 FirstName:@"Notification" andLastName:@"" andGender:@"" andLocation:@""];
    ChatContact *c0 = [ChatContact initWithName:notificationList.firstName andSkill:@""];
    ContactGroup *group0=[ContactGroup initWithTitle:@"Note" andPersons:[NSMutableArray arrayWithObjects:c0,nil]];
    [_contacts addObject:group0];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _contacts.count;

}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"计算每组(组%li)行数",section);
    ContactGroup *grp1=_contacts[section];
    return grp1.persons.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactGroup *group=_contacts[indexPath.section];
    ChatContact * p1 =group.persons[indexPath.row];
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";
    //首先根据标示去缓存池取
    UITableViewCell *cell;

    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        if (indexPath.row==0) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifierForFirstRow];
        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
    }
/*  if(indexPath.row==0){
        ((UISwitch *)cell.accessoryView).tag=indexPath.section;
    }
*/
    
    cell.textLabel.text=[p1 getName];
    if(indexPath.section > 0)
    {
        cell.detailTextLabel.text=[@" " stringByAppendingString: p1.personSkill] ;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    if(indexPath.section > 0)
    {
        NSString * imageName = [chatwithID[indexPath.row] stringByAppendingString:@".png"];
        cell.imageView.image =  [UIImage imageNamed:imageName];
    }
    
    NSLog(@"cell:%@",cell);
    
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%li）名称",section);
    ContactGroup *group=_contacts[section];
    return group.name;
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark 点击行

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        ShowNotificationController *noteViewContrlloer = [[ShowNotificationController alloc]init];
        [self.navigationController pushViewController:noteViewContrlloer animated:YES];
        haspush ++;
    }
    else
    {
        ChatRecorderViewController *viewController = [[ChatRecorderViewController alloc] init];
        chatwithIDNum = chatwithID[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


-(void)getNewTask:(id)sender{
    NSString *urlstr = [IPaddress stringByAppendingString: @"/AppDemo/news.php"];
    NSLog(@"-----------in getNewTask--------------");
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}

//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request{
    [self initData];
    NSString * taskcontent = [request responseString];
    NSLog(taskcontent);
    NSRange startofjson = [taskcontent rangeOfString:@"{" options:NULL];
    NSInteger index = startofjson.location;
    NSString * datatest = [taskcontent substringFromIndex:index];
    NSData  *data1  =  [datatest  dataUsingEncoding : NSUTF8StringEncoding];
    NSError  *error  =  nil ;
    NSDictionary * dictionary  =  [[CJSONDeserializer  deserializer ]  deserializeAsDictionary : data1  error : &error ];
//    NSLog(dictionary);
    NSString * task_num = [dictionary objectForKey:@"task_num"];
    NSMutableArray * chat = [dictionary objectForKey:@"chat"];
    NSLog(task_num);
    ContactGroup *group1 = [ContactGroup initWithTitle:@"" andPersons:[NSMutableArray arrayWithObjects:nil]];
    
    chatwithID = [[NSMutableArray alloc]init];
    for(NSDictionary * dict in chat)
    {
        NSString * ID = [dict objectForKey:@"ID"];
        NSString * Name = [dict objectForKey:@"Name"];
        NSString * Skill = [dict objectForKey:@"Skill"];
        PersonalInfo *person1= [PersonalInfo initWithid:1 FirstName:Name andLastName:@"" andGender:@"" andLocation:@""];
        [person1 addSkillTag:Skill];
        ChatContact * c1 = [ChatContact initWithName:person1.getName andSkill:person1.getSkillTag];
        [group1 addPals:c1];
        [chatwithID addObject:ID];
    }
    [_contacts addObject:group1];
    NSInteger Badge = [task_num intValue];
    myBadge = Badge;
    if (Badge != 0 ) {
        [[self rdv_tabBarItem] setBadgeValue:task_num];
    }
    if (Badge == 0 ) {
        [[self rdv_tabBarItem] setBadgeValue:task_num];
    }
    [_tableView reloadData];
    
    return;
}
//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request{
    NSLog(@"HttpErr");
    
}
@end
