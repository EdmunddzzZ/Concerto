//
//  ChildViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "ChildProject2ViewController.h"
#import "CreateBase.h"
#import "MJRefresh.h"
@interface ChildProject2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *isEmpty;
@property(nonatomic,strong)NSMutableArray *weiwancheng;
@property(nonatomic,strong)NSMutableArray *yiwancheng;
@property(nonatomic,strong)NSMutableArray *btns;
@end

@implementation ChildProject2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btns = [NSMutableArray new];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.isEmpty];
    
    [self.view setBackgroundColor:mainBackGroundColor];
    
    if(self.planArrays.count == 0)
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, screenwith,    MAX(130*_planArrays.count, screenheight-90-Safearea)) style:UITableViewStylePlain];
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    return self.weiwancheng.count;
    else
        return self.yiwancheng.count;
        return 0;
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
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cellid2"];
    if(indexPath.section == 0)
    {
    if(!cell)
    {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid1"];
        cell.contentView.hidden = YES;
        cell.backgroundColor = mainBackGroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(25, 15, screenwith-50, 180-15)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 8;
        contentView.layer.masksToBounds = YES;
        [cell addSubview:contentView];
        UIView *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 5, contentView.frame.size.height)];
        leftLine.backgroundColor = mainColor;
        leftLine.tag = 1001;
        [contentView addSubview:leftLine];
        UIButton *complete = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 25, 20)];
        complete.tag = 1002;
        [self.btns addObject:complete];
        [complete addTarget:self action:@selector(completeClick:) forControlEvents:UIControlEventTouchUpInside];
        [complete.layer setBorderWidth:2];
        [complete.layer setBorderColor:mainColor.CGColor];
        complete.layer.cornerRadius = 10;
        complete.layer.masksToBounds = YES;
        [contentView addSubview:complete];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(complete.frame)+10, 10, screenwith-50-55-20, 20)];
        title.tag = 1003;
        title.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题";
       // title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:18 weight:0.2];
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
        sonCompleteLab.tag = 1007;
        [sonComplete addSubview:sonCompleteLab];
        
        UILabel *taglab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab1.text = @"tag1";
        taglab1.numberOfLines = 1;
        taglab1.tag = 2001;
        taglab1.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize = [taglab1 sizeThatFits:CGSizeMake(100, 100)];
        taglab1.frame = CGRectMake(10, 0, expectSize.width, 20);
        taglab1.textAlignment = NSTextAlignmentCenter;
        UIView *tag1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sonComplete.frame)+15, sonComplete.frame.origin.y, expectSize.width+20, 20)];
        tag1.tag = 3001;
        tag1.layer.cornerRadius = expectSize.width/3;
        tag1.layer.masksToBounds = YES;
        [tag1 setBackgroundColor:mainColor];
        [tag1 addSubview:taglab1];
        [contentView addSubview:tag1];
        
        UILabel *taglab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab2.text = @"tag2";
        taglab2.numberOfLines = 1;
        taglab2.tag = 2002;
        taglab2.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize2 = [taglab2 sizeThatFits:CGSizeMake(100, 100)];
        taglab2.frame = CGRectMake(10, 0, expectSize2.width, 20);
        taglab2.textAlignment = NSTextAlignmentCenter;
        UIView *tag2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag1.frame)+15, sonComplete.frame.origin.y, expectSize2.width+20, 20)];
        tag2.tag = 3002;
        tag2.layer.cornerRadius = expectSize2.width/3;
        tag2.layer.masksToBounds = YES;
        [tag2 setBackgroundColor:mainColor];
        [tag2 addSubview:taglab2];
        [contentView addSubview:tag2];
        
        UILabel *taglab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        taglab3.text = @"tag13333333";
        taglab3.numberOfLines = 1;
        taglab3.tag = 2003;
        taglab3.font = [UIFont systemFontOfSize:14 weight:0.3];
        CGSize expectSize3= [taglab3 sizeThatFits:CGSizeMake(100, 100)];
        taglab3.frame = CGRectMake(10, 0, expectSize3.width, 20);
        taglab3.textAlignment = NSTextAlignmentCenter;
        UIView *tag3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag2.frame)+15, sonComplete.frame.origin.y, expectSize3.width+20, 20)];
        tag3.tag = 3003;
        tag3.layer.cornerRadius = expectSize.width/3;
        tag3.layer.masksToBounds = YES;
        [tag3 setBackgroundColor:mainColor];
        [tag3 addSubview:taglab3];
        [contentView addSubview:tag3];
        
        UIView *dayline = [[UIView alloc]initWithFrame:CGRectMake(sonComplete.frame.origin.x+20, CGRectGetMaxY(sonComplete.frame)+35, 2, 20)];
        dayline.tag = 1004;
        [dayline setBackgroundColor:mainColor];
        [contentView addSubview:dayline];
        
        UILabel *leftDay = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayline.frame)+10, dayline.frame.origin.y+2, 70, 15)];
        leftDay.tag = 1005;
        leftDay.font = [UIFont systemFontOfSize:11 weight:0.3];
        leftDay.text = @"3天";
        //leftDay.font = [UIFont systemFontOfSize:14 weight:0.2];
        [contentView addSubview:leftDay];
        UIView *dayline2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftDay.frame)+10, CGRectGetMaxY(sonComplete.frame)+35, 2, 20)];
        dayline2.backgroundColor = [CreateBase createColor:98 blue:169 green:221];
        [contentView addSubview:dayline2];
        UILabel *leftday2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayline2.frame)+10, dayline.frame.origin.y+2, 70, 15)];
        leftday2.tag = 1009;
        leftday2.font = leftDay.font;
        //leftday2.font = [UIFont systemFontOfSize:14 weight:0.2];
        [contentView addSubview:leftday2];
        UILabel *people = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftDay.frame)+20, CGRectGetMaxY(sonComplete.frame)+15, screenwith-CGRectGetMaxX(leftDay.frame)-100, 15)];
        people.text = @"saries saries2 saries3";
        people.textAlignment = NSTextAlignmentRight;
        people.font = [UIFont systemFontOfSize:14 weight:0.2];
        people.textColor = [CreateBase createColor:127];
        people.tag  = 1006;
        [contentView addSubview:people];
        UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(dayline.frame.origin.x, CGRectGetMaxY(dayline.frame)+10, contentView.frame.size.width-dayline.frame.origin.x-20, 20)];
        progressView.tag = 5000;
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, progressView.frame.size.height, progressView.frame.size.width, 1)];
        line.backgroundColor = [CreateBase createColor:218 blue:152 green:51];
        [progressView addSubview:line];
        
        UIView *taskAtPj = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        taskAtPj.tag = 5001;
        UIView *subtask = [[UIView alloc]initWithFrame:CGRectMake(0,0 , 0, 0)];
        subtask.tag = 5002;
        [contentView addSubview:progressView];
        [progressView addSubview:taskAtPj];
        [progressView addSubview:subtask];
        
        
        
        
        //UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, screenwith, 1)];
        //[line setBackgroundColor:[UIColor grayColor]];
        
        //[cell addSubview:line];
    }
        Task *task = self.weiwancheng[indexPath.row];
        UIView *leftline = [cell viewWithTag:1001];
        UILabel *sonc = [cell viewWithTag:1007];
        UIButton *compelete = [cell viewWithTag:1002];
        UILabel *title = [cell viewWithTag:1003];
        UIView *tag1 = [cell viewWithTag:3001];
        UIView *tag2 = [cell viewWithTag:3002];
        UIView *tag3 = [cell viewWithTag:3003];
        UILabel *taglab1 = [tag1 viewWithTag:2001];
        UILabel *taglab2 = [tag2 viewWithTag:2002];
        UILabel *taglab3 = [tag3 viewWithTag:2003];
        UIView *dayline = [cell viewWithTag:1004];
        UILabel *leftday = [cell viewWithTag:1005];
        UILabel *people = [cell viewWithTag:1006];
        UILabel *leftday2 = [cell viewWithTag:1009];
        UIColor *statusColor = mainColor;
        tag1.hidden = YES;
        tag2.hidden = YES;
        tag3.hidden = YES;
        sonc.text = [NSString stringWithFormat:@"%@/%@",task.subTaskCompletedNum,task.subTaskNum];
        if([task.taskPriority isEqual:[NSNumber numberWithInt:0]])
        {
            statusColor = mainColor;
        }
        else if([task.taskPriority isEqual:[NSNumber numberWithInt:1]])
        {
            statusColor = [CreateBase createColor:255 blue:204 green:147];
        }
        else
        {
            statusColor = [CreateBase createColor:245 blue:128 green:140];
        }
        title.text = task.taskTitle;
        leftline.backgroundColor = statusColor;
        compelete.layer.borderColor = statusColor.CGColor;
        dayline.backgroundColor = statusColor;
        
        for (int i =0 ;i < task.tags.count;i++)
        
        {
            NSDictionary *dic = task.tags[i];
            tag *t = [[tag alloc]initWithDictionary:dic error:nil];
            UIView *view = [cell viewWithTag:3001+i];
            UILabel *lab  = [view viewWithTag:2001+i];
            lab.text = t.tagContent;
            view. backgroundColor = [CreateBase colorWithHexString:t.tagColor];
            CGSize expectSize3= [lab sizeThatFits:CGSizeMake(100, 100)];
            lab.frame = CGRectMake(10, 0, expectSize3.width, 20);
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, expectSize3.width+20, 20);
            if(i != 0)
            {
                UIView *preView = [cell viewWithTag:view.tag -1];
                view.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, view.frame.origin.y, expectSize3.width+20, 20);
            }
            view.hidden = NO;
            
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *projectStart = [formatter dateFromString:self.pj.projectStartTime];
        NSDate *projectEnd = [formatter dateFromString:self.pj.projectEndTime];
        NSDate *taskStart = [formatter dateFromString:task.taskStartTime];
        NSDate *taskend = [formatter dateFromString:task.taskEndTime];
        UIView *conten = [cell viewWithTag:5000];
        UIView *taskAtPj = [conten viewWithTag:5001];
        UIView *subtask = [conten viewWithTag:5002];
        taskAtPj.backgroundColor = statusColor;
        
        subtask.backgroundColor = [CreateBase createColor:0 blue:169 green:238];
        NSInteger intervalall = [projectEnd timeIntervalSinceDate:projectStart];
        NSInteger intervalstart = [taskStart timeIntervalSinceDate:projectStart];
        NSInteger intervaltask = [taskend timeIntervalSinceDate:taskStart];
        taskAtPj.frame = CGRectMake(conten.frame.size.width * ((1.0*intervalstart)/intervalall), 0, conten.frame.size.width * ((1.0*intervaltask)/intervalall), 20);
        
        
        leftday.text = task.taskStartTime;
        leftday2.text = task.taskEndTime;
        people.text = @"";
        for (NSDictionary *dic in task.participants)
        {
            participant *p = [[participant alloc]initWithDictionary:dic error:nil];
            people.text  = [NSString stringWithFormat:@"%@ %@",people.text,p.userName];
        }
    return cell;
    }
    else
    {
        if(!cell2)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid2"];
            cell2.contentView.hidden = YES;
            cell2.backgroundColor = mainBackGroundColor;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(25, 15, screenwith-50, 130-15)];
            contentView.backgroundColor = [UIColor whiteColor];
            contentView.layer.cornerRadius = 8;
            contentView.layer.masksToBounds = YES;
            [cell2 addSubview:contentView];
            UIView *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 5, contentView.frame.size.height)];
            leftLine.backgroundColor = mainColor;
            leftLine.tag = 1001;
            [contentView addSubview:leftLine];
            UIButton *complete = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 25, 20)];
            complete.tag = 1002;
            [self.btns addObject:complete];
           // [complete addTarget:self action:@selector(completeClick:) forControlEvents:UIControlEventTouchUpInside];
            [complete.layer setBorderWidth:2];
            [complete.layer setBorderColor:mainColor.CGColor];
            complete.layer.cornerRadius = 10;
            complete.layer.masksToBounds = YES;
            [contentView addSubview:complete];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(complete.frame)+10, 10, screenwith-50-55-20, 20)];
            title.tag = 1003;
            title.text = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题";
           // title.textAlignment = NSTextAlignmentCenter;
            title.font = [UIFont systemFontOfSize:18 weight:0.2];
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
            sonCompleteLab.tag = 1007;
            [sonComplete addSubview:sonCompleteLab];
            
            UILabel *taglab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
            taglab1.text = @"tag1";
            taglab1.numberOfLines = 1;
            taglab1.tag = 2001;
            taglab1.font = [UIFont systemFontOfSize:14 weight:0.3];
            CGSize expectSize = [taglab1 sizeThatFits:CGSizeMake(100, 100)];
            taglab1.frame = CGRectMake(10, 0, expectSize.width, 20);
            taglab1.textAlignment = NSTextAlignmentCenter;
            UIView *tag1 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sonComplete.frame)+15, sonComplete.frame.origin.y, expectSize.width+20, 20)];
            tag1.tag = 3001;
            tag1.layer.cornerRadius = expectSize.width/3;
            tag1.layer.masksToBounds = YES;
            [tag1 setBackgroundColor:mainColor];
            [tag1 addSubview:taglab1];
            [contentView addSubview:tag1];
            
            UILabel *taglab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
            taglab2.text = @"tag2";
            taglab2.numberOfLines = 1;
            taglab2.tag = 2002;
            taglab2.font = [UIFont systemFontOfSize:14 weight:0.3];
            CGSize expectSize2 = [taglab2 sizeThatFits:CGSizeMake(100, 100)];
            taglab2.frame = CGRectMake(10, 0, expectSize2.width, 20);
            taglab2.textAlignment = NSTextAlignmentCenter;
            UIView *tag2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag1.frame)+15, sonComplete.frame.origin.y, expectSize2.width+20, 20)];
            tag2.tag = 3002;
            tag2.layer.cornerRadius = expectSize2.width/3;
            tag2.layer.masksToBounds = YES;
            [tag2 setBackgroundColor:mainColor];
            [tag2 addSubview:taglab2];
            [contentView addSubview:tag2];
            
            UILabel *taglab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
            taglab3.text = @"tag13333333";
            taglab3.numberOfLines = 1;
            taglab3.tag = 2003;
            taglab3.font = [UIFont systemFontOfSize:14 weight:0.3];
            CGSize expectSize3= [taglab3 sizeThatFits:CGSizeMake(100, 100)];
            taglab3.frame = CGRectMake(10, 0, expectSize3.width, 20);
            taglab3.textAlignment = NSTextAlignmentCenter;
            UIView *tag3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tag2.frame)+15, sonComplete.frame.origin.y, expectSize3.width+20, 20)];
            tag3.tag = 3003;
            tag3.layer.cornerRadius = expectSize.width/3;
            tag3.layer.masksToBounds = YES;
            [tag3 setBackgroundColor:mainColor];
            [tag3 addSubview:taglab3];
            [contentView addSubview:tag3];
            
            UIView *dayline = [[UIView alloc]initWithFrame:CGRectMake(sonComplete.frame.origin.x+20, CGRectGetMaxY(sonComplete.frame)+15, 2, 20)];
            dayline.tag = 1004;
            [dayline setBackgroundColor:mainColor];
            [contentView addSubview:dayline];
            
            UILabel *leftDay = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayline.frame)+10, dayline.frame.origin.y+2, 30, 15)];
            leftDay.tag = 1005;
            leftDay.text = @"3天";
            leftDay.font = [UIFont systemFontOfSize:14 weight:0.2];
            [contentView addSubview:leftDay];
        
            UILabel *people = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftDay.frame)+20, leftDay.frame.origin.y, screenwith-CGRectGetMaxX(leftDay.frame)-100, 15)];
            people.text = @"saries saries2 saries3";
            people.textAlignment = NSTextAlignmentRight;
            people.font = [UIFont systemFontOfSize:14 weight:0.2];
            people.textColor = [CreateBase createColor:127];
            people.tag  = 1006;
            [contentView addSubview:people];
        }
        Task *task = self.yiwancheng[indexPath.row];
            UIView *leftline = [cell2 viewWithTag:1001];
            UILabel *sonc = [cell2 viewWithTag:1007];
            UIButton *compelete = [cell2 viewWithTag:1002];
            UILabel *title = [cell2 viewWithTag:1003];
            UIView *tag1 = [cell2 viewWithTag:3001];
            UIView *tag2 = [cell2 viewWithTag:3002];
            UIView *tag3 = [cell2 viewWithTag:3003];
            UILabel *taglab1 = [tag1 viewWithTag:2001];
            UILabel *taglab2 = [tag2 viewWithTag:2002];
            UILabel *taglab3 = [tag3 viewWithTag:2003];
            UIView *dayline = [cell2 viewWithTag:1004];
            UILabel *leftday = [cell2 viewWithTag:1005];
            UILabel *people = [cell2 viewWithTag:1006];
            UIColor *statusColor = [CreateBase createColor:215];
            tag1.hidden = YES;
            tag2.hidden = YES;
            tag3.hidden = YES;
            sonc.text = [NSString stringWithFormat:@"%@/%@",task.subTaskCompletedNum,task.subTaskNum];
            
            title.text = task.taskTitle;
            leftline.backgroundColor = statusColor;
            compelete.layer.borderColor = mainColor.CGColor;
        [compelete setBackgroundColor:mainColor];
        [compelete setBackgroundImage:[UIImage imageNamed:@"完成"] forState:UIControlStateNormal];
        
        dayline.hidden = YES;
            
            for (int i =0 ;i < task.tags.count;i++)
            
            {
                NSDictionary *dic = task.tags[i];
                tag *t = [[tag alloc]initWithDictionary:dic error:nil];
                UIView *view = [cell2 viewWithTag:3001+i];
                UILabel *lab  = [view viewWithTag:2001+i];
                lab.text = t.tagContent;
                view. backgroundColor = statusColor;
                CGSize expectSize3= [lab sizeThatFits:CGSizeMake(100, 100)];
                lab.frame = CGRectMake(10, 0, expectSize3.width, 20);
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, expectSize3.width+20, 20);
                if(i != 0)
                {
                    UIView *preView = [cell2 viewWithTag:view.tag -1];
                    view.frame = CGRectMake(CGRectGetMaxX(preView.frame)+10, view.frame.origin.y, expectSize3.width+20, 20);
                }
                view.hidden = NO;
                
            }
            leftday.hidden = YES;
            people.text = @"";
            for (NSDictionary *dic in task.participants)
            {
                participant *p = [[participant alloc]initWithDictionary:dic error:nil];
                people.text  = [NSString stringWithFormat:@"%@ %@",people.text,p.userName];
            }
        return cell2;
    }
    return  cell;
}
-(void)completeClick:(UIButton *)sender
{
    NSInteger index  = [self.btns indexOfObject:sender];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要完成任务吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LCProgressHUD showLoading:nil];
        
        Task *t = self.weiwancheng[index];
        [[ApiManager shareInstance]POST:[NSString stringWithFormat:@"/task/status/%@",t.taskId] parameters:nil needsToken:YES Success:^(id responseObject) {
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
                t.taskStatus = [NSNumber numberWithInt:1];
                [LCProgressHUD hide];
                [LCProgressHUD showSuccess:@"任务完成！"];
                [self resetArray];
                sleep(0.5);
                [self.tableView reloadData];
            }
                } Failure:^(id error) {
                    [LCProgressHUD hide];
                    [CreateBase showInternetFail];
                }];
        [self.weiwancheng removeObject:t];
        [self.yiwancheng addObject:t];
        
        
    }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
    [self presentViewController:alert animated:YES completion:^{
            
    }];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    return 180.0;
    else
        return 130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%@",indexPath);
}
-(void)refreshData
{
    
    [self.tableView.mj_header beginRefreshing];
    [CreateBase updateProjectAtIndex:self.pjid finish:^{
        Project * p =[CreateBase searchProject:self.pjid];
        if(self.leixing == 0)
        {
            self.planArrays = p.week_tasks;
        }
        else
        {
            self.planArrays = p.all_tasks;
        }
        [self resetArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];

    
    
//    if(_planArrays.count == 0)
//    {
//        //self.tableView.hidden = YES;
//    }
//    else
//    {
//        self.isEmpty.hidden = YES;
//    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    return 30;
    return  0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 30)];
    view.backgroundColor = mainBackGroundColor;
    if(section == 0)
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"未完成";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
        return nil;
    }
    else
    {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, screenwith, 15)];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"已完成";
        lab.font = [UIFont systemFontOfSize:14 weight:0.5];
        [view addSubview:lab];
    }
    
    return view;
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"执行ViewwillAppear");
    if(self.planArrays.count == 0)
    {
        self.tableView.hidden = YES;
        self.isEmpty.hidden = NO;
    }
    else
    {
        self.isEmpty.hidden = YES;
        self.isEmpty.hidden = YES;
    }
//    self.weiwancheng = [NSMutableArray new];
//    self.yiwancheng = [NSMutableArray new];
    [LCProgressHUD showLoading:nil];
//    [CreateBase updateProjectAtIndex:self.pjid finish:^{
        Project * p =[CreateBase searchProject:self.pjid];
//
            self.planArrays = p.all_tasks;
//
        [self resetArray];
        [self.tableView reloadData];
        [LCProgressHUD hide];
        //[self.tableView.mj_header endRefreshing];
   // }];
}
-(void)resetArray
{
    if(self.planArrays.count == 0)
    {
        //self.tableView.hidden = YES;
    }
    else
    {
        self.isEmpty.hidden = YES;
    }
    self.weiwancheng = [NSMutableArray new];
    self.yiwancheng = [NSMutableArray new];
    for (Task *t in self.planArrays)
    {
        if([t.taskStatus isEqual:[NSNumber numberWithInt:0]])
        {
            [self.weiwancheng addObject:t];
        }
        else
        {
            [self.yiwancheng addObject:t];
        }
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
