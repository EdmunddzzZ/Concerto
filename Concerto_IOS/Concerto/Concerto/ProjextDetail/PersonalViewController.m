//
//  PersonalViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "PersonalViewController.h"
#import "MJRefresh.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.table];
    // Do any additional setup after loading the view.
}

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenwith, screenheight-90-Safearea)];
        [_table setBackgroundColor:mainBackGroundColor];
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
            // 往下拉的时候文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
            // 松手时候的文字
        [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        
        _table.mj_header = header;
    }
    return _table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return self.shenqingren.count;
    return self.members.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 60)];
    view.backgroundColor = mainBackGroundColor;
    if(section == 0)
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 45/2, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"加入申请";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
        return view;
    }
    else
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 45/2, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"所有成员";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
    }
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"Cellid1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"Cellid2"];
    if(indexPath.section == 0)
    {
        if(!cell1)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cellid1"];
            cell1.backgroundColor = mainBackGroundColor;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.contentView.hidden = YES;
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(30, 10, screenwith-60, 120)];
            [backView setBackgroundColor:[UIColor whiteColor]];
            backView.layer.cornerRadius = 10;
            backView.layer.masksToBounds = YES;
            [cell1 addSubview:backView];
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 0.45*backView.frame.size.width, 15)];
            name.tag = 20001;
            name.textAlignment = NSTextAlignmentLeft;
            name.font = [UIFont systemFontOfSize:14 weight:0.5];
            name.text = @"用户名：";
            name.textColor = [UIColor blackColor];
            [backView addSubview:name];
            
            UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(name.frame)+30, backView.frame.size.width-60, 15)];
            email.textAlignment = NSTextAlignmentLeft;
            email.tag = 20002;
            email.font = [UIFont systemFontOfSize:14 weight:0.5];
            email.text = @"邮箱：";
            email.textColor = [UIColor blackColor];
            [backView addSubview:email];
            UIButton *agree = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(name.frame)+5, name.frame.origin.y-5, 0.2*backView.frame.size.width, 30)];
            agree.tag = 30000+indexPath.row;
            [agree setBackgroundColor:mainColor];
            [agree setTitle:@"同意" forState:UIControlStateNormal];
            [agree.titleLabel setFont:[UIFont systemFontOfSize:15 weight:0.5]];
            agree.layer.cornerRadius = 5;
            agree.layer.masksToBounds = YES;
            [agree addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:agree];
            
            
            UIButton *refuse = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(agree.frame)+10, name.frame.origin.y-5, 0.2*backView.frame.size.width, 30)];
            refuse.tag = 40000+indexPath.row;
            [refuse setBackgroundColor:[CreateBase createColor:245 blue:128 green:140]];
            [refuse setTitle:@"拒绝" forState:UIControlStateNormal];
            [refuse.titleLabel setFont:[UIFont systemFontOfSize:15 weight:0.5]];
            refuse.layer.cornerRadius = 5;
            refuse.layer.masksToBounds = YES;
            [refuse addTarget:self action:@selector(refuseClick:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:refuse];
        }
        UILabel *name = [cell1 viewWithTag:20001];
        UILabel *email = [cell1 viewWithTag:20002];
        
        participant *p = self.shenqingren[indexPath.row];
        name.text = [NSString stringWithFormat:@"用户名： %@",p.userName];
        email.text = [NSString stringWithFormat:@"邮箱： %@",p.userEmail];
        
        return cell1;
    }
    else
    {
        if(!cell2)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cellid2"];
            cell2.backgroundColor = mainBackGroundColor;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.contentView.hidden = YES;
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(30, 10, screenwith-60, 120)];
            [backView setBackgroundColor:[UIColor whiteColor]];
            backView.layer.cornerRadius = 10;
            backView.layer.masksToBounds = YES;
            [cell2 addSubview:backView];
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 0.45*backView.frame.size.width, 15)];
            name.tag = 20001;
            name.textAlignment = NSTextAlignmentLeft;
            name.font = [UIFont systemFontOfSize:14 weight:0.5];
            name.text = @"用户名：";
            name.textColor = [UIColor blackColor];
            [backView addSubview:name];
            
            UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(name.frame)+30, backView.frame.size.width-60, 15)];
            email.textAlignment = NSTextAlignmentLeft;
            email.tag = 20002;
            email.font = [UIFont systemFontOfSize:14 weight:0.5];
            email.text = @"邮箱：";
            email.textColor = [UIColor blackColor];
            [backView addSubview:email];
        }
        UILabel *name = [cell2 viewWithTag:20001];
        UILabel *email = [cell2 viewWithTag:20002];
        
        participant *p = self.members[indexPath.row];
        name.text = [NSString stringWithFormat:@"用户名： %@",p.userName];
        email.text = [NSString stringWithFormat:@"邮箱： %@",p.userEmail];
        return cell2;
    }
}
-(void)refreshData
{
    
    [self.table.mj_header beginRefreshing];
    [CreateBase updateProjectAtIndex:self.pjid finish:^{
        Project * p =[CreateBase searchProject:self.pjid];
        self.members = p.members;
        self.shenqingren = p.shenqing;
        [self.table reloadData];
        [self.table.mj_header endRefreshing];
    }];
}
-(void)agreeClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否同意人员申请？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LCProgressHUD showLoading:nil];
        participant *p = self.shenqingren[sender.tag-30000];
        NSDictionary *dic = @{@"projectId":[NSNumber numberWithInt:[self.pjid intValue]],@"userId":[NSNumber numberWithInt:[p.userId intValue]],@"operation":@"true"};
        [[ApiManager shareInstance]POST3:@"/project/applicant/auth" parameters:dic needsToken:YES Success:^(id responseObject) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];
            NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"data"]];;
            if(data.length == 0)
            {
                [dictionary setObject:[NSDictionary new] forKey:@"data"];
            }
            RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
            if([obj isSuccessful])
            {
                [LCProgressHUD hide];
                [CreateBase showMessage:@"操作成功!"];
                [self.shenqingren removeObject:p];
                [CreateBase updateProjectAtIndex:self.pjid finish:^{
                    Project * p =[CreateBase searchProject:self.pjid];
                    self.members = p.members;
                    self.shenqingren = p.shenqing;
                    [self.table reloadData];
                }];
            }
            else
            {
                [LCProgressHUD hide];
                [CreateBase showMessage:obj.message];
            }
                } Failure:^(id error) {
                    [LCProgressHUD hide];
                    [CreateBase showInternetFail];
                }];
    }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
    [self presentViewController:alert animated:YES completion:^{
            
    }];
}
-(void)refuseClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否拒绝人员申请？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LCProgressHUD showLoading:nil];
        participant *p = self.shenqingren[sender.tag-40000];
        NSDictionary *dic = @{@"projectId":[NSNumber numberWithInt:[self.pjid intValue]],@"userId":[NSNumber numberWithInt:[p.userId intValue]],@"operation":@"false"};
        [[ApiManager shareInstance]POST3:@"/project/applicant/auth" parameters:dic needsToken:YES Success:^(id responseObject) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];
            NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"data"]];;
            if(data.length == 0)
            {
                [dictionary setObject:[NSDictionary new] forKey:@"data"];
            }
            RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
            if([obj isSuccessful])
            {
                [LCProgressHUD hide];
                [CreateBase showMessage:@"操作成功!"];
                [self.shenqingren removeObject:p];
                [CreateBase updateProjectAtIndex:self.pjid finish:^{
                    Project * p =[CreateBase searchProject:self.pjid];
                    self.members = p.members;
                    self.shenqingren = p.shenqing;
                    [self.table reloadData];
                }];
            }
            else
            {
                [LCProgressHUD hide];
                [CreateBase showMessage:obj.message];
            }
                } Failure:^(id error) {
                    [LCProgressHUD hide];
                    [CreateBase showInternetFail];
                }];
    }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
    [self presentViewController:alert animated:YES completion:^{
            
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(void)viewWillAppear:(BOOL)animated
{
    Project *j = [CreateBase searchProject:self.pjid];
    self.members = j.members;
    self.shenqingren = j.shenqing;
    [self.table reloadData];
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
