//
//  NewTaskViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "TaskDetailViewController.h"
#import "PGDatePicker.h"
#import "PGDatePickManager.h"
#import "WSHPickerView.h"
#import "selectPersonViewController.h"
#import "LSTPopView.h"
#import "DCColorPicker.h"
@interface TaskDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PGDatePickerDelegate>
@property(nonatomic,assign)bool status;
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIButton *complete;
@property(nonatomic,strong)UITextField *name;
@property(nonatomic,strong)UILabel *startTime;
@property(nonatomic,strong)UIButton *start;
@property(nonatomic,strong)UILabel *endTime;
@property(nonatomic,strong)UIButton *end;
@property(nonatomic,strong)UIScrollView *tagView;
@property(nonatomic,strong)UIButton *tag;
@property(nonatomic,strong)UILabel *prioritylab;
@property(nonatomic,strong)UIButton *priority;
@property(nonatomic,strong)UILabel *partispantlab;
@property(nonatomic,strong)UIButton *partispant;
@property(nonatomic,strong)NSDate *Timestart;
@property(nonatomic,strong)NSDate *TimeEnd;
@property(nonatomic,strong)WSHPickerView *identityPick;
//@property(nonatomic,strong)NSMutableArray *Tags;
@property(nonatomic,weak) LSTPopView *cusView;
@property(nonatomic,strong)UIView *popView;
@property(nonatomic,assign)NSInteger priorityNum;

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = 0;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    self.Timestart = [format dateFromString:self.task.taskStartTime];
    self.TimeEnd = [format dateFromString:self.task.taskEndTime];
    self.selectParts = [NSMutableArray new];
    self.priorityNum = [self.task.taskPriority integerValue];
    for (NSDictionary *p in self.task.participants)
    {
        participant *d = [[participant alloc]initWithDictionary:p error:nil];
        [self.selectParts addObject:d];
    }
    [self.view setBackgroundColor:mainBackGroundColor];
    
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.table
     ];
    
    [self.view addSubview:self.identityPick];
    self.identityPick.hidden
    = YES;
    self.tags = [NSMutableArray new];
  
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
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 15)];
            name.textAlignment = NSTextAlignmentLeft;
            name.font = [UIFont systemFontOfSize:14 weight:0.5];
            name.text = @"任务名称:";
            name.textColor = [UIColor blackColor];
            [baseView addSubview:name];
            [cell1 addSubview:baseView];
            
            
            UILabel *startime = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(name.frame)+35, 70, 15)];
            startime.textAlignment = NSTextAlignmentLeft;
            startime.font = [UIFont systemFontOfSize:14 weight:0.5];
            startime.text = @"开始时间:";
            startime.textColor = [UIColor blackColor];
            [baseView addSubview:startime];
            
            UILabel *endtime = [[UILabel alloc]initWithFrame:CGRectMake(baseView.frame.size.width/2-10, CGRectGetMaxY(name.frame)+35, 70, 15)];
            endtime.textAlignment = NSTextAlignmentLeft;
            endtime.font = [UIFont systemFontOfSize:14 weight:0.5];
            endtime.text = @"结束时间:";
            endtime.textColor = [UIColor blackColor];
            [baseView addSubview:endtime];
            
            UILabel *Tag = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(startime.frame)+35, 60, 15)];
            Tag.textAlignment = NSTextAlignmentLeft;
            Tag.font = [UIFont systemFontOfSize:14 weight:0.5];
            Tag.text = @"Tag:";
            Tag.textColor = [UIColor blackColor];
            [baseView addSubview:Tag];
            self.tagView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Tag.frame)-10, Tag.frame.origin.y -10, baseView.frame.size.width - CGRectGetMaxX(Tag.frame)-20, 35)];
            UIButton *addtag = [[UIButton alloc]initWithFrame:CGRectMake(self.tagView.frame.size.width-27, 0, 23, 23)];
            [addtag addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
            [addtag setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            addtag.tag = 9001;
            [self.tagView addSubview:addtag];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tagView.frame.size.width, self.tagView.frame.size.height)];
            lab.text = @"点击添加Tag";
            lab.tag = 50001;
            lab.textColor = [CreateBase createColor:204];
            [self.tagView addSubview:lab];
            
           // [self.tagView setBackgroundColor:[UIColor greenColor]];
            self.tag = [[UIButton alloc]initWithFrame:self.tagView.frame];
            [self.tag addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
            
            [baseView addSubview:self.tagView];
            [baseView addSubview:self.tag];
            UILabel *pri = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(Tag.frame)+35, 60, 15)];
            pri.textAlignment = NSTextAlignmentLeft;
            pri.font = [UIFont systemFontOfSize:14 weight:0.5];
            pri.text = @"优先级:";
            pri.textColor = [UIColor blackColor];
            [baseView addSubview:pri];
            
            UILabel *part = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(pri.frame)+35, 70, 15)];
            part.textAlignment = NSTextAlignmentLeft;
            part.font = [UIFont systemFontOfSize:13 weight:0.5];
            part.text = @"参与成员:";
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
            self.startTime.font = [UIFont systemFontOfSize:12 weight:0.3];
            self.start = [[UIButton alloc]initWithFrame:self.startTime.frame];
            self.start.tag = 30001;
            [self.start addTarget:self action:@selector(TimeClick:) forControlEvents:UIControlEventTouchUpInside];
            [baseView addSubview:self.startTime];
            [baseView addSubview:self.start];
            self.endTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(endtime.frame)+10, startime.frame.origin.y, screenwith/2-CGRectGetMaxX(startime.frame)-15, 15)];
            self.endTime.textColor = [CreateBase createColor:204];
            self.endTime.text = @"点击选择时间";
            self.endTime.font = [UIFont systemFontOfSize:12 weight:0.3];
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
        [self initData];
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
-(void)tagClick
{
    if(self.tags.count == 3)
    {
        [CreateBase showMessage:@"最多只能创建3个Tag哦～～"];
        return;
    }
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0.8*screenwith, 0.2*ScreenHeight)];
    self.popView.layer.cornerRadius = 10;
    self.popView.layer.masksToBounds = YES;
    [self.popView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.05*self.popView.frame.size.height, self.popView.frame.size.width, 15)];
    lab.text  = @"添加Tag";
    lab.font = [UIFont systemFontOfSize:14 weight:0.3];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.popView addSubview:lab];
    
    UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lab.frame)+30, 60, 25)];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.text = @"Tag名称";
    namelab.tag = 20001;
    namelab.font = [UIFont systemFontOfSize:14 weight:0.3];
    [self.popView addSubview:namelab];
    
    
    
    UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+15, namelab.frame.origin.y-2, 0.5*self.popView.frame.size.width, 30)];
    name.placeholder = @" 请输入Tag名称";
    name.tag = 10005;
    [name addTarget:self action:@selector(upToFive:) forControlEvents:UIControlEventEditingChanged];
    name.layer.borderColor = [CreateBase createColor:242].CGColor;
    name.layer.borderWidth = 1;
    name.layer.masksToBounds = YES;
    name.layer.cornerRadius = 5;
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:14 weight:0.3];
    [self.popView addSubview:name];
    
    UILabel *startlab = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(namelab.frame)+30, namelab.frame.size.width, namelab.frame.size.height)];
    startlab.textAlignment = NSTextAlignmentLeft;
    startlab.text = @"背景颜色";
    startlab.font = [UIFont systemFontOfSize:14 weight:0.3];
    [self.popView addSubview:startlab];
    
    
    UIButton *startbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelab.frame)+20, CGRectGetMaxY(name.frame)+25, 0.5*self.popView.frame.size.width, 30)];
    [startbtn setTitle:@"+ 点击选择颜色" forState:UIControlStateNormal];
    [startbtn setTitleColor:mainColor forState:UIControlStateNormal];
    [startbtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:0.5]];
    startbtn.layer.borderWidth = 1;
    startbtn.layer.borderColor = mainColor.CGColor;
    startbtn.layer.cornerRadius = 3;
    startbtn.layer.masksToBounds = YES;
    startbtn.tag = 3001;
    [self.popView addSubview:startbtn];
    [startbtn addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *compelete = [[UIButton alloc]initWithFrame:CGRectMake(startlab.frame.origin.x+10, CGRectGetMaxY(startbtn.frame)+30, 0.3*self.popView.frame.size.width, 30)];
    [compelete setBackgroundColor:mainColor];
    compelete.layer.cornerRadius = 10;
    compelete.layer.masksToBounds = YES;
    compelete.tag = 40001;
    [compelete setTitle:@"确认" forState:UIControlStateNormal];
    [compelete addTarget:self action:@selector(compeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:compelete];
    
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(self.popView.frame.size.width-compelete.frame.origin.x-0.3*self.popView.frame.size.width, CGRectGetMaxY(startbtn.frame)+30, 0.3*self.popView.frame.size.width, 30)];
    [cancel setBackgroundColor:[CreateBase createColor:255 blue:194 green:123]];
    cancel.layer.cornerRadius = 10;
    cancel.layer.masksToBounds = YES;
    cancel.tag = 40002;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:cancel];
    if(CGRectGetMaxY(cancel.frame) > self.popView.frame.size
       .height)
    {
        self.popView.frame = CGRectMake(0, 0, self.popView.frame.size.width, CGRectGetMaxY(cancel.frame)+5);
    }
    
    LSTPopView *cusView = [LSTPopView initWithCustomView:self.popView parentView:[UIApplication sharedApplication].keyWindow popStyle:LSTPopStyleScale dismissStyle:LSTDismissStyleFade];
    cusView.hemStyle = LSTHemStyleCenter;
    LSTPopViewWK(cusView);
    cusView.bgClickBlock = ^{
        [wk_cusView dismiss];
    };
    self.cusView = cusView;
    [cusView pop];
}
-(void)resetTagView
{
    UILabel *hint = [self.tagView viewWithTag:50001];
    UIButton *btn = [self.tagView viewWithTag:9001];
    if(self.tags.count == 0)
    {
        hint.hidden = NO;
        self.tag.hidden = NO;
        return;
    }
    else
    {
        hint.hidden = YES;
        self.tag.hidden = YES;
    }
    if(self.tags.count == 3)
    {
        btn.hidden = YES;
    }
    else
    {
        btn.hidden = NO;
    }
    for(int i = 0 ;i < self.tags.count;i++)
    {
        UIView * tag1 = [self.tagView viewWithTag:6000+i];
        tag *t = self.tags[i];
        if(!tag1)
        {
            tag1 = [self createTagView:t.tagContent :t.color];
            
            tag1.tag =  6000+i;
            if(i != 0)
            {
                UIView *preView = [self.tagView viewWithTag:tag1.tag-1];
                tag1.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, 0, tag1.frame.size.width, tag1.frame.size.height);
            }
            if(CGRectGetMaxX(tag1.frame) > self.tagView.contentSize.width)
            {
                self.tagView.contentSize = CGSizeMake(CGRectGetMaxX(tag1.frame)+10, self.tagView.contentSize.height);
                self.tagView.showsHorizontalScrollIndicator = NO;
            }
            [self.tagView addSubview:tag1];
        }
        else
        {
            continue;
        }
    }
    
    
    
    
    
    
    
}

