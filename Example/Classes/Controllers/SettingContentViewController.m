//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/7.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingContentViewController.h"
#import "ChatRecorderViewController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"
#import "RDVTabBarController.h"
#import "TaskDescription.h"
#import "PersonalInfo.h"

@interface SettingContentViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    TaskDescription *_task;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}
@end

@implementation SettingContentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self rdv_tabBarController] setTabBarHidden:1];
    self.title=@"Setting";
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
#pragma mark提交到服务器
-(void) butClick{
    
}
#pragma mark 加载数据
-(void)initData{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 3;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskDescription *task1 = _task;
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    if (indexPath.section==0 && indexPath.row==0) {
        cell.textLabel.text=@"Wallet";
        cell.detailTextLabel.text=task1.palName ;
    }
    if (indexPath.section==0 && indexPath.row==1) {
        cell.textLabel.text=@"Reputation";
        cell.detailTextLabel.text=task1.locationSite ;
    }
    if (indexPath.section==0 && indexPath.row==2) {
        cell.textLabel.text=@"Privacy&Security";
        cell.detailTextLabel.text=task1.task;
    }
    
    
    return cell;
}


#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath=indexPath;
    TaskDescription *task1=_task;
    //创建弹出窗口
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput; //设置窗口内容样式
    UITextField *textField= [alert textFieldAtIndex:0]; //取得文本框
    if(_selectedIndexPath.row==0) textField.text=task1.palName;
    if(_selectedIndexPath.row==1) textField.text=task1.locationSite;
    if(_selectedIndexPath.row==2) textField.text=task1.task;
    [alert show]; //显示窗口
}

#pragma mark 窗口的代理方法，用户保存数据
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //当点击了第二个按钮（OK）
    if (buttonIndex==1) {
        UITextField *textField= [alertView textFieldAtIndex:0];
        //修改模型数据
        //[_selectedIndexPath.row];
//        if(_selectedIndexPath.row==0);
        //刷新表格
        NSArray *indexPaths=@[_selectedIndexPath];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代码更新时的动画
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:0];
}


@end