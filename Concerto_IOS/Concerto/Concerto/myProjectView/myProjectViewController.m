//
//  myProjectViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "myProjectViewController.h"
#import "CreateBase.h"
#import "YCMenuView.h"
#import "LSTPopView.h"
#import "PGDatePickManager.h"
#import "MJRefresh.h"
#import "ProjectDetailViewController.h"
@interface myProjectViewController ()<UITableViewDelegate,UITableViewDataSource,PGDatePickerDelegate>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong) UIView*popView;
@property(nonatomic,weak)LSTPopView *customView;
@property(nonatomic,strong)UITextField *PJname;
@property(nonatomic,strong)UITextField *starttime;
@property(nonatomic,strong)NSDate *startDate;
@property(nonatomic,strong)UITextField *endtime;
@property(nonatomic,strong)NSDate *endDate;
@property(nonatomic,strong)UITextView *dec;
@property(nonatomic,strong)UITextField *code;
@end

@implementation myProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.table];
   // [self LoadData];
   // [CreateBase updateProject];
    //[self.view addSubview:self.popView];
    // Do any additional setup after loading the view.
}
//-(UIView *)popView
//{
//    if(!_popView)
//    {
//
//    }
//    return _popView;
//}
-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topBar.frame)+1, screenwith, screenheight-self.tabBarController.tabBar.frame.size.height)];
        [_table setBackgroundColor:mainBackGroundColor];
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
        [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
            // 往下拉的时候文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
            // 松手时候的文字
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        
        _table.mj_header = header;
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
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_topBar addSubview:_addBtn];
        
    }
    return _topBar;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%@",indexPath);
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
    UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RencentProject)];
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
        UIButton *btn1 = [[UIButton alloc]initWithFrame:title1.frame];
        [btn1 addTarget:self action:@selector(RencentProject:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 30001;
        title1.text = @"+ 点击添加项目";
        [title1 addGestureRecognizer:reg];
        title1.userInteractionEnabled = YES;
        title1.numberOfLines = 0;
        title1 .font = [UIFont systemFontOfSize:20 weight:0.05];
        title1 .textColor = mainColor;
        //title1.font = [UIFont systemFontOfSize:25 weight:0.5];
        //title1.textColor = [CreateBase createColor:139 blue:120 green:85];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.tag = 20001;
        [view1 addSubview:title1];
        [view1 addSubview:btn1];
        [cell1 addSubview:view1];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(screenwith-view1.frame.size.width-view1.frame.origin.x, view1.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.cornerRadius = view1.layer.cornerRadius;
        view2.layer.masksToBounds = YES;
        view2.tag = 10002;
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:title2.frame];
        [btn2 addTarget:self action:@selector(RencentProject:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 30002;
        title2.text = @"+ 点击添加项目";
        title2.numberOfLines = 0;
        title2 .font = [UIFont systemFontOfSize:20 weight:0.05];
        title2 .textColor = mainColor;
        title2.textAlignment = NSTextAlignmentCenter;
        title2.tag = 20002;
        [view2 addSubview:title2];
        [view2 addSubview:btn2];
        [cell1 addSubview:view2];
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(view1.frame.origin.x, CGRectGetMaxY(view1.frame)+20, view1.frame.size.width, view1.frame.size.height)];
        view3.layer.cornerRadius = view1.layer.cornerRadius;
        view3.layer.masksToBounds = YES;
        view3.backgroundColor = [UIColor whiteColor];
        view3.tag = 10003;
        
        UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        UIButton *btn3 = [[UIButton alloc]initWithFrame:title3.frame];
        [btn3 addTarget:self action:@selector(RencentProject:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 30003;
        title3.text = @"+ 点击添加项目";
        title3 .font = [UIFont systemFontOfSize:20 weight:0.05];
        title3 .textColor = mainColor;
        title3.numberOfLines = 0;
        title3 .textAlignment = NSTextAlignmentCenter;
        title3 .tag = 20003;
        [view3 addSubview:title3 ];
        [view3 addSubview:btn3];
        [cell1 addSubview:view3];
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(view2.frame.origin.x, view3.frame.origin.y, view1.frame.size.width, view1.frame.size.height)];
        view4.backgroundColor = [UIColor whiteColor];
        view4.layer.cornerRadius = view1.layer.cornerRadius;
        view4.layer.masksToBounds = YES;
        view4.tag = 10004;
        
        
        UILabel *title4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        UIButton *btn4 = [[UIButton alloc]initWithFrame:title4.frame];
        btn4.tag = 30004;
        [btn4 addTarget:self action:@selector(RencentProject:) forControlEvents:UIControlEventTouchUpInside];
        title4 .text = @"+ 点击添加项目";
        title4.numberOfLines = 0;
        title4 .font = [UIFont systemFontOfSize:20 weight:0.05];
        title4 .textColor = mainColor;
        title4 .textAlignment = NSTextAlignmentCenter;
        title4 .tag = 20004;
        [view4 addSubview:title4 ];
        [view4 addSubview:btn4];
        [cell1 addSubview:view4];
        
        
    }
        
        for(int i = 0;i < MIN([AppData shareInstance].myProject.count, 4);i++)
        {
            UILabel *lab = [cell1 viewWithTag:20001+i];
            [lab addGestureRecognizer:reg];
            lab.userInteractionEnabled = YES;
            Project *pj =[AppData shareInstance].myProject[i];
            lab.text = pj.projectName;
            lab.font = [UIFont systemFontOfSize:25 weight:0.5];
            lab.textColor = [CreateBase createColor:139 blue:120 green:85];
            lab.textAlignment = NSTextAlignmentCenter;
        }
        cell1.contentView.hidden = YES;
        return cell1;
    }
    else
    {
        if(!cell2)
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
        publicer.text = @"发布人：";
        publicer.tag = 20003;
        publicer.font = [UIFont systemFontOfSize:14 weight:0.3];
        publicer.textColor = [UIColor grayColor];
        [contenView addSubview:publicer];
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(20, publicer.frame.origin.y,contenView.frame.size.width-40, 15)];
        time.textAlignment = NSTextAlignmentRight;
        time.text = @"2000.1.1";
        time.textColor = [UIColor grayColor];
            time.tag = 20004;
        time.font = [UIFont systemFontOfSize:14 weight:0.3];
        [contenView addSubview:time];
        
    }
        NSArray *pj = [AppData shareInstance].myProject;
        Project *mpj = pj[indexPath.row];
        UILabel *title = [cell2 viewWithTag:20001];
        UILabel *dec = [cell2 viewWithTag:20002];
        UILabel *publier = [cell2 viewWithTag:20003];
        UILabel *time = [cell2 viewWithTag:20004];
        publier.text = [NSString stringWithFormat:@"发布人：%@",[mpj.admin objectForKey:@"userName"]] ;
        title.text = mpj.projectName;
        dec.text = mpj.projectDescription;
        if(dec.text.length == 0)
        {
            dec.text = @"发布人还没有写简介哦～";
        }
       // publier = mpj.
        time.text = mpj.projectStartTime;
    }
    return cell2;
    
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
        return [AppData shareInstance].myProject.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        Project *pj = (Project *)[AppData shareInstance].myProject[indexPath.row];
        
        ProjectDetailViewController *p = [ProjectDetailViewController new];
        p.pj = pj;
        [[ViewManager shareInstance].NavigationController pushViewController:p animated:YES];
    }
}
-(void)addBtnClick
{
    YCMenuAction *action = [YCMenuAction actionWithTitle:@"新建项目" image:nil handler:^(YCMenuAction *action) {
        self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.7*ScreenWidth, 0.5*screenheight)];
        self.popView.backgroundColor = [UIColor whiteColor];
        self.popView.layer.cornerRadius = 20;
        self.popView.layer.masksToBounds = YES;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.05*self.popView.frame.size.height, self.popView.frame.size.width, 15)];
        lab.text  = @"新建项目";
        lab.font = [UIFont systemFontOfSize:14 weight:0.3];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.popView addSubview:lab];
        
        
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lab.frame)+30, 60, 25)];
        namelab.textAlignment = NSTextAlignmentLeft;
        namelab.text = @"项目名";
        namelab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:namelab];
        
        UILabel *startlab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(namelab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        startlab.textAlignment = NSTextAlignmentLeft;
        startlab.text = @"开始时间";
        startlab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:startlab];
        
        UILabel *endlab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(startlab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        endlab.textAlignment = NSTextAlignmentLeft;
        endlab.text = @"结束时间";
        endlab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:endlab];
        
        UILabel *declab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(endlab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        declab.textAlignment = NSTextAlignmentLeft;
        declab.text = @"项目描述";
        declab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:declab];
        UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, namelab.frame.origin.y-2, 0.5*self.popView.frame.size.width, 30)];
        name.placeholder = @" 请输入项目名";
        name.layer.borderColor = [CreateBase createColor:242].CGColor;
        name.layer.borderWidth = 1;
        name.layer.masksToBounds = YES;
        name.layer.cornerRadius = 5;
        self.PJname = name;
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:name];
        
        UITextField *start = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, CGRectGetMaxY(name.frame)+25, 0.5*self.popView.frame.size.width, 30)];
        start.placeholder = @" 请选择项目开始时间";
        start.layer.borderColor = [CreateBase createColor:242].CGColor;
        start.layer.borderWidth = 1;
        start.layer.masksToBounds = YES;
        start.layer.cornerRadius = 5;
        start.textAlignment = NSTextAlignmentCenter;
        start.font = [UIFont systemFontOfSize:14 weight:0.3];
        start.enabled = NO;
        self.starttime = start;
        UIButton *startbtn = [[UIButton alloc]initWithFrame:start.frame];
        startbtn.tag = 3001;
        [self.popView addSubview:startbtn];
        [startbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:start];
        
        UITextField *end = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, CGRectGetMaxY(start.frame)+25, 0.5*self.popView.frame.size.width, 30)];
        end.placeholder = @" 请选择项目结束时间";
        end.layer.borderColor = [CreateBase createColor:242].CGColor;
        end.layer.borderWidth = 1;
        end.textAlignment = NSTextAlignmentCenter;
        end.layer.masksToBounds = YES;
        end.enabled = NO;
        end.layer.cornerRadius = 5;
        self.endtime = end;
        UIButton *endbtn = [[UIButton alloc]initWithFrame:end.frame];
        endbtn.tag = 3002;
        [endbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:endbtn];
        UITextView *dec = [[UITextView alloc]initWithFrame:CGRectMake(namelab.frame.origin.x,CGRectGetMaxY(declab.frame)+10, self.popView.frame.size.width-2*namelab.frame.origin.x, 0.2*self.popView.frame.size.height)];
        dec.layer.borderWidth = 1;
        dec.layer.borderColor = [UIColor grayColor].CGColor;
        dec.layer.masksToBounds = YES;
        dec.layer.cornerRadius = 10;
        [self.popView addSubview:dec];
        self.dec = dec;
        UIButton *compelete = [[UIButton alloc]initWithFrame:CGRectMake(dec.frame.origin.x+10, CGRectGetMaxY(dec.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [compelete setBackgroundColor:mainColor];
        compelete.layer.cornerRadius = 10;
        compelete.layer.masksToBounds = YES;
        [compelete setTitle:@"确认" forState:UIControlStateNormal];
        [compelete addTarget:self action:@selector(compeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:compelete];
        
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.popView.frame.size.width-compelete.frame.origin.x-0.3*self.popView.frame.size.width, CGRectGetMaxY(dec.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [cancel setBackgroundColor:[CreateBase createColor:255 blue:194 green:123]];
        cancel.layer.cornerRadius = 10;
        cancel.layer.masksToBounds = YES;
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelClcik) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:cancel];
        if(CGRectGetMaxY(cancel.frame) > self.popView.frame.size
           .height)
        {
            self.popView.frame = CGRectMake(0, 0, self.popView.frame.size.width, CGRectGetMaxY(cancel.frame)+5);
        }
        
        
        end.font = [UIFont systemFontOfSize:14 weight:0.3];
        //[end addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:end];
        
        
        LSTPopView *cusView = [LSTPopView initWithCustomView:self.popView parentView:[UIApplication sharedApplication].keyWindow popStyle:LSTPopStyleFade dismissStyle:LSTDismissStyleFade];
        cusView.hemStyle = LSTHemStyleCenter;
        LSTPopViewWK(cusView);
        cusView.bgClickBlock = ^{
            [wk_cusView dismiss];
        };
        self.customView = cusView;
        [cusView pop];
    }];
    YCMenuAction *action2 = [YCMenuAction actionWithTitle:@"加入项目" image:nil handler:^(YCMenuAction *action) {
        self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.7*ScreenWidth, 0.2*screenheight)];
        self.popView.backgroundColor = [UIColor whiteColor];
        self.popView.layer.cornerRadius = 20;
        self.popView.layer.masksToBounds = YES;
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.1*self.popView.frame.size.height, self.popView.frame.size.width, 15)];
        lab.text  = @"加入项目";
        lab.font = [UIFont systemFontOfSize:14 weight:0.3];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.popView addSubview:lab];
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lab.frame)+30, 60, 25)];
        namelab.textAlignment = NSTextAlignmentLeft;
        namelab.text = @"邀请码";
        namelab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:namelab];
        
        UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, namelab.frame.origin.y-2, 0.5*self.popView.frame.size.width, 30)];
        name.placeholder = @" 请输入邀请码";
        name.layer.borderColor = [CreateBase createColor:242].CGColor;
        name.layer.borderWidth = 1;
        name.layer.masksToBounds = YES;
        name.layer.cornerRadius = 5;
        name.tag = 50001;
        self.code = name;
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:name];
        
        
        UIButton *compelete = [[UIButton alloc]initWithFrame:CGRectMake(namelab.frame.origin.x+10, CGRectGetMaxY(namelab.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [compelete setBackgroundColor:mainColor];
        compelete.layer.cornerRadius = 10;
        compelete.layer.masksToBounds = YES;
        [compelete setTitle:@"确认" forState:UIControlStateNormal];
        [compelete addTarget:self action:@selector(compeleteClick2:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:compelete];
        
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.popView.frame.size.width-compelete.frame.origin.x-0.3*self.popView.frame.size.width, CGRectGetMaxY(namelab.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [cancel setBackgroundColor:[CreateBase createColor:255 blue:194 green:123]];
        cancel.layer.cornerRadius = 10;
        cancel.layer.masksToBounds = YES;
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelClcik) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:cancel];
        if(CGRectGetMaxY(cancel.frame) > self.popView.frame.size
           .height)
        {
            self.popView.frame = CGRectMake(0, 0, self.popView.frame.size.width, CGRectGetMaxY(cancel.frame)+5);
        }
        
        LSTPopView *cusView = [LSTPopView initWithCustomView:self.popView parentView:[UIApplication sharedApplication].keyWindow popStyle:LSTPopStyleFade dismissStyle:LSTDismissStyleFade];
        cusView.hemStyle = LSTHemStyleCenter;
        LSTPopViewWK(cusView);
        cusView.bgClickBlock = ^{
            [wk_cusView dismiss];
        };
        self.customView = cusView;
        [cusView pop];
    }];
    NSArray *arr = @[action,action2];
    YCMenuView *view = [YCMenuView menuWithActions:arr width:90 atPoint:CGPointMake(self.addBtn.frame.origin.x+10, CGRectGetMaxY(self.addBtn.frame)+10)];
    view.menuColor = [UIColor whiteColor];
    view.separatorColor = [UIColor whiteColor];
    view.dismissOnselected = YES;
    view.dismissOnTouchOutside = YES;
    view.menuCellHeight = 60;
    view.textFont = [UIFont boldSystemFontOfSize:13];
    //view.
    [view show];
}
-(void)compeleteClick2:(UIButton *)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if(self.code.text.length == 0)
    {
        [CreateBase showMessage:@"请输入正确的邀请码"];
    }
    else
    {
        [LCProgressHUD showLoading:nil];
        NSString *url = [NSString stringWithFormat:@"/Project/Join/%@",self.code.text];
        [[ApiManager shareInstance]POST:url parameters:nil needsToken:YES Success:^(id responseObject) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];;
            NSLog(@"%@",dictionary);
            NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"data"]];
            if(data.length == 0)
            {
                [dictionary setObject:[NSDictionary new] forKey:@"data"];
            }
            RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
            if([obj isSuccessful])
            {
                [LCProgressHUD hide];
                [CreateBase showMessage:@"加入成功！"];
                [CreateBase updateProject];
                sleep(1);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view reloadInputViews];
                    [self.table reloadData];
                });
                [self cancelClcik];
            }
            else
            {
                [LCProgressHUD hide];
                [SVProgressHUD setMaximumDismissTimeInterval:1];
                [SVProgressHUD showErrorWithStatus:obj.message];
                sender.enabled = YES;
            }
            [LCProgressHUD hide];
            } Failure:^(id error) {
                [LCProgressHUD hide];
                [LCProgressHUD hide];
                [CreateBase showInternetFail];
                sender.enabled = YES;
                //[self.sendMsg setEnabled:YES];
            }];
    }
}

