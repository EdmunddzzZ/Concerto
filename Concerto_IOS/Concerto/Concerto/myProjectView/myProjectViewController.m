//
//  myProjectViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "myProjectViewController.h"
#import "CreateBase.h"
@interface myProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UITableView *table;
@end

@implementation myProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.table];
    // Do any additional setup after loading the view.
}
-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topBar.frame)+1, screenwith, screenheight-self.tabBarController.tabBar.frame.size.height)];
        [_table setBackgroundColor:mainBackGroundColor];
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
        
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(35,_topBar.frame.size.height-30, screenwith, 20)];
        login.text = @"我的项目";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentLeft;
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        line.backgroundColor = [CreateBase createColor:228];
        [_topBar addSubview:line];
        [_topBar addSubview:login];
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-40, login.frame.origin.y, 25, 25)];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_topBar addSubview:_addBtn];
        
    }
    return _topBar;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
    if(indexPath.section == 0)
    {
    if(!cell1)
    {
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell1 setBackgroundColor:mainBackGroundColor];
       // [cell1 setBackgroundColor:[UIColor whiteColor]];
        //cell1.frame = CGRectMake(0, 0, screenwith, 340);
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(30, 20, 150, 150)];
        view1.layer.cornerRadius = 20;
        view1.layer.masksToBounds = YES;
        view1.tag = 10001;
        [view1 setBackgroundColor:[UIColor whiteColor]];
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        title1.text = @"Concerto";
        title1.font = [UIFont systemFontOfSize:25 weight:0.5];
        title1.textColor = [CreateBase createColor:139 blue:120 green:85];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.tag = 20001;
        [view1 addSubview:title1];
        [cell1 addSubview:view1];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(screenwith-view1.frame.size.width-view1.frame.origin.x, view1.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = view1.layer.cornerRadius;
        view2.layer.masksToBounds = YES;
        view2.tag = 10002;
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        title2.text = @"Concerto";
        title2.font = [UIFont systemFontOfSize:25 weight:0.5];
        title2.textColor = title1.textColor;
        title2.textAlignment = NSTextAlignmentCenter;
        title2.tag = 20002;
        [view2 addSubview:title2];
        
        [cell1 addSubview:view2];
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(view1.frame.origin.x, CGRectGetMaxY(view1.frame)+20, view1.frame.size.width, view1.frame.size.height)];
        view3.layer.cornerRadius = view1.layer.cornerRadius;
        view3.layer.masksToBounds = YES;
        view3.backgroundColor = [UIColor whiteColor];
        view3.tag = 10003;
        
        UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        title3 .text = @"Concerto";
        title3 .font = [UIFont systemFontOfSize:25 weight:0.5];
        title3 .textColor = title1.textColor;
        title3 .textAlignment = NSTextAlignmentCenter;
        title3 .tag = 20002;
        [view3 addSubview:title3 ];
        
        [cell1 addSubview:view3];
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(view2.frame.origin.x, view3.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
        view4.backgroundColor = [UIColor whiteColor];
        view4.layer.cornerRadius = view1.layer.cornerRadius;
        view4.layer.masksToBounds = YES;
        view4.tag = 10004;
        
        
        UILabel *title4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        title4 .text = @"+ 点击添加项目";
        title4 .font = [UIFont systemFontOfSize:20 weight:0.05];
        title4 .textColor = mainColor;
        title4 .textAlignment = NSTextAlignmentCenter;
        title4 .tag = 20002;
        [view4 addSubview:title4 ];
        
        [cell1 addSubview:view4];
        
        
    }
        return cell1;
    }
    else
    {
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell2 setBackgroundColor:mainBackGroundColor];
        UIView *contenView = [[UIView alloc]initWithFrame:CGRectMake(35, 0, screenwith-70, 175)];
        [contenView setBackgroundColor:[UIColor whiteColor]];
        contenView.layer.cornerRadius = 10;
        contenView.layer.masksToBounds = YES;
        
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, (57*1.0/136) * 175)];
        [titleView setBackgroundColor:[CreateBase createColor:255 blue:232 green:206]];
        [contenView addSubview:titleView];
        [cell2 addSubview:contenView];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenwith-70, titleView.frame.size.height)];
        title.textColor = [CreateBase createColor:139 blue:120 green:85];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:30 weight:0.5];
        title.text = @"Concerto";
        title.tag = 20001;
        [contenView addSubview:title];
        UILabel *dec = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleView.frame)+5, screenwith-70-40, contenView.frame.size.height-CGRectGetMaxY(titleView.frame)-30)];
        dec.numberOfLines = 0;
        dec.tag = 20002;
        dec.text = @"11234567890987654321`1234567890987654321`234567890987654312345676543567544567654321`";
        dec.textAlignment = NSTextAlignmentLeft;
        [contenView addSubview:dec];
        UILabel *publicer = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(dec.frame)+5, screenwith, 15)];
        publicer.text = @"发布人：sarise";
        publicer.tag = 20003;
        publicer.font = [UIFont systemFontOfSize:14 weight:0.3];
        publicer.textColor = [UIColor grayColor];
        [contenView addSubview:publicer];
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(20, publicer.frame.origin.y,contenView.frame.size.width-40, 15)];
        time.textAlignment = NSTextAlignmentRight;
        time.text = @"2000.1.1";
        time.textColor = [UIColor grayColor];
        time.font = [UIFont systemFontOfSize:14 weight:0.3];
        [contenView addSubview:time];
    }
    return cell2;
    return cell1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 340;
    }
    return 195;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 60)];
    view.backgroundColor = mainBackGroundColor;
    if(section == 0)
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 45/2, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"最近项目";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
        return view;
    }
    else
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 45/2, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"全部";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
    }
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    return 1;
    else
        return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        NSLog(@"点击了%@",indexPath);
    }
}
//固定头部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
CGFloat sectionHeaderHeight = 40;
if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
