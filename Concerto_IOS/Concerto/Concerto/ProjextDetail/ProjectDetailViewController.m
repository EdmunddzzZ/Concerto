//
//  ProjectDetailViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/3.
//

#import "ProjectDetailViewController.h"
#import "FSScrollContentView.h"
#import "ChildViewController.h"
#import "ChildProjectDetailViewController.h"
#import "DetailViewController.h"
#import "PersonalViewController.h"
#import "LSTPopView.h"
#import "NewTaskViewController.h"
@interface ProjectDetailViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)FSSegmentTitleView *titleView;
@property(nonatomic,strong)FSPageContentView *pageContentView;
@property(nonatomic,strong)UIButton *sortBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,weak)LSTPopView *customView;
@property(nonatomic,strong)UIView *popView;
@property(nonatomic,strong)NSMutableArray *parts;
@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.topBar];
    //[self.view addSubview:self.plan];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.pageContentView];
    [self.view addSubview:self.addBtn];
    // Do any additional setup after loading the view.
}
-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-100, 0.8*screenheight, 64, 64)];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)addClick
{
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5*ScreenWidth, 200)];
    [self.popView setBackgroundColor:[UIColor whiteColor]];
    self.popView.layer.cornerRadius = 10;
    self.popView.layer.masksToBounds = YES;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.popView.frame.size.width, 15)];
    lab.text = @"请选择任务类型";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14 weight:0.4];
    [self.popView addSubview:lab];
    UIButton *normal = [[UIButton alloc]initWithFrame:CGRectMake(0.15*self.popView.frame.size.width, CGRectGetMaxY(lab.frame)+30, 0.7*self.popView.frame.size.width, 30)];
    [normal setTitle:@"普通任务" forState:UIControlStateNormal];
    [normal setBackgroundColor:mainColor];
    normal.layer.cornerRadius = 5;
    normal.layer.masksToBounds = YES;
    [normal addTarget:self action:@selector(normalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:normal];
    
    UIButton *lichengbei = [[UIButton alloc]initWithFrame:CGRectMake(0.15*self.popView.frame.size.width, CGRectGetMaxY(normal.frame)+30, 0.7*self.popView.frame.size.width, 30)];
    [lichengbei setTitle:@"里程碑" forState:UIControlStateNormal];
    [lichengbei setBackgroundColor:[CreateBase createColor:245 blue:128 green:140]];
    lichengbei.layer.cornerRadius = 5;
    lichengbei.layer.masksToBounds = YES;
    [lichengbei addTarget:self action:@selector(lichengbeiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview:lichengbei];
    LSTPopView *cusView = [LSTPopView initWithCustomView:self.popView parentView:[UIApplication sharedApplication].keyWindow popStyle:LSTPopStyleScale dismissStyle:LSTDismissStyleFade];
    cusView.hemStyle = LSTHemStyleCenter;
    LSTPopViewWK(cusView);
    cusView.bgClickBlock = ^{
        [wk_cusView dismiss];
    };
    self.customView = cusView;
    [cusView pop];
}

-(void)normalClick
{
    //
    NewTaskViewController *task = [NewTaskViewController new];
    task.partispants = self.parts;
    task.projectID = self.pj.projectId;
    [[ViewManager shareInstance].NavigationController pushViewController:task animated:YES];
    [self.customView dismiss];
}
-(void)lichengbeiClick
{
    //
}
-(void)LoadData
{
    [CreateBase updateUserInfo];
}
-(FSPageContentView *)pageContentView
{
    if(!_pageContentView)
    {
        NSMutableArray *array = [NSMutableArray new];
        DetailViewController *detail = [DetailViewController new];
        detail.pj = self.pj;
        PersonalViewController *person = [PersonalViewController new];
        for(int i = 0;i < 2 ;i++)
        {
            ChildProjectDetailViewController *c = [ChildProjectDetailViewController new];
            NSMutableArray *arr = [NSMutableArray new];
            for(int j = 0;j < i; j = j+1)
            {
                [arr addObject:[NSNumber numberWithInt:j]];
            }
            c.planArrays = arr;
            [array addObject:c];
        }
        [array addObject:detail];
        [array addObject:person];
        
        _pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screenwith, screenheight) childVCs:array parentVC:self delegate:self];
        
    }
    return _pageContentView;
}
-(FSSegmentTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBar.frame), screenwith, 40) titles:@[@"本周",@"全部",@"详情",@"人员"] delegate:self indicatorType:FSIndicatorTypeDefault];
        _titleView.titleSelectColor = mainColor;
        _titleView.indicatorColor = mainColor;
//        _titleView.indicatorExtension = screenwith*1.0/4;
        [_titleView layoutSubviews];
        [_titleView setBackgroundColor:[UIColor whiteColor]];
    }
    return _titleView;
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
       
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-25, screenwith, 20)];
        login.text = @"xx项目";
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
        _sortBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-50, login.frame.origin.y, 25, 20)];
        [_sortBtn setImage:[UIImage imageNamed:@"sort"] forState:UIControlStateNormal];
        [_topBar addSubview:_sortBtn];
        
    }
    return _topBar;
}
-(void)backToPreView
{
    [CreateBase backToPreView];
}

-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    if(endIndex > 1)
    {
        self.addBtn.hidden = YES;
    }
    else
    {
        self.addBtn.hidden = NO;
    }
    //self.title = self.alltitle;
}
-(void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    if(endIndex > 1)
    {
        self.addBtn.hidden = YES;
    }
    else
    {
        self.addBtn.hidden = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:self.pj.projectId forKey:@"projectId"];
    [[ApiManager shareInstance]GET:@"/project/member" parameters: dic needsToken:YES Success:^(id responseObject) {
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
            self.parts = [NSMutableArray new];
            for (NSDictionary *dic in obj.data)
            {
                participant *p = [[participant alloc]initWithDictionary:dic error:nil];
                [self.parts addObject:p];
            }
        }
        else
        {
            [CreateBase showMessage:@"获取信息失败"];
        }
        [LCProgressHUD hide];
        } Failure:^(id error) {
            [CreateBase showInternetFail];

            //[self.sendMsg setEnabled:YES];
        }];
    
   
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
