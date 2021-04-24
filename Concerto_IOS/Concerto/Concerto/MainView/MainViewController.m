//
//  MainViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "MainViewController.h"
#import "CreateBase.h"
#import "FSScrollContentView.h"
#import "ChildViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)FSSegmentTitleView *titleView;
@property(nonatomic,strong)FSPageContentView *pageContentView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.topBar];
    //[self.view addSubview:self.plan];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.pageContentView];
    // Do any additional setup after loading the view.
}
-(FSPageContentView *)pageContentView
{
    if(!_pageContentView)
    {
        NSMutableArray *array = [NSMutableArray new];
        for(int i = 0;i < 4 ;i++)
        {
            ChildViewController *c = [ChildViewController new];
            NSMutableArray *arr = [NSMutableArray new];
            for(int j = 0;j < i; j = j+1)
            {
                [arr addObject:[NSNumber numberWithInt:j]];
            }
            c.planArrays = arr;
            [array addObject:c];
        }
        
        _pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screenwith, screenheight) childVCs:array parentVC:self delegate:self];
        
    }
    return _pageContentView;
}
-(FSSegmentTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBar.frame), screenwith, 40) titles:@[@"推荐",@"今日",@"本周",@"本月"] delegate:self indicatorType:FSIndicatorTypeDefault];
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
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(35,_topBar.frame.size.height-25, screenwith, 20)];
        login.text = @"个人日程";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentLeft;
        //UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        //line.backgroundColor = [CreateBase createColor:228];
        //[_topBar addSubview:line];
        [_topBar addSubview:login];
        
    }
    return _topBar;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
-(void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //self.title = self.alltitle;
}
-(void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
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
