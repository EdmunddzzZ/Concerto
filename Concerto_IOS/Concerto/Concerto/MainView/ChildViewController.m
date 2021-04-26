//
//  ChildViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "ChildViewController.h"
#import "CreateBase.h"
#import "MJRefresh.h"
@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *isEmpty;
@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.isEmpty];
    [self.view setBackgroundColor:mainBackGroundColor];
    
    if(_planArrays.count == 0)
    {
        //self.tableView.hidden = YES;
    }
    else
    {
        self.isEmpty.hidden = YES;
    }
    // Do any additional setup after loading the view.
}
-(UILabel *)isEmpty
{
    if(!_isEmpty)
    {
        _isEmpty = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-150, screenwith, 15)];
        _isEmpty.text = @"这里空空如也哦～";
        _isEmpty.textColor = mainColor;
        _isEmpty.textAlignment = NSTextAlignmentCenter;
        
    }
    return _isEmpty;
}
-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, screenwith,    MAX(130*_planArrays.count, screenheight-self.tabBarController.tabBar.frame.size.height)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = mainBackGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
            // 往下拉的时候文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
            // 松手时候的文字
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        
        _tableView.mj_header = header;
        //[_tableView setBounces:NO];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.planArrays.count;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50)];
//    if(section == 1)
//    {
//        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50)];
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, screenwith, 15)];
//        lab.text = @"已完成";
//        lab.textAlignment = NSTextAlignmentLeft;
//        [header addSubview:lab];
//        return header;
//    }
//    return header;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    if(section == 1)
//    return 50;
//    return 0;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    if(!cell)
    {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
        cell.backgroundColor = mainBackGroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(25, 15, screenwith-50, 130-15)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 8;
        contentView.layer.masksToBounds = YES;
        [cell addSubview:contentView];
        UIView *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 5, contentView.frame.size.height)];
        leftLine.backgroundColor = mainColor;
        [contentView addSubview:leftLine];
        UIButton *complete = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 25, 20)];
        complete.tag = 10001;
        [complete.layer setBorderWidth:2];
        [complete.layer setBorderColor:mainColor.CGColor];
        complete.layer.cornerRadius = 10;
        complete.layer.masksToBounds = YES;
        [contentView addSubview:complete];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(complete.frame)+10, 12, screenwith-50-55-20, 15)];
        title.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题";
        title.font = [UIFont systemFontOfSize:15 weight:0.5];
        [contentView addSubview:title];
        UIView *sonComplete = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(complete.frame)+20, 50, 20)];
        [sonComplete setBackgroundColor:[CreateBase createColor:247]];
        sonComplete.layer.cornerRadius = 10;
        sonComplete.layer.masksToBounds = YES;
        [contentView addSubview:sonComplete];
        UILabel *sonCompleteLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        sonCompleteLab.text = @"0/3";
        sonCompleteLab.font = [UIFont systemFontOfSize:14 weight:0.3];
        sonCompleteLab.textAlignment = NSTextAlignmentCenter;
        [sonComplete addSubview:sonCompleteLab];
        
        UILabel *taglab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab1.text = @"tag1";
        taglab1.numberOfLines = 1;
        
        taglab1.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize = [taglab1 sizeThatFits:CGSizeMake(100, 100)];
        taglab1.frame = CGRectMake(10, 0, expectSize.width, 20);
        taglab1.textAlignment = NSTextAlignmentCenter;
        UIView *tag1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sonComplete.frame)+15, sonComplete.frame.origin.y, expectSize.width+20, 20)];
        tag1.tag = 30001;
        tag1.layer.cornerRadius = expectSize.width/3;
        tag1.layer.masksToBounds = YES;
        [tag1 setBackgroundColor:mainColor];
        [tag1 addSubview:taglab1];
        [contentView addSubview:tag1];
        
        UILabel *taglab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab2.text = @"tag2";
        taglab2.numberOfLines = 1;
        
        taglab2.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize2 = [taglab2 sizeThatFits:CGSizeMake(100, 100)];
        taglab2.frame = CGRectMake(10, 0, expectSize2.width, 20);
        taglab2.textAlignment = NSTextAlignmentCenter;
        UIView *tag2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag1.frame)+15, sonComplete.frame.origin.y, expectSize2.width+20, 20)];
        tag2.tag = 30002;
        tag2.layer.cornerRadius = expectSize2.width/3;
        tag2.layer.masksToBounds = YES;
        [tag2 setBackgroundColor:mainColor];
        [tag2 addSubview:taglab2];
        [contentView addSubview:tag2];
        
        UILabel *taglab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab3.text = @"tag13333333";
        taglab3.numberOfLines = 1;
        
        taglab3.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize3= [taglab3 sizeThatFits:CGSizeMake(100, 100)];
        taglab3.frame = CGRectMake(10, 0, expectSize3.width, 20);
        taglab3.textAlignment = NSTextAlignmentCenter;
        UIView *tag3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag2.frame)+15, sonComplete.frame.origin.y, expectSize3.width+20, 20)];
        tag3.tag = 30003;
        tag3.layer.cornerRadius = expectSize.width/3;
        tag3.layer.masksToBounds = YES;
        [tag3 setBackgroundColor:mainColor];
        [tag3 addSubview:taglab3];
        [contentView addSubview:tag3];
        
        UIView *dayline = [[UIView alloc]initWithFrame:CGRectMake(sonComplete.frame.origin.x+20, CGRectGetMaxY(sonComplete.frame)+15, 2, 20)];
        dayline.tag = 40001;
        [dayline setBackgroundColor:mainColor];
        [contentView addSubview:dayline];
        
        UILabel *leftDay = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayline.frame)+10, dayline.frame.origin.y+2, 30, 15)];
        leftDay.tag = 50001;
        leftDay.text = @"3天";
        leftDay.font = [UIFont systemFontOfSize:14 weight:0.2];
        [contentView addSubview:leftDay];
    
        UILabel *people = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftDay.frame)+20, leftDay.frame.origin.y, screenwith-CGRectGetMaxX(leftDay.frame)-100, 15)];
        people.text = @"saries saries2 saries3";
        people.textAlignment = NSTextAlignmentRight;
        people.font = [UIFont systemFontOfSize:14 weight:0.2];
        people.textColor = [CreateBase createColor:127];
        [contentView addSubview:people];
        
        
        
        
        
        //UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, screenwith, 1)];
        //[line setBackgroundColor:[UIColor grayColor]];
        
        //[cell addSubview:line];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%@",indexPath);
}
-(void)refreshData
{
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header endRefreshing];
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
