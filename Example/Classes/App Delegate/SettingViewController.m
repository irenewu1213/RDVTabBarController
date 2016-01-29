//
//  KCMainViewController.m
//  UITableView
//
//  Created by Kenshin Cui on 14-3-1.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalInfo.h"
#import "SettingContentViewController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"

extern NSDictionary * dictionary;
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_user;//用户
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

@end

@implementation SettingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Setting";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView  *imageView2 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 453, 640, 1)];
    [imageView2 setImage:[UIImage imageNamed:@"line.jpg"]];
    [self.view addSubview:imageView2];
    
    [[self rdv_tabBarController] setTabBarHidden:0];
    //初始化数据
    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];

 }

#pragma mark 加载数据
-(void)initData{
    _user=[[NSMutableArray alloc]init];
    NSString * idNum = [dictionary objectForKey:@"ID"];
    NSInteger idNumber = [idNum integerValue];
    NSString * name = [dictionary objectForKey:@"Name"];
    NSString * gender = [dictionary objectForKey:@"Gender"];
    NSString * location = [dictionary objectForKey:@"Location"];
    NSString * skill = [dictionary objectForKey:@"Profile"];
    PersonalInfo *person1=[PersonalInfo initWithid: idNumber FirstName:@"" andLastName:name andGender:gender andLocation:@"Beijing"];
    [person1 addSkillTag:skill];
    [_user addObject:person1];
}
#pragma mark - UITableViewDataSource
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"numberOfSectionsInTableView");
    return 3;
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"numberOfRowsInSection %ld", section);
    if (0 == section) {
        // 第0组有多少行
        return 2;
    }else if (1 == section)
    {
        // 第1组有多少行
        return 3;
    }else if (2 == section)
    {
        return 1;
    }else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalInfo *Person2 =_user[0];
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标示去缓存池取
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section==0 && indexPath.row==0) {
        cell.textLabel.text=@"ID";
        NSString * id = [NSString stringWithFormat:@"%ld", Person2.idNumber];
        cell.detailTextLabel.text=id;
    }
    if (indexPath.section==0 && indexPath.row==1) {
        cell.textLabel.text=@"Name";
        cell.detailTextLabel.text=[Person2 getName] ;
    }
    
    if (indexPath.section==1 && indexPath.row==0) {
        cell.textLabel.text=@"Gender";
        cell.detailTextLabel.text=[Person2 getGender] ;
    }
    
    if (indexPath.section==1 && indexPath.row==1) {
        cell.textLabel.text=@"Skill";
        cell.detailTextLabel.text=[Person2 getSkillTag] ;
    }
    if (indexPath.section==1 && indexPath.row==2) {
        cell.textLabel.text=@"Location";
        cell.detailTextLabel.text = [Person2 getLocation] ;
    }
    if (indexPath.section==2 && indexPath.row==0) {
        cell.textLabel.text=@"Setting";
        cell.detailTextLabel.text=@"";
    }
    return cell;
}

/**
 *  第section组头部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // return @"标题";
    if (0 == section) {
        return @"";
    }else if(1 == section)
    {
        return @"";
    }else if (2 == section)
    {
        return @"";
    }else
    {
        return @"";
    }
}
/**
 *  第section组底部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (0 == section) {
        return @"";
    }else if(1 == section)
    {
        return @"";
    }else if (2 == section)
    {
        return @"";
    }else
    {
        return @"";
    }
}

/*
#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return _contacts.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",section);
    KCContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个对象，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",indexPath.section,indexPath.row);
    KCContactGroup *group=_contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    
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
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw=[[UISwitch alloc]init];
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=sw;

        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
    }
    
    if(indexPath.row==0){
        ((UISwitch *)cell.accessoryView).tag=indexPath.section;
    }
    
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
    NSLog(@"cell:%@",cell);
    
    return cell;
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 50;
    }
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
*/
#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath=indexPath;
    if (indexPath.section==2){
        SettingContentViewController *setting = [[SettingContentViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
    else
    {
        //创建弹出窗口
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pal Setting" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput; //设置窗口内容样式
        UITextField *textField= [alert textFieldAtIndex:0]; //取得文本框
        if(_selectedIndexPath.section ==1 && _selectedIndexPath.row==1) textField.text=[_user[0] getSkillTag];
        if(_selectedIndexPath.section ==1 && _selectedIndexPath.row==2) textField.text=[_user[0] getLocation];
        [alert show];
    }
    
}

#pragma mark 窗口的代理方法，用户保存数据
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //当点击了第二个按钮（OK）
    if (buttonIndex==1) {
        UITextField *textField= [alertView textFieldAtIndex:0];
        //修改模型数据
        PersonalInfo *person3 = _user[0];
        if (_selectedIndexPath.section==1 && _selectedIndexPath.row==1)
            person3.skillTag[0]=textField.text;
        if (_selectedIndexPath.section==1 && _selectedIndexPath.row==2)
            person3.location=textField.text;
        //刷新表格
        NSArray *indexPaths=@[_selectedIndexPath];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代码更新时的动画
    }
}



@end
