//
//  PersonalViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "PersonalViewController.h"

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
    }
    return _table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
        return cell2;
    }
}
-(void)agreeClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
}
-(void)refuseClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
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
