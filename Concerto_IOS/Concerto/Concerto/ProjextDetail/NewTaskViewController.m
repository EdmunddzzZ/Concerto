//
//  NewTaskViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "NewTaskViewController.h"
#import "PGDatePicker.h"
#import "PGDatePickManager.h"
#import "WSHPickerView.h"
#import "selectPersonViewController.h"
@interface NewTaskViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PGDatePickerDelegate>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIButton *complete;
@property(nonatomic,strong)UITextField *name;
@property(nonatomic,strong)UILabel *startTime;
@property(nonatomic,strong)UIButton *start;
@property(nonatomic,strong)UILabel *endTime;
@property(nonatomic,strong)UIButton *end;
@property(nonatomic,strong)UIView *tagView;
@property(nonatomic,strong)UIButton *tag;
@property(nonatomic,strong)UILabel *prioritylab;
@property(nonatomic,strong)UIButton *priority;
@property(nonatomic,strong)UILabel *partispantlab;
@property(nonatomic,strong)UIButton *partispant;
@property(nonatomic,strong)NSDate *Timestart;
@property(nonatomic,strong)NSDate *TimeEnd;
@property(nonatomic,strong)WSHPickerView *identityPick;
@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.table
     ];
    [self.view addSubview:self.identityPick];
    self.identityPick.hidden
    = YES;
   // [self.view addSubview:self.title1];
    // Do any additional setup after loading the view.
}
-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBar.frame), ScreenWidth, screenheight- CGRectGetMaxY(self.topBar.frame)) style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        [_table setBackgroundColor:mainBackGroundColor];
        
        
    }
    return _table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 250;
    }
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellid1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
    if(indexPath.section == 0)
    {
        if(!cell1)
        {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
            [cell1 setBackgroundColor:mainBackGroundColor];
            cell1.contentView.hidden = YES;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, screenwith-40, 250)];
            baseView.layer.cornerRadius = 10;
            baseView.layer.masksToBounds = YES;
            [baseView setBackgroundColor:[UIColor whiteColor
                                          ]];
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 15)];
            name.textAlignment = NSTextAlignmentLeft;
            name.font = [UIFont systemFontOfSize:14 weight:0.5];
            name.text = @"任务名称";
            name.textColor = [UIColor blackColor];
            [baseView addSubview:name];
            [cell1 addSubview:baseView];
            
            
            UILabel *startime = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame)+35, 60, 15)];
            startime.textAlignment = NSTextAlignmentLeft;
            startime.font = [UIFont systemFontOfSize:14 weight:0.5];
            startime.text = @"开始时间";
            startime.textColor = [UIColor blackColor];
            [baseView addSubview:startime];
            
            UILabel *endtime = [[UILabel alloc]initWithFrame:CGRectMake(baseView.frame.size.width/2, CGRectGetMaxY(name.frame)+35, 60, 15)];
            endtime.textAlignment = NSTextAlignmentLeft;
            endtime.font = [UIFont systemFontOfSize:14 weight:0.5];
            endtime.text = @"结束时间";
            endtime.textColor = [UIColor blackColor];
            [baseView addSubview:endtime];
            
            UILabel *Tag = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(startime.frame)+35, 60, 15)];
            Tag.textAlignment = NSTextAlignmentLeft;
            Tag.font = [UIFont systemFontOfSize:14 weight:0.5];
            Tag.text = @"Tag";
            Tag.textColor = [UIColor blackColor];
            [baseView addSubview:Tag];
            
            UILabel *pri = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(Tag.frame)+35, 60, 15)];
            pri.textAlignment = NSTextAlignmentLeft;
            pri.font = [UIFont systemFontOfSize:14 weight:0.5];
            pri.text = @"优先级";
            pri.textColor = [UIColor blackColor];
            [baseView addSubview:pri];
            
            UILabel *part = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(pri.frame)+35, 60, 15)];
            part.textAlignment = NSTextAlignmentLeft;
            part.font = [UIFont systemFontOfSize:14 weight:0.5];
            part.text = @"参与成员";
            part.textColor = [UIColor blackColor];
            [baseView addSubview:part];
            self.name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(name.frame)+20, name.frame.origin.y, baseView.frame.size.width-CGRectGetMaxX(name.frame)-40, 17)];
            [self.name setPlaceholder:@"请在此输入任务名称"];
            self.name.returnKeyType = UIReturnKeyDone;
            self.name.font = [UIFont systemFontOfSize:15 weight:0.5];
            self.name.delegate = self;
            [baseView addSubview:self.name];
            self.startTime  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startime.frame)+10, startime.frame.origin.y, screenwith/2-CGRectGetMaxX(startime.frame)-15, 15)];
            self.startTime.textColor = [CreateBase createColor:204];
            self.startTime.text = @"点击选择时间";
            self.startTime.font = [UIFont systemFontOfSize:13 weight:0.3];
            self.start = [[UIButton alloc]initWithFrame:self.startTime.frame];
            self.start.tag = 30001;
            [self.start addTarget:self action:@selector(TimeClick:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:self.startTime];
            [baseView addSubview:self.start];
            self.endTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(endtime.frame)+10, startime.frame.origin.y, screenwith/2-CGRectGetMaxX(startime.frame)-15, 15)];
            self.endTime.textColor = [CreateBase createColor:204];
            self.endTime.text = @"点击选择时间";
            self.endTime.font = [UIFont systemFontOfSize:13 weight:0.3];
            self.end = [[UIButton alloc]initWithFrame:self.endTime.frame];
            self.end.tag = 30002;
            [self.end addTarget:self action:@selector(TimeClick:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:self.end];
            [baseView addSubview:self.endTime];
            self.prioritylab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pri.frame)+10, pri.frame.origin.y, screenwith-CGRectGetMaxX(pri.frame)-10, 15)];
            self.prioritylab.textColor = [CreateBase createColor:204];
            self.prioritylab.text = @"点击选择优先级";
            self.prioritylab.font = [UIFont systemFontOfSize:15 weight:0.3];
            self.priority = [[UIButton alloc]initWithFrame:self.prioritylab.frame];
            self.priority.tag = 30003;
            [self.priority addTarget:self action:@selector(priClick) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:self.prioritylab];
            [baseView addSubview:self.priority];
            
            self.partispantlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pri.frame)+10, part.frame.origin.y, screenwith-CGRectGetMaxX(pri.frame)-10, 15)];
            self.partispantlab.textColor = [CreateBase createColor:204];
            self.partispantlab.text = @"点击选择参与人员";
            self.partispantlab.font = [UIFont systemFontOfSize:15 weight:0.3];
            self.partispant = [[UIButton alloc]initWithFrame:self.partispantlab.frame];
            self.partispant.tag = 30004;
            [self.partispant addTarget:self action:@selector(partispantClick) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:self.partispantlab];
            [baseView addSubview:self.partispant];
        }
        
        return  cell1;
    }
    else
    {
        if(!cell2)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid2"];
            [cell2 setBackgroundColor:mainBackGroundColor];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell2;
    }
}
-(void)partispantClick
{
    selectPersonViewController *s = [selectPersonViewController new];
    if(self.selectParts)
    {
        s.selected = self.selectParts;
    }
    s.parts = self.partispants;
    [[ViewManager shareInstance].NavigationController pushViewController:s animated:YES];
}
-(void)priClick
{
    [self.identityPick show];
}
-(void)TimeClick:(UIButton *)sender
{
    PGDatePickManager *manager = [[PGDatePickManager alloc]init];
        // manager.headerViewBackgroundColor = MainBgColor;
         manager.confirmButtonTextColor = [CreateBase createColor:0 blue:149 green:247];
         PGDatePicker *picker = manager.datePicker;
         picker.datePickerMode = PGDatePickerModeDate ;
         picker.language = @"zh-Hans";
         picker.delegate = self;
        if(sender.tag == 30001)
        {
            picker.minimumDate =[NSDate date];
            picker.tag = 30001;
        }
        else if(self.startTime.text.length == 0)
        {
            [CreateBase showMessage:@"请先选择开始日期"];
            return;
        }
        else
        {
            picker.minimumDate = self.Timestart;
            picker.tag = 30002;
        }
        
        [self presentViewController:manager animated:YES completion:^{
        }];
}
-(void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    NSString *date;
    date = [NSString stringWithFormat:@"%d-%02d-%02d",dateComponents.year,dateComponents.month,dateComponents.day];
    if(datePicker.tag == 30001)
    {
        self.startTime.text = date;
        self.Timestart = [NSDate dateFromComponents:dateComponents];
        if(self.TimeEnd)
        {
        self.endTime.text = @"点击选择时间";
        self.endTime.textColor = [CreateBase createColor:204];
        }
        self.TimeEnd = nil;
        
        self.startTime.textColor = [UIColor blackColor];
    }
    else
    {
        self.endTime.textColor = [UIColor blackColor];
        self.endTime.text = date;
        self.TimeEnd = [NSDate dateFromComponents:dateComponents];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    UILabel *_title1;
    _title1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenwith, 15)];
    _title1.font = [UIFont systemFontOfSize:14 weight:0.5];
    _title1.textColor = [UIColor blackColor];
    _title1.textAlignment = NSTextAlignmentLeft;
    if(section == 0)
    {
        _title1.text = @"基本资料";
    }
    else
    {
        _title1.text = @"子任务列表";
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(screenwith - 20 - 30, _title1.frame.origin.x, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"addTask"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addTask) forControlEvents:UIControlEventTouchUpInside];
        [head addSubview:btn];
    }
    [head addSubview:_title1];
    return head;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
       
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-35, screenwith, 20)];
        login.text = @"新建任务";
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
        [self.complete setTitleColor:mainColor forState:UIControlStateNormal];
        [self.complete.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.4]];
        [_topBar addSubview:self.complete];
        
        
    }
    return _topBar;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(WSHPickerView *)identityPick
{
    if(!_identityPick)
    {
        _identityPick = [[WSHPickerView alloc]initWithFrame:CGRectMake(0, 0, screenwith, screenheight) anddata:@[@"普通",@"有点紧急",@"紧急"]];
        [_identityPick.confirmbtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _identityPick;
}
-(void)confirmClick
{
    [self.identityPick hidden];
    if([self.identityPick.currentSelect isEqual:@"普通"])
    self.prioritylab.textColor = mainColor;
    else if([self.identityPick.currentSelect isEqual:@"有点紧急"])
        self.prioritylab.textColor = [CreateBase createColor:246 blue:180 green:57];
    else
        self.prioritylab.textColor = [UIColor redColor];
    self.prioritylab.text = self.identityPick.currentSelect;
}
-(void)viewWillAppear:(BOOL)animated
{
    if(self.selectParts.count != 0)
    {
        self.partispantlab.textColor = [UIColor blackColor];
        NSString *str = @"";
        for (participant *p in self.selectParts) {
            str = [NSString stringWithFormat:@"%@ %@",str,p.userName];
        }
        self.partispantlab.text = str;
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