-(void)selectTime:(UIButton *)sender
{PGDatePickManager *manager = [[PGDatePickManager alloc]init];
    // manager.headerViewBackgroundColor = MainBgColor;
     manager.confirmButtonTextColor = [CreateBase createColor:0 blue:149 green:247];
     PGDatePicker *picker = manager.datePicker;
     picker.datePickerMode = PGDatePickerModeDate ;
     picker.language = @"zh-Hans";
     picker.delegate = self;
    if(sender.tag == 3001)
    {
        picker.minimumDate =[NSDate date];
        picker.tag = 30001;
    }
    else if(self.starttime.text.length == 0)
    {
        [CreateBase showMessage:@"请先选择开始日期"];
        return;
    }
    else
    {
        picker.minimumDate = self.startDate;
        picker.tag = 30002;
    }
    
    [self presentViewController:manager animated:YES completion:^{
            
    }];
    //NSLog(@"%d",sender.tag);
}
-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    NSString *date;
    date = [NSString stringWithFormat:@"%d-%02d-%02d",dateComponents.year,dateComponents.month,dateComponents.day];
    if(datePicker.tag == 30001)
    {
        self.starttime.text = date;
        self.startDate = [NSDate dateFromComponents:dateComponents];
        self.endtime.text = @"";
        self.endDate = nil;
    }
    else
    {
        self.endtime.text = date;
        self.endDate = [NSDate dateFromComponents:dateComponents];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)compeleteClick:(UIButton *)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if(self.PJname.text.length<=3)
    {
        [CreateBase showMessage:@"项目名称过短！"];
    }
    else if(self.PJname.text.length > 10)
    {
        [CreateBase showMessage:@"项目名称过长！"];
    }
    else if(self.starttime.text.length == 0)
    {
        [CreateBase showMessage:@"请选择开始时间"];
    }
    else if(self.endtime.text.length == 0)
    {
        [CreateBase showMessage:@"请选择结束时间"];
    }
    else
    {
        [LCProgressHUD showLoading:@""];
        sender.enabled = NO;
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setValue:self.PJname.text forKey:@"projectName"];
        [dic setValue:self.dec.text forKey:@"projectDescription"];
        [dic setValue:self.starttime.text forKey:@"projectStartTime"];
        [dic setValue:self.endtime.text forKey:@"projectEndTime"];
        [[ApiManager shareInstance]POST:@"/Project" parameters:dic needsToken:YES Success:^(id responseObject) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];
            NSLog(@"%@",dictionary);
            NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"data"]];;
            if(data.length == 0)
            {
                [dictionary setObject:[NSDictionary new] forKey:@"data"];
            }
            RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
            if([obj isSuccessful])
            {
                
                //[self LoadData];
                [CreateBase updateProject];
                sleep(1);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view reloadInputViews];
                    [self.table reloadData];
                });
                
                
                [CreateBase showMessage:@"项目创建成功！"];
                [self cancelClcik];
            }
            else
            {
                [CreateBase showMessage:@"创建失败！"];
                sender.enabled = YES;
            }
            [LCProgressHUD hide];
            } Failure:^(id error) {
                [LCProgressHUD hide];
                [CreateBase showInternetFail];
                sender.enabled = YES;
                //[self.sendMsg setEnabled:YES];
            }];
    }
}
-(void)cancelClcik
{
    [self.customView dismiss];
}

