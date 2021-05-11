//
//  selectPersonViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/9.
//

#import "selectPersonViewController.h"
#import "NewTaskViewController.h"
@interface selectPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIButton *complete;
@property(nonatomic,strong)UITableView *table;

@end

@implementation selectPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topBar];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.table];
    if(!self.selected)
    {
        self.selected = [NSMutableArray new];
    }
    // Do any additional setup after loading the view.
}
-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBar.frame)+1, ScreenWidth, screenheight- CGRectGetMaxY(self.topBar.frame)) style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        [_table setBackgroundColor:mainBackGroundColor];
        
        
    }
    return _table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.parts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenwith, 15)];
        name.textAlignment = NSTextAlignmentLeft;
        name.tag = 10001;
        name.font = [UIFont systemFontOfSize:15 weight:0.5];
        name.textColor = [UIColor blackColor];
        [cell addSubview:name];
        UIImageView *select = [[UIImageView alloc]initWithFrame:CGRectMake(screenwith - 40, name.frame.origin.y, 20, 20)];
        select.image = [UIImage imageNamed:@"select"];
        select.tag = 10002;
        select.hidden = YES;
        [cell addSubview:select];
    }
    UILabel *name = [cell viewWithTag:10001];
    participant *p =(participant *)self.parts[indexPath.row];
    name.text = p.userName;
    UIImageView *img = [cell viewWithTag:10002];
    if(self.selected)
    {
        for (participant *p in self.selected)
        {
            if([name.text isEqual:p.userName])
            {
                img.hidden = NO;
                break;
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    UIImageView *image = [cell viewWithTag:10002];
    
    participant *p = self.parts[indexPath.row];
    if(image.hidden == YES)
    {
        image.hidden = NO;
        [self.selected addObject:p];
    }
    else
    {
        image.hidden = YES;
        [self.selected removeObject:p];
    }
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
       
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-35, screenwith, 20)];
        login.text = @"选择参与人员";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentCenter;
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _topBar.frame.size.height-30, 20, 20)];
        [backBtn addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        backBtn.adjustsImageWhenHighlighted = NO;
        [_topBar addSubview:backBtn];
        //UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        //line.backgroundColor = [CreateBase createColor:228];
        //[_topBar addSubview:line];
        [_topBar addSubview:login];
        self.complete = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-65, login.frame.origin.y+5, 55, 15)];
        [self.complete setTitle:@"完 成" forState:UIControlStateNormal];
        [self.complete addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
        [self.complete setTitleColor:mainColor forState:UIControlStateNormal];
        [self.complete.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.4]];
        [_topBar addSubview:self.complete];
        
        
    }
    return _topBar;
}
-(void)backToPreView
{
    [CreateBase backToPreView];
}
-(void)completeClick
{
    NSArray *array = [ViewManager shareInstance].NavigationController.viewControllers;
    for(int i = 0;i < array.count;i++)
    {
        if([array[i] isKindOfClass:NewTaskViewController.class])
        {
            NewTaskViewController *task = array[i];
            task.selectParts = self.selected;
            break;
        }
    }
    [[ViewManager shareInstance].NavigationController popViewControllerAnimated:YES];
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
