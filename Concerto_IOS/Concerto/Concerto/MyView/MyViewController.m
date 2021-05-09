//
//  MyViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "MyViewController.h"
#import "LoginViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *HeaderView;
@property(nonatomic,strong)UIView *withoutTab;
@property(nonatomic,strong)HcdActionSheet *sheet;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.table];
    self.withoutTab.hidden = YES;
    if (@available(iOS 11.0, *)) {
           self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       }else {
           self.automaticallyAdjustsScrollViewInsets = NO;
       }

   
    [self.view setBackgroundColor:mainBackGroundColor];
    // Do any additional setup after loading the view.
}

-(UIView *)HeaderView
{
    if(!_HeaderView)
    {
        _HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 170)];
        [_HeaderView setBackgroundColor:[UIColor whiteColor]];
        UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(30, 35, 105, 105)];
        head.layer.cornerRadius = 52.5;
        head.layer.masksToBounds = YES;
        [head setBackgroundColor:mainColor];
        head.tag = 10001;
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(head.frame)+40, 67.5, screenwith, 15)];
        name.text = [AppData shareInstance].user_info.userName;
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:20 weight:0.3];
        name.textAlignment = NSTextAlignmentLeft;
        name.tag = 10002;
        UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame)+15, screenwith, 20)];
        email.text = [AppData shareInstance].user_info.userEmail;
        email.font = [UIFont systemFontOfSize:16 weight:0.3];
        email.textColor = [UIColor grayColor];
        email.tag = 10003;
        [_HeaderView addSubview:email];
        [_HeaderView addSubview:name];
        [_HeaderView addSubview:head];
    }
    return _HeaderView;
}
-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBar.frame), screenwith, screenheight-self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
        [_table setBackgroundColor:mainBackGroundColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.HeaderView;
        _table.bounces = NO;
        _table.showsVerticalScrollIndicator = NO;
        
        //self.sheet.hidden = YES;
       //[self.table addSubview:self.sheet];
    }
    return _table;
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0,0,screenwith,Safearea)];
        [_topBar setBackgroundColor:[UIColor whiteColor]];
    }
    return _topBar;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return 1;
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imgNames = @[@"我的留言",@"意见反馈",@"我的消息",@"设置",@"系统通知",@"帮助中心",@"退出登录"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor whiteColor]];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 30, 30)];
        [img setImage:[UIImage imageNamed:imgNames[indexPath.section*3+indexPath.row]]];
        [cell addSubview:img];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, screenwith-40, 1)];
        [line setBackgroundColor:[CreateBase createColor:237]];
        if(indexPath.row < 2 && indexPath.section != 2)
        [cell addSubview:line];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+20, 20, screenwith, 20)];
        title.text =imgNames[indexPath.section*3+indexPath.row];
        title.font = [UIFont systemFontOfSize:15 weight:0.3];
        title.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:title];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
        return 10;
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 30)];
    return view ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)//退出登录
    {
        self.sheet = [[HcdActionSheet alloc]initWithCancelStr:@"取消" otherButtonTitles:@[@"退出登录"] attachTitle:@"确定退出登录吗？"];
        [self.sheet changeTitleColor:[UIColor redColor] andIndex:1];
       self.sheet.seletedButtonIndex = ^(NSInteger index) {
           if(index == 1)
           {
           [[ViewManager shareInstance].NavigationController pushViewController:[LoginViewController new] animated:NO];
           [[AppData shareInstance] cleardata];
           }
       };
        [[UIApplication sharedApplication].keyWindow addSubview:self.sheet];
        
        [self.sheet showHcdActionSheet];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