-(void)LoadData

{
    
    [self.table.mj_header beginRefreshing];
   
            [CreateBase updateProject];
        [self.view reloadInputViews];
        [self.table reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table.mj_header endRefreshing];
    });
    
    NSLog(@"执行了loadData，%@",[NSDate date]);
}
-(void)viewWillAppear:(BOOL)animated
{
    [CreateBase updateProject];
[self.view reloadInputViews];
[self.table reloadData];
}
-(void)RencentProject:(UIButton *)sender
{
   // NSLog(@"111");
    NSLog(@"%ld",sender.tag);
    if(sender.tag - 30000 <  [AppData shareInstance].myProject.count)
    {
        
        
        Project *pj = (Project *)[AppData shareInstance].myProject[sender.tag - 30001];
        
        ProjectDetailViewController *p = [ProjectDetailViewController new];
        p.pj = pj;
        [[ViewManager shareInstance].NavigationController pushViewController:p animated:YES];
        
    }
    else
    {
        self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.7*ScreenWidth, 0.5*screenheight)];
        self.popView.backgroundColor = [UIColor whiteColor];
        self.popView.layer.cornerRadius = 20;
        self.popView.layer.masksToBounds = YES;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.05*self.popView.frame.size.height, self.popView.frame.size.width, 15)];
        lab.text  = @"新建项目";
        lab.font = [UIFont systemFontOfSize:14 weight:0.3];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.popView addSubview:lab];



        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lab.frame)+30, 60, 25)];
        namelab.textAlignment = NSTextAlignmentLeft;
        namelab.text = @"项目名";
        namelab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:namelab];

        UILabel *startlab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(namelab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        startlab.textAlignment = NSTextAlignmentLeft;
        startlab.text = @"开始时间";
        startlab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:startlab];

        UILabel *endlab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(startlab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        endlab.textAlignment = NSTextAlignmentLeft;
        endlab.text = @"结束时间";
        endlab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:endlab];

        UILabel *declab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(endlab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
        declab.textAlignment = NSTextAlignmentLeft;
        declab.text = @"项目描述";
        declab.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:declab];
        UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, namelab.frame.origin.y-2, 0.5*self.popView.frame.size.width, 30)];
        name.placeholder = @" 请输入项目名";
        name.layer.borderColor = [CreateBase createColor:242].CGColor;
        name.layer.borderWidth = 1;
        name.layer.masksToBounds = YES;
        name.layer.cornerRadius = 5;
        self.PJname = name;
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont systemFontOfSize:14 weight:0.3];
        [self.popView addSubview:name];

        UITextField *start = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, CGRectGetMaxY(name.frame)+25, 0.5*self.popView.frame.size.width, 30)];
        start.placeholder = @" 请选择项目开始时间";
        start.layer.borderColor = [CreateBase createColor:242].CGColor;
        start.layer.borderWidth = 1;
        start.layer.masksToBounds = YES;
        start.layer.cornerRadius = 5;
        start.textAlignment = NSTextAlignmentCenter;
        start.font = [UIFont systemFontOfSize:14 weight:0.3];
        start.enabled = NO;
        self.starttime = start;
        UIButton *startbtn = [[UIButton alloc]initWithFrame:start.frame];
        startbtn.tag = 3001;
        [self.popView addSubview:startbtn];
        [startbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:start];

        UITextField *end = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, CGRectGetMaxY(start.frame)+25, 0.5*self.popView.frame.size.width, 30)];
        end.placeholder = @" 请选择项目结束时间";
        end.layer.borderColor = [CreateBase createColor:242].CGColor;
        end.layer.borderWidth = 1;
        end.textAlignment = NSTextAlignmentCenter;
        end.layer.masksToBounds = YES;
        end.enabled = NO;
        end.layer.cornerRadius = 5;
        self.endtime = end;
        UIButton *endbtn = [[UIButton alloc]initWithFrame:end.frame];
        endbtn.tag = 3002;
        [endbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:endbtn];
        UITextView *dec = [[UITextView alloc]initWithFrame:CGRectMake(namelab.frame.origin.x,CGRectGetMaxY(declab.frame)+10, self.popView.frame.size.width-2*namelab.frame.origin.x, 0.2*self.popView.frame.size.height)];
        dec.layer.borderWidth = 1;
        dec.layer.borderColor = [UIColor grayColor].CGColor;
        dec.layer.masksToBounds = YES;
        dec.layer.cornerRadius = 10;
        [self.popView addSubview:dec];
        self.dec = dec;
        UIButton *compelete = [[UIButton alloc]initWithFrame:CGRectMake(dec.frame.origin.x+10, CGRectGetMaxY(dec.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [compelete setBackgroundColor:mainColor];
        compelete.layer.cornerRadius = 10;
        compelete.layer.masksToBounds = YES;
        [compelete setTitle:@"确认" forState:UIControlStateNormal];
        [compelete addTarget:self action:@selector(compeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:compelete];


        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.popView.frame.size.width-compelete.frame.origin.x-0.3*self.popView.frame.size.width, CGRectGetMaxY(dec.frame)+20, 0.3*self.popView.frame.size.width, 30)];
        [cancel setBackgroundColor:[CreateBase createColor:255 blue:194 green:123]];
        cancel.layer.cornerRadius = 10;
        cancel.layer.masksToBounds = YES;
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelClcik) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:cancel];
        if(CGRectGetMaxY(cancel.frame) > self.popView.frame.size
           .height)
        {
            self.popView.frame = CGRectMake(0, 0, self.popView.frame.size.width, CGRectGetMaxY(cancel.frame)+5);
        }


        end.font = [UIFont systemFontOfSize:14 weight:0.3];
        //[end addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.popView addSubview:end];


        LSTPopView *cusView = [LSTPopView initWithCustomView:self.popView parentView:[UIApplication sharedApplication].keyWindow popStyle:LSTPopStyleFade dismissStyle:LSTDismissStyleFade];
        cusView.hemStyle = LSTHemStyleCenter;
        LSTPopViewWK(cusView);
        cusView.bgClickBlock = ^{
            [wk_cusView dismiss];
        };
        self.customView = cusView;
        [cusView pop];
    
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
