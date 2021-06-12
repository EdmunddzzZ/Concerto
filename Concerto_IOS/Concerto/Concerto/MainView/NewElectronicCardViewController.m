//
//  NewElectronicCardViewController.m
//  SchoolFriendGather
//
//  Created by mac on 2020/9/23.
//  Copyright © 2020 shanghui wu. All rights reserved.
//

#import "NewElectronicCardViewController.h"
#import "NetDataDeal+UIViewController.h"
#import "UIColor+ZDMColor.h"
#import "FSScrollContentView.h"
#import "ElectronicChildViewController.h"
@interface NewElectronicCardViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) NSMutableArray *alltitle;
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation NewElectronicCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self createTitle:@"我的卡" LeftItem:0 Content:nil RightItem:0 Content:nil];
       [self createTitle:nil WithBackButAndRightItem:0 Content:nil];
       self.view.backgroundColor = [UIColor colorWithZDMString:@"f7f7f7" alpha:1.0f];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.backgroundScrollView addSubview:self.titleView];
    [self.backgroundScrollView addSubview:self.pageContentView];
    [self.view addSubview:self.backgroundScrollView];
}
-(FSPageContentView *)pageContentView
{
    if(!_pageContentView)
    {
        NSMutableArray *array = [NSMutableArray new];
        for(int i = 0;i < self.alltitle.count;i++)
        {
            NSString *str = self.alltitle[i];
            ElectronicChildViewController *ecl = [ElectronicChildViewController new];
            ecl.title = str;
            ecl.type = str;
            ecl.index = i;
            ecl.isStudent = ![str isEqualToString:@"校友实体卡"];
            [array addObject:ecl];
        }
        _pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), screenwith, screenheight) childVCs:array parentVC:self delegate:self];
    }
    return _pageContentView;
}
-(FSSegmentTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50) titles:self.alltitle delegate:self  indicatorType:FSIndicatorTypeEqualTitle];
        [_titleView layoutSubviews];
        [_titleView setBackgroundColor:[UIColor whiteColor]];
    }
    return _titleView;
}
-(UIScrollView *)backgroundScrollView
{
    if(!_backgroundScrollView)
    {
        self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT -self.navigationController.navigationBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height)];
    }
    return _backgroundScrollView;
}
-(NSMutableArray *)alltitle
{
    if(!_alltitle)
    {
        _alltitle = [NSMutableArray new];
        for (identities *iden in [AppData shareInstance].identities) {
            if(iden.identityauth)
            [_alltitle addObject:iden.identityauth];
            else
                [_alltitle addObject:@"其他身份"];
        }
        [_alltitle addObject:@"校友实体卡"];
    }
    return _alltitle;
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