-(UIView *)createTagView:(NSString *)str :(UIColor *)Color
{
    UILabel *taglab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    taglab1.text = str;
    taglab1.numberOfLines = 1;
    taglab1.textAlignment = NSTextAlignmentCenter;
    taglab1.font = [UIFont systemFontOfSize:12 weight:0.3];
    CGSize expectSize = [taglab1 sizeThatFits:CGSizeMake(100, 100)];
    taglab1.frame = CGRectMake(10, 0, expectSize.width, 30);
    taglab1.textAlignment = NSTextAlignmentCenter;
    UIButton *delete = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(taglab1.frame)+5, 5, 20, 20)];
    [delete setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [delete addTarget: self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    delete.tag = 4001;
    if(!self.status)
    delete.hidden = YES;
    NSInteger  c = self.status?20:0;
    UIView *tag1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, expectSize.width+20+c, 30)];
    [tag1 addSubview:delete];
    tag1.layer.cornerRadius = 5;
    tag1.backgroundColor = Color;
    tag1.layer.masksToBounds = YES;
    [tag1 setBackgroundColor:Color];
    [tag1 addSubview:taglab1];
    return tag1;
}
-(void)deleteTag:(UIButton *)sender
{
    UILabel *hint = [self.tagView viewWithTag:50001];
    UIButton *btn = [self.tagView viewWithTag:9001];
    UIView *view = sender.superview;
    NSInteger tag = view.tag;
    
    UIView *tag1 = [self.tagView viewWithTag:6000];
    UIView *tag2 = [self.tagView viewWithTag:6001];
    UIView *tag3 = [self.tagView viewWithTag:6002];
    [self.tags removeObjectAtIndex:tag - 6000];
    if(tag == 6000)//移除第一个
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            [view removeFromSuperview];
            if(tag2)
            {
                tag2.frame = CGRectMake(0, 0,tag2.frame.size.width , tag2.frame.size.height);
            }
            if(tag3)
            {
                tag3.frame = CGRectMake(CGRectGetMaxX(tag2.frame)+10, 0, tag3.frame.size.width, tag3.frame.size.height);
            }
        }];
        tag2.tag = 6000;
        tag3.tag = 6001;
        
    }
    else if(tag == 6001)//移除第二个
    {
        [UIView animateWithDuration:0.5 animations:^{
            [view removeFromSuperview];
            
            if(tag3)
            {
                tag3.frame = CGRectMake(CGRectGetMaxX(tag1.frame)+10, 0, tag3.frame.size.width, tag3.frame.size.height);
                tag3.tag = 6001;
            }
        }];
    }
    else
    {
        [view removeFromSuperview];
    }
    
    if(self.tags.count == 0)
    {
        hint.hidden = NO;
        self.tag.hidden = NO;
    }
    if(self.tags.count < 3)
    {
        btn.hidden  = NO;
    }
    
}
-(void)selectColor:(UIButton *)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    sender.enabled = NO;
    UILabel *name = [self.popView viewWithTag:20001];
    UIButton *btn1 = [self.popView viewWithTag:40001];
    UIButton *btn2 = [self.popView viewWithTag:40002];
    DCColorPicker *picker = [self.popView viewWithTag:5001];
    if(!picker)
    {
    picker = [[DCColorPicker alloc]initWithFrame:CGRectMake((self.popView.frame.size.width-0.3*screenheight)/2, CGRectGetMaxY(name.frame)+62, 0.3*screenheight, 0.3*ScreenHeight)  bgImage:[UIImage imageNamed:@"Popup_color_bg"]];
        [self.popView addSubview:picker];
    }
    picker.hidden = NO;
    picker.tag = 5001;
    UIButton *certain = [[UIButton alloc]initWithFrame:CGRectMake(0.25*self.popView.frame.size.width, CGRectGetMaxY(picker.frame)+10, 0.5*self.popView.frame.size.width, 30)];
    [certain setTitle:@"确定" forState:UIControlStateNormal];
    [certain setBackgroundColor:mainColor];
    certain.layer.cornerRadius = 5;
    [certain addTarget:self action:@selector(certainClick:) forControlEvents:UIControlEventTouchUpInside];
    certain.layer.masksToBounds = YES;
    [self.popView addSubview:certain];
    
    btn1.hidden = YES;
    btn2.hidden = YES;
    float height = 0;
    if(CGRectGetMaxY(certain.frame) > self.popView.frame.size
       .height)
    {
        height =CGRectGetMaxY(certain.frame) ;
    }
    height = MAX(height, self.popView.frame.size.height + 0.3*screenheight);
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.frame = CGRectMake(0, 0, self.popView.frame.size.width,height);
    }];
    
    picker.currentColorBlock = ^(UIColor * _Nonnull color, int x, int y) {
        [sender setBackgroundColor:color];
        sender.layer.borderColor = color.CGColor;
        [sender setTitle:@"" forState:UIControlStateNormal];
        sender.layer.borderWidth = 0;
    };
}
-(void)compeleteClick:(UIButton *)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UITextField * name = [self.popView viewWithTag:10005];
    UIButton * btn = [self.popView viewWithTag:3001];
    if(name.text.length == 0)
    {
        [CreateBase showMessage:@"请输入Tag名称"];
        return;
    }
    else if(name.text.length > 5)
    {
        [CreateBase showMessage:@"Tag最多只能有5个字符哦～～"];
        return;
    }
    else
    {
        for (tag *t in self.tags)
        {
            if([t.tagContent isEqual:name.text])
            {
                [CreateBase showMessage:@"Tag已存在"];
                return;
            }
        }
        
        
        
        tag *t = [tag new];
        
        t.color = [UIColor colorWithCGColor:btn.layer.borderColor];
        
        t.tagColor = [NSString stringWithFormat:@"#%@",[CreateBase hexFromUIColor:t.color]];
        NSLog(@"%@",t.tagColor);
        t.tagContent = name.text;
        [self.tags addObject:t];
    }
    [self.cusView dismiss];
    [self resetTagView];
}
-(void)certainClick:(UIButton *)sender
{
    UIButton *btn = [self.popView viewWithTag:3001];
    btn.enabled = YES;
    sender.hidden = YES;
    DCColorPicker *pick = [self.popView viewWithTag:5001];
    pick.hidden = YES;
    UIButton *btn1 = [self.popView viewWithTag:40001];
    UIButton *btn2 = [self.popView viewWithTag:40002];
    btn1.hidden = NO;
    btn2.hidden = NO;
    
    float height = 0.2*screenheight;
    if(CGRectGetMaxY(btn2.frame) > height)
    {
        height = CGRectGetMaxY(btn2.frame)+5;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.frame = CGRectMake(0,0, 0.8*screenwith, height);
    }];
    
    
    
    
}
-(void)cancelClcik
{
    [self.cusView dismiss];
}
-(void)partispantClick
{
    selectPersonViewController *s = [selectPersonViewController new];
    if(self.selectParts)
    {
        s.selected = self.selectParts;
    }
    s.parts = [NSMutableArray new];
    [LCProgressHUD showLoading:nil];
    [CreateBase updateProjectAtIndex:self.projectID finish:^{
        self.pj = [CreateBase searchProject:self.projectID];
        s.parts = self.pj.members;
        [LCProgressHUD hide];
        [[ViewManager shareInstance].NavigationController pushViewController:s animated:YES];
    }];
    
   // s.parts = self.partispants;
   
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
        if(sender.tag == 30001)
        {
            picker.minimumDate = MAX([formatter dateFromString:self.pj.projectStartTime], [NSDate date]);
            picker.maximumDate =[formatter dateFromString:self.pj.projectEndTime];
            picker.tag = 30001;
        }
        else if(self.startTime.text.length == 0)
        {
            [CreateBase showMessage:@"请先选择开始日期"];
            return;
        }
        else
        {
            picker.minimumDate = [NSDate dateWithTimeInterval:86400 sinceDate: MAX([formatter dateFromString:self.pj.projectStartTime], self.Timestart)];
            picker.maximumDate =[formatter dateFromString:self.pj.projectEndTime];
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
        //[btn addTarget:self action:@selector(addTask) forControlEvents:UIControlEventTouchUpInside];
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
        login.text = @"任务详情";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentCenter;
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _topBar.frame.size.height-30, 20, 20)];
        backBtn.tag = 90001;
        [backBtn addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        backBtn.adjustsImageWhenHighlighted = NO;
        [_topBar addSubview:backBtn];
        
        //UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        //line.backgroundColor = [CreateBase createColor:228];
        //[_topBar addSubview:line];
        [_topBar addSubview:login];
        self.complete = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-65, login.frame.origin.y+5, 55, 15)];
        [self.complete setTitle:@"修 改" forState:UIControlStateNormal];
        [self.complete addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
        [self.complete setTitleColor:mainColor forState:UIControlStateNormal];
        [self.complete.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.4]];
        [_topBar addSubview:self.complete];
        UIButton *cancel = [[UIButton alloc]initWithFrame:backBtn.frame];
        cancel.frame = CGRectMake(cancel.frame.origin.x, login.frame.origin.y+5, 55, 15);
        [cancel setTitle:@"取 消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel)
         forControlEvents:UIControlEventTouchUpInside];
        cancel.alpha = 0;
        cancel.tag = 90002;
        cancel.hidden = YES;
        [cancel setTitleColor:mainColor forState:UIControlStateNormal];
        [cancel.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.4]];
        [_topBar addSubview:cancel];
        UIButton *allcom = [[UIButton alloc]initWithFrame:self.complete.frame];
        allcom.tag = 90003;
        [allcom setTitle:@"完 成" forState:UIControlStateNormal];
        [allcom addTarget:self action:@selector(allcomClick) forControlEvents:UIControlEventTouchUpInside];
        [allcom setTitleColor:mainColor forState:UIControlStateNormal];
        [allcom.titleLabel setFont:[UIFont systemFontOfSize:18 weight:0.4]];
        [_topBar addSubview:allcom];
        allcom.hidden = YES;
        allcom.alpha = 0;
        
    }
    return _topBar;
}
-(void)wancheng //修改按钮
{
    self.status = 1;
    self.priority.hidden = NO;
    self.partispant.hidden = NO;
    self.start.hidden = NO;
    self.end.hidden = NO;
    self.name.enabled = YES;
    if(self.tags.count  < 3)
    {
    UIButton *add = [self.tagView viewWithTag:9001];
        add.hidden = NO;
        if(self.tags.count == 0)
        {
        UILabel *taglab = [self.tagView viewWithTag: 50001];
        taglab.hidden = NO;
        }
    }
    //self.name.enabled = NO;
    [self.name becomeFirstResponder];
    UIButton *back = [self.topBar viewWithTag:90001];
    UIButton *cancel = [self.topBar viewWithTag:90002];
    UIButton *allcom = [self.topBar viewWithTag:90003];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        cancel.hidden = NO;
        allcom.hidden = NO;
        self.complete.alpha = 0;
        back.alpha = 0;
    
        } completion:^(BOOL finished) {
            cancel.alpha = 1;
            allcom.alpha = 1;
            self.complete.hidden = YES;
            back.hidden = YES;
            
        }];
    
    for(int i = 0 ;i < self.tags.count;i++)
    {
        UIView * tag1 = [self.tagView viewWithTag:6000+i];
        tag *t = self.tags[i];
        if(!tag1)
        {
            tag1 = [self createTagView:t.tagContent :t.color];
            
            tag1.tag =  6000+i;
            if(i != 0)
            {
                
                
                    UIView *preView = [self.tagView viewWithTag:tag1.tag-1];
                    tag1.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, 0, tag1.frame.size.width, tag1.frame.size.height);
               
            
            }
            if(CGRectGetMaxX(tag1.frame) > self.tagView.contentSize.width)
            {
                self.tagView.contentSize = CGSizeMake(CGRectGetMaxX(tag1.frame)+10, self.tagView.contentSize.height);
                self.tagView.showsHorizontalScrollIndicator = NO;
            }
            [self.tagView addSubview:tag1];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                UIButton *btn = [tag1 viewWithTag:4001];
                btn.hidden = NO;
                            if(i == 0)
                            {
                                tag1.frame = CGRectMake(tag1.frame.origin.x, tag1.frame.origin.y, tag1.frame.size.width+20, tag1.frame.size.height);
                                
                            }
                else
                {
                    UIView *preView = [self.tagView viewWithTag:tag1.tag-1];
                    tag1.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, 0, tag1.frame.size.width+20, tag1.frame.size.height);
                    
                }
                        } completion:^(BOOL finished) {
                            
                        }];
        }
    }
    
}
    
    
-(void)backToPreView
{
    [[ViewManager shareInstance].NavigationController popViewControllerAnimated:YES];
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
-(void)allcomClick
{
    if(self.name.text.length == 0)
    {
        [CreateBase showMessage:@"请输入任务名称"];
        return;
    }
    else if(!self.Timestart)
    {
        [CreateBase showMessage:@"请选择起始时间"];
        return;
    }
    else if(!self.TimeEnd)
    {
        [CreateBase showMessage:@"请选择结束时间"];
        return;
    }
    else if([self.Timestart timeIntervalSince1970] > [self.TimeEnd timeIntervalSince1970])
    {
        [CreateBase showMessage:@"任务起止时间不正确!"];
        return;
    }
    else if(self.selectParts.count == 0)
    {
        [CreateBase showMessage:@"未选择参与人员"];
        return;
    }
    else if(self.priorityNum == -1)
    {
        [CreateBase showMessage:@"请选择任务优先度"];
        return;
    }
    else
    {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:[AppData shareInstance].user_info.userId forKey:@"taskVersionModifyUserId"];
        [dic setObject:self.task.taskId forKey:@"taskId"];
        [dic setObject:self.projectID forKey:@"projectId"];
        [dic setObject:self.name.text forKey:@"taskTitle"];
        [dic setObject:[NSString stringWithFormat:@"%ld",self.priorityNum] forKey:@"taskPriority"];
        [dic setObject:self.startTime.text forKey:@"taskStartTime"];
        [dic setObject:self.endTime.text forKey:@"taskEndTime"];
        NSMutableArray *addTags = [NSMutableArray new];
        NSMutableArray *delTags = [NSMutableArray new];
        NSMutableArray *addParticipants = [NSMutableArray new];
        NSMutableArray *delParticipants = [NSMutableArray new];
        
        for (NSDictionary *dic in self.task.tags)
        {
            tag *t = [[tag alloc]initWithDictionary:dic error:nil];
            int flag = 0;
            for ( tag * t2 in self.tags)
            {
                if([t.tagContent isEqual:t2.tagContent] && [t.tagColor isEqual:t2.tagColor])
                {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0)
            {
                [delTags addObject:@{@"tagContent":t.tagContent,@"tagColor":t.tagColor}];
            }
        }
        
        
        for (tag *t2 in self.tags)
        {
            int flag = 0;
            for (NSDictionary *dic in self.task.tags)
            {
                
                tag *t = [[tag alloc]initWithDictionary:dic error:nil];
                if([t.tagContent isEqual:t2.tagContent] && [t.tagColor isEqual:t2.tagColor])
                {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0)
            {
                [addTags addObject:@{@"tagContent":t2.tagContent,@"tagColor":t2.tagColor}];
            }
        }
        
        for (participant *p in self.selectParts)
        {
            int flag = 0;
            for (NSDictionary * dic in self.task.participants)
            {
                participant *p1 = [[participant alloc]initWithDictionary:dic error:nil];
                if([p.userId isEqual:p1.userId])
                {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0)
            {
                [addParticipants addObject:@{@"userId":p.userId}];
            }
        }
        
        for (NSDictionary * dic in self.task.participants)
        {
            int flag = 0;
            
            participant *p = [[participant alloc]initWithDictionary:dic error:nil];
            for ( participant *p1 in self.partispants)
            {
             
                if([p.userId isEqual:p1.userId])
                {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0)
            {
                [delParticipants addObject:@{@"userId":p.userId}];
            }
        }
        if(addTags.count != 0)
        {
            [dic setObject:addTags forKey:@"addTags"];
        }
        if(delTags.count != 0)
        {
            [dic setObject:delTags forKey:@"delTags"];
        }
        if(addParticipants.count != 0)
        {
            [dic setObject:addParticipants forKey:@"addParticipants"];
        }
        if(delParticipants.count != 0)
        {
            [dic setObject:delParticipants forKey:@"delParticipants"];
        }
        [dic setObject:self.task.taskType forKey:@"taskType"];
        [dic setObject:[NSNumber numberWithInt:[self.task.taskVersion intValue]] forKey:@"taskVersion"];
        
        [dic setObject:@"1" forKey:@"taskVersionDescription"];
        NSMutableArray *parts = [NSMutableArray new];
        for (participant *p in self.selectParts)
        {
            NSMutableDictionary *dic = @{@"userId":p.userId};
            [parts addObject:dic];
        }
        [dic setObject:parts forKey:@"participants"];
        NSMutableArray *tags = [NSMutableArray new];
        for (tag *t in self.tags) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:t.tagContent forKey:@"tagContent"];
            [dic setObject:t.tagColor forKey:@"tagColor"];
            [tags addObject:dic];
        }
        [dic setObject:tags forKey:@"tags"];
        
        NSLog(@"%@",dic);
        [LCProgressHUD showLoading:nil];
        [[ApiManager shareInstance]POST:@"/task" parameters:dic needsToken:YES Success:^(id responseObject) {
                    
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
                
                [CreateBase showMessage:@"修改成功！"];
                [[ViewManager shareInstance].NavigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                
                [CreateBase showMessage:@"修改失败"];
            }
            [LCProgressHUD hide];
                } Failure:^(id error) {
                    [LCProgressHUD hide];
                    [CreateBase showInternetFail];
                }];
        
    }
            
    
}
-(void)confirmClick
{
    [self.identityPick hidden];
    if([self.identityPick.currentSelect isEqual:@"普通"])
    {
    self.prioritylab.textColor = mainColor;
        self.priorityNum = 0;
    }
    else if([self.identityPick.currentSelect isEqual:@"有点紧急"])
    {
        self.prioritylab.textColor = [CreateBase createColor:246 blue:180 green:57];
        self.priorityNum = 1;
    }
    else
    {
        self.prioritylab.textColor = [UIColor redColor];
        self.priorityNum = 2;
    }
    self.prioritylab.text = self.identityPick.currentSelect;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.pj = [CreateBase searchProject:self.projectID];
    self.tags = [NSMutableArray new];
    for (NSDictionary *dic in self.task.tags) {
        tag *t = [[tag alloc]initWithDictionary:dic error:nil];
        t.color = [CreateBase colorWithHexString:t.tagColor];
        [self.tags addObject:t];
    }
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
    -(void)upToFive:(UITextField *)sender
    {
//        if(sender.text.length > 5)
//        {
//            sender.text = [sender.text substringToIndex:5];
//        }
    }
-(void)initData
{
    self.tags = [NSMutableArray new];
    for (NSDictionary *dic in self.task.tags) {
        tag *t = [[tag alloc]initWithDictionary:dic error:nil];
        t.color = [CreateBase colorWithHexString:t.tagColor];
        [self.tags addObject:t];
    }
    self.name.text = self.task.taskTitle;
    self.startTime.text = self.task.taskStartTime;
    self.startTime.textColor = [UIColor blackColor];
    self.endTime.textColor = [UIColor blackColor];
    self.endTime.text = self.task.taskEndTime;
    if(self.task.taskPriority == [NSNumber numberWithInt:0])
    {
        self.prioritylab.text = @"普通";
        self.prioritylab.textColor = mainColor;
    }
    else if(self.task.taskPriority == [NSNumber numberWithInt:1])
    {
        self.prioritylab.text = @"有点紧急";
        self.prioritylab.textColor = [CreateBase createColor:246 blue:180 green:57];
    }
    else
    {
        self.prioritylab.text = @"紧急";
        self.prioritylab.textColor = [UIColor redColor];
    }
    self.partispantlab.text = @"";
    self.partispantlab.textColor = [UIColor blackColor];
    for (NSDictionary *dic in self.task.participants)
    {
        participant *p = [[participant alloc]initWithDictionary:dic error:nil];
        self.partispantlab.text = [NSString stringWithFormat:@"%@ %@",self.partispantlab.text,p.userName];
    }
    
    self.priority.hidden = YES;
    self.partispant.hidden = YES;
    self.start.hidden = YES;
    self.end.hidden = YES;
    UIButton *add = [self.tagView viewWithTag:9001];
        add.hidden = YES;
    UILabel *taglab = [self.tagView viewWithTag: 50001];
    taglab.hidden = YES;
    self.name.enabled = NO;
    [self resetTagView];
}
-(void)cancel
{
    self.status = 0;
    for(int i = 0;i < 3;i++)
    {
        UIView *tag = [self.tagView viewWithTag:6000+i];
        [tag removeFromSuperview];
    }
    [self initData];
    UIButton *back = [self.topBar viewWithTag:90001];
    UIButton *cancel = [self.topBar viewWithTag:90002];
    UIButton *allcom = [self.topBar viewWithTag:90003];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        cancel.alpha = 0;
        allcom.alpha = 0;
        self.complete.hidden = NO;
        back.hidden = NO;
        } completion:^(BOOL finished) {
            
            cancel.hidden = YES;
            allcom.hidden = YES;
            self.complete.alpha = 1;
            back.alpha = 1;
        }];
    
//    for(int i = 0 ;i < self.tags.count;i++)
//    {
//        UIView * tag1 = [self.tagView viewWithTag:6000+i];
//        tag *t = self.tags[i];
//        if(!tag1)
//        {
//            tag1 = [self createTagView:t.tagContent :t.color];
//
//            tag1.tag =  6000+i;
//            if(i != 0)
//            {
//
//
//                    UIView *preView = [self.tagView viewWithTag:tag1.tag-1];
//                    tag1.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, 0, tag1.frame.size.width, tag1.frame.size.height);
//
//
//            }
//            if(CGRectGetMaxX(tag1.frame) > self.tagView.contentSize.width)
//            {
//                self.tagView.contentSize = CGSizeMake(CGRectGetMaxX(tag1.frame)+10, self.tagView.contentSize.height);
//                self.tagView.showsHorizontalScrollIndicator = NO;
//            }
//            [self.tagView addSubview:tag1];
//        }
//        else
//        {
//            [UIView animateWithDuration:0.3 animations:^{
//                UIButton *btn = [tag1 viewWithTag:4001];
//
//                            if(i == 0 && btn.hidden == NO)
//                            {
//                                btn.hidden = YES;
//                                tag1.frame = CGRectMake(tag1.frame.origin.x, tag1.frame.origin.y, tag1.frame.size.width-20, tag1.frame.size.height);
//
//                            }
//                else
//                {
//                    if(btn.hidden == NO)
//                    {
//                        btn.hidden = YES;
//                    UIView *preView = [self.tagView viewWithTag:tag1.tag-1];
//                    tag1.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, 0, tag1.frame.size.width-20, tag1.frame.size.height);
//                    }
//
//                }
//                        } completion:^(BOOL finished) {
//
//                        }];
//        }
//    }
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
