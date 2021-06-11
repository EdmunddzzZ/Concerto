//
//  ClientViewController.m
//  SchoolFriendGather
//
//  Created by LXX on 2019/4/15.
//  Copyright © 2019年 xianjun yang. All rights reserved.
//

#import "ClientViewController.h"
#import "MerchantViewController.h"
#import "YCMenuView.h"
#import "SVProgressHUD.h"
#import "UIColor+ZDMColor.h"
#import "SDCycleScrollView.h"
#import "SchoolStoreTableViewCell.h"
#import "NetDataDeal+UIViewController.h"
#import "YXJInterfaceConnection.h"
#import "MJRefresh.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UserInfo.h"

#import "SelectViewController.h"
#import "MerchantDetailViewController.h"

#import "CompanyInfo.h"
#import "CompanyActivityInfo.h"

#import "CertificationStateViewController.h"
#import "CertificationFailedViewController.h"
#import "SuccessIdentificationViewController.h"
#import "CompanyIndentificationViewController.h"
#import "FirstIndentificationViewController.h"
#import "WXApi.h"
@interface ClientViewController ()<UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *backView;

@property (nonatomic, strong) UserInfo *userInfo;                           /**< 用户信息Model */

@property(nonatomic,strong) NSArray *menuArray1;
@property(nonatomic,strong) NSArray *menuArray2;

@property (nonatomic) UITableView *storeTableView;
@property (nonatomic) NSInteger menuNumber;
@property (nonatomic) NSInteger currentMenu;
@property (nonatomic) NSMutableArray *storeInfoArr;


//大背景scrollView
@property (nonatomic) SDCycleScrollView *imageCycleView;
@property (nonatomic) CGFloat imageCycleHeight;

////总体数据
//@property (nonatomic) NSMutableArray * totalArray;
//@property (nonatomic) NSMutableArray * titleArray;

//具体数据数组
@property (nonatomic) NSMutableArray *activityData;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSInteger nowPage;

//轮播图数据源
@property (nonatomic) NSMutableArray *titleArr;
@property (nonatomic) NSMutableArray *commpanyIdArr;
@property (nonatomic) NSMutableArray *cycleImgArr;

@property (nonatomic) NSInteger nowRow;

@property (nonatomic, strong) NSString * currentLevel;
@property (nonatomic, strong) CompanyInfo * companyInfoDetail;              /**< 企业详情 Model */


@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor= ThemeColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationItem setHidesBackButton:YES];
    
    //[self setUpSelectView];
    [self setMenuViewAction];
    
    [self dataConfiguration];
    [self loadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    NSString *studentID = [NSString stringWithFormat:@"%@",userInfo.uid];
    if(studentID) {
        [self updateUserInfo];
    }
    [self loadSelfCompanyData];
    
    [self updateData];
}
#pragma mark - Private DataConfiguration
- (void)dataConfiguration{
    self.titleArr = [[NSMutableArray alloc] init];
    self.commpanyIdArr = [[NSMutableArray alloc] init ];
    //self.coverImgArr = [[NSMutableArray alloc] init];
    self.cycleImgArr = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    self.storeInfoArr = [[NSMutableArray alloc] init];
    self.nowPage = 1;
    
    self.nowRow = -1;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;


    [self createTitle:@"校友圈" LeftItem:0 Content:@"" RightItem:0 Content:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn addTarget:self action:@selector(clientMenuClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
//    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
//    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"切换"]  style:UIBarButtonItemStyleDone target:self action:@selector(clientMenuClick:)];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(clientMenuClick:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"筛选"]  style:UIBarButtonItemStyleDone target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    //轮播图高度
    _imageCycleHeight = 180;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - Private SetupContentView
-(void)setUpContentView {
    //设置图片轮播图
//    self.cycleImgArr = [[NSMutableArray alloc] initWithObjects:@"banner1.png", @"banner1.png", nil];
//    self.imageCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_WIDTH,_imageCycleHeight) imageNamesGroup:self.cycleImgArr];
//    self.imageCycleView.delegate = self;
    

//    if(_companyInfoArr.count > 0) {
//        for(CompanyInfo *companyInfo in _companyInfoArr ) {
//            if(companyInfo.isTop) {
//                if(![companyInfo.topPicDiskName isEqualToString:@""]){
//                    [_cycleImgArr addObject:companyInfo.topPicDiskName];
//                    NSLog(@"url:%@",companyInfo.topPicDiskName);
//                }
//            }
//        }
//    }else {
//        NSLog(@"空的");
//    }
    
    self.imageCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_WIDTH,_imageCycleHeight) imageNamesGroup:self.cycleImgArr];
    self.imageCycleView.delegate = self;

    //设置活动视图，storeTableView
    self.storeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,/*40+*/0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - kStatusBarHeight)];
    //self.storeTableView = [[UITableView alloc] init];
    
    self.storeTableView.showsVerticalScrollIndicator = NO;
    self.storeTableView.delegate =self;
    self.storeTableView.dataSource = self;
    self.storeTableView.backgroundColor = [UIColor colorWithZDMString:@"f7f7f7" alpha:1.0f];
    self.storeTableView.showsVerticalScrollIndicator = NO;
    self.storeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.storeTableView.mj_header.automaticallyChangeAlpha = YES;
    //self.storeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.storeTableView registerNib:[UINib nibWithNibName:@"SchoolStoreTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SchoolStoreTableCell"];
    UIView *view = [[UIView alloc] init];
    self.storeTableView.tableFooterView = view;
    
    self.storeTableView.tableHeaderView = self.imageCycleView;
    
    [self.view addSubview:self.storeTableView];
    
    self.view.backgroundColor = [UIColor colorWithZDMString:@"f7f7f7" alpha:1.0f];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.storeTableView.estimatedRowHeight = 0;
    self.storeTableView.estimatedSectionFooterHeight = 0;
    self.storeTableView.estimatedSectionHeaderHeight = 0;
//    self.storeTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Private GetCycleImage
//获取轮播图信息
-(void)getCycleImage {

//    self.titleArr = [[NSMutableArray alloc] initWithObjects:@"想要听你说，快乐多过忧愁", @"想要听你说，你看到的光是我", nil];
    
    //self.imageCycleView.imageURLStringsGroup = self.cycleImgArr;
    self.imageCycleView.localizationImageNamesGroup = self.cycleImgArr;
    self.imageCycleView.titlesGroup = self.titleArr;
    self.imageCycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.imageCycleView.showPageControl = YES;
    self.imageCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.imageCycleView.delegate = self;
    self.imageCycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    //self.imageCycleView.hidden = YES;
    
    self.imageCycleView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

#pragma mark - Private LoadData

-(void)loadData{
    self.cycleImgArr = [[NSMutableArray alloc]init];
    self.titleArr = [[NSMutableArray alloc]init];
    self.commpanyIdArr = [[NSMutableArray alloc]init];
//获取置顶轮播图
//    YXJInterfaceConnection *connect2 = [[YXJInterfaceConnection alloc] init];
//    NSString *getStr = [NSString stringWithFormat:@"alumni?top=true"];
//    [connect2 connetNetWithGetMethod:getStr parms:nil type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
//        //[self boxDealWithFail:fail msg:dataMessage];
//        if(fail == 0) {
//            NSArray *companyInfoDics = [[NSArray alloc] init];
//            companyInfoDics = [dictionary objectForKey:@"data"];
//            for (NSDictionary *companyInfoDic in companyInfoDics) {
//                CompanyInfo *companyInfo = [[CompanyInfo alloc] initWithNSDictionary:companyInfoDic];
//                if(![companyInfo.topPicDiskName isKindOfClass:[NSNull class]]){
//                    if(![companyInfo.topPicDiskName isEqualToString:@""]) {
//                        if(companyInfo.topPicDiskName != nil){
//                            [_cycleImgArr addObject:companyInfo.topPicDiskName];
//                            [_titleArr addObject:[NSString stringWithFormat:@"%@",companyInfo.name]];
//                            [_commpanyIdArr addObject:[NSString stringWithFormat:@"%@",companyInfo.id]];
//                        }
//                    }
//                }
//            }
//        }
//        if(fail ==1){
//            NSLog(@"error topPicDiskName %@",dataMessage);
//        }
//    }];
    [self.titleArr addObject:@"校友直播平台"];
    [self.cycleImgArr addObject:@"校友直播平台"];
    
    YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc] init];
    [connect connetNetWithGetMethod:@"alumni/list" parms:nil type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary) {
        if([dataMessage isEqualToString:@"登录已过期，请重新登录"]) {
            [self alertWithMessage:dataMessage];
            [self backToLogin];
            return;
        } else {
            //[self boxDealWithFail:fail msg:dataMessage];
        }
        if(fail == 0) {
            self.companyInfoArr = [[NSMutableArray alloc] init];
            NSDictionary *companyInfoDics = [[NSDictionary alloc] init];
            companyInfoDics = [dictionary objectForKey:@"data"];
            for (NSDictionary *companyInfoDic in companyInfoDics) {
                CompanyInfo *companyInfo = [[CompanyInfo alloc] initWithNSDictionary:companyInfoDic];
                [self.companyInfoArr addObject:companyInfo];
                
            }
            dispatch_async(dispatch_get_main_queue(),^{
//                [self creatTableView];
                [self setUpContentView];
                [self getCycleImage];
                [self.storeTableView reloadData];
                [self.view layoutIfNeeded];
            });
        }
        if(fail==1){
            NSLog(@"error companyInfoDics %@",dataMessage);
        }
    }];
    [self.storeTableView.mj_header endRefreshing];
}

#pragma mark - Private LoadMoreData

- (void)loadMoreData {
    
    [self.storeTableView.mj_footer endRefreshing];
}
-(void)updateData{
    YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc] init];
    [connect connetNetWithGetMethod:@"alumni/list" parms:nil type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary) {
        if([dataMessage isEqualToString:@"登录已过期，请重新登录"]) {
            [self alertWithMessage:dataMessage];
            [self backToLogin];
            return;
        } else {
            //[self boxDealWithFail:fail msg:dataMessage];
        }
        if(fail == 0) {
            self.companyInfoArr = [[NSMutableArray alloc] init];
            NSDictionary *companyInfoDics = [[NSDictionary alloc] init];
            companyInfoDics = [dictionary objectForKey:@"data"];
            for (NSDictionary *companyInfoDic in companyInfoDics) {
                CompanyInfo *companyInfo = [[CompanyInfo alloc] initWithNSDictionary:companyInfoDic];
                [self.companyInfoArr addObject:companyInfo];
            }
            dispatch_async(dispatch_get_main_queue(),^{

//                NSIndexPath *path = [NSIndexPath indexPathForRow:self.nowRow inSection:0];//指定cell
//                [self.storeTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:UITableViewRowAnimationFade];
                
//                [UIView performWithoutAnimation:^{
//                    NSIndexPath *path = [NSIndexPath indexPathForRow:self.nowRow inSection:0];//指定cell
//                    [self.storeTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:UITableViewRowAnimationFade];
//                }];
                
                [self.storeTableView reloadData];
            });
        }
        if(fail==1){
            [LCProgressHUD showMessage:@"网络开小差啦，请稍后"];
            NSLog(@"error update %@",dataMessage);
        }
    }];
}

#pragma mark - CycleScrollViewDelegate

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

//    self.navigationController.navigationBar.topItem.title = @"";
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//
//    MerchantDetailViewController *merchantDetail =[[MerchantDetailViewController alloc]initWithCompanyID:self.commpanyIdArr[index]];
//    merchantDetail.isFirst = YES;
//
//    merchantDetail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:merchantDetail animated:YES];
    WXLaunchMiniProgramReq *lan = [WXLaunchMiniProgramReq object];
    lan.userName = @"gh_884dba2bc347";
    //lan.userName = @"wxe8da021742e3815f";
    lan.miniProgramType = 0;
    lan.path = @"";
//    [WXApi sendReq:lan completion:^(BOOL success) {
//        if(!success)
//        {
//            [SVProgressHUD showErrorWithStatus:@"请先安装微信！"];
//        }
//
//    }];
    if (![WXApi sendReq:lan])
    {
        [CreateBase showMessage:@"请先安装微信"];
    }
    
    
    
}


#pragma mark - ScrollViewControllerDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return 10;
    return self.companyInfoArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    SchoolStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolStoreTableCell"];
    SchoolStoreTableViewCell * cell =[SchoolStoreTableViewCell cellInit:self.storeTableView];
    
    CompanyInfo *companyInfo = [[CompanyInfo alloc]init];
    companyInfo = self.companyInfoArr[indexPath.row];
    
    cell.companyId = [NSString stringWithFormat:@"%@",companyInfo.id];

    if([companyInfo.address isKindOfClass:[NSNull class]]){//判断字符串是否为空
        cell.address.text = [NSString stringWithFormat:@"地址"];
    }else{
        cell.address.text = [NSString stringWithFormat:@"%@",companyInfo.address];
    }
    if([companyInfo.name isKindOfClass:[NSNull class]]){//判断字符串是否为空
        cell.name.text = [NSString stringWithFormat:@"企业名称"];
    }else{
        cell.name.text = [NSString stringWithFormat:@"%@",companyInfo.name];
    }
    if([companyInfo.remark isKindOfClass:[NSNull class]]||[companyInfo.remark isEqualToString:@""]){//判断字符串是否为空
        cell.remark.text = [NSString stringWithFormat:@"企业简介"];
    }else{
        cell.remark.text = [NSString stringWithFormat:@"%@",companyInfo.remark];
    }
    
    cell.viewNumber.text = [NSString stringWithFormat:@"%@",companyInfo.views];
    
    NSString *headImgStr = companyInfo.topPicDiskName;
    cell.topPicVIew.contentMode = UIViewContentModeScaleAspectFill;
    if(![headImgStr isEqualToString:@""]) {
        [cell.topPicVIew sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"act"]];
    }else{
        cell.topPicVIew.image = [UIImage imageNamed:@"act"];
    }
    
    
    cell.likedNumber.text =[NSString stringWithFormat:@"%@",companyInfo.likes];
    NSString *collect = [NSString stringWithFormat:@"%@",companyInfo.isCollected];
    if([collect isEqualToString:@"1"]){
        [cell.likeButton setImage:[UIImage imageNamed:@"大点赞后"] forState:UIControlStateNormal];
        //cell.likedNumber.textColor = ThemeColor;
        cell.likedNumber.textColor = ThemeColor;
        cell.isLike = YES;
    }else {
        [cell.likeButton setImage:[UIImage imageNamed:@"大点赞前"] forState:UIControlStateNormal];
        //cell.likedNumber.textColor =[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        cell.likedNumber.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        cell.isLike = NO;
    }
    
    //    cell.likeButton.imageView.contentMode = UIViewContentModeRight;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 126;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.nowRow = indexPath.row;

    CompanyInfo *companyInfo = [[CompanyInfo alloc] init];
    companyInfo = [self.companyInfoArr objectAtIndex:indexPath.row];
    
    MerchantDetailViewController *merchantDetail =[[MerchantDetailViewController alloc]initWithCompanyID:companyInfo.id];
    merchantDetail.isFirst = YES;
    //merchantDetail.isCollected = [NSString stringWithFormat:@"%@",companyInfo.isCollected];
    merchantDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:merchantDetail animated:YES];
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    // 返回的视图,可以是label
//    UILabel *label= [[UILabel alloc]init];
//    return  label;
//}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    SchoolStoreTableViewCell *myCell =(SchoolStoreTableViewCell *)cell;
//    myCell.backgroundView.backgroundColor = [UIColor whiteColor];
//}

#pragma mark - UIEvent
-(void)setUpSelectView{

    SelectViewController *selectVC =[[SelectViewController alloc]init];
    selectVC.navigationController.navigationBar.topItem.title = @"";
    selectVC.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:selectVC animated:YES];
}


-(void)changeToMerchant{
//    NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
//    self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
//    NSLog(@"isStore1111:%@",self.userInfo.isStore);
//    NSLog(@"isStoreaaa:%@",self.userInfo.uid);
//    NSString *storeString = [NSString stringWithFormat:@"%@",self.userInfo.isStore];
//    if([storeString isEqualToString:@"3"]){
//
//        MerchantViewController * merchantVC = [[MerchantViewController alloc]init];
//        [self.navigationController pushViewController:merchantVC animated:YES];
//    }else {
//
//        SelectViewController *selectVC =[[SelectViewController alloc]init];
//        selectVC.navigationController.navigationBar.topItem.title = @"";
//        selectVC.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [self.navigationController pushViewController:selectVC animated:YES];
//    }
    
    [self identify];
    [self loadSelfCompanyData];
    
    if(![_currentLevel isEqualToString:@"0"]){
        NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
        NSLog(@"isStore:%@",self.userInfo.isStore);
        NSLog(@"isStore22:%@",self.userInfo.uid);
        NSString *storeString = [NSString stringWithFormat:@"%@",self.userInfo.isStore];
        if([storeString isEqualToString:@"0"]){
            CompanyIndentificationViewController *companyIftVC = [[CompanyIndentificationViewController alloc]init];
            companyIftVC.hidesBottomBarWhenPushed = YES;
            companyIftVC.isEdit = NO;
            [self.navigationController pushViewController:companyIftVC animated:YES];
            return;
        }
        if([storeString isEqualToString:@"3"]){
            MerchantViewController *mvc = [[MerchantViewController alloc]init];
            [self.navigationController pushViewController:mvc animated:YES];
            return;
        }
        
        if([self.companyInfoDetail.state isEqualToString:@"Accept"]){
            MerchantViewController *mvc = [[MerchantViewController alloc]init];
            [self.navigationController pushViewController:mvc animated:YES];
        }
        else if([self.companyInfoDetail.state isEqualToString:@"Reject"]){
            CertificationFailedViewController *cerFailView=[[CertificationFailedViewController alloc]init];
            if([self.companyInfoDetail.reason isKindOfClass:[NSNull class]]||[self.companyInfoDetail.reason isEqual:@""]||self.companyInfoDetail.reason == nil){
                cerFailView.tipString = @" ";
            }else {
                cerFailView.tipString = self.companyInfoDetail.reason;
            }
            cerFailView.isAgain = YES;
            cerFailView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cerFailView animated:YES];
            return;
        }
        else if([self.companyInfoDetail.state isEqualToString:@"UnderReview"]){
            CertificationStateViewController *cerStateView=[[CertificationStateViewController alloc]init];
            if([self.companyInfoDetail.applyTime isKindOfClass:[NSNull class]]||[self.companyInfoDetail.applyTime isEqual:@""]||self.companyInfoDetail.applyTime == nil){
                cerStateView.tipString = @" ";
            }else {
                cerStateView.tipString = self.companyInfoDetail.applyTime;
            }
            cerStateView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cerStateView animated:YES];
        }
        return;
    }
}

//下拉菜单的选项
-(void)setMenuViewAction{

    YCMenuAction *changeC=[YCMenuAction actionWithTitle:@"切换角色" image:nil handler:^(YCMenuAction *action) {

        [self changeToMerchant];
        NSLog(@"点击了切换成商家");
    }];
    self.menuArray2 = @[changeC];
}
-(void)clientMenuClick:(UIBarButtonItem *)sender{

    YCMenuView *menuView=[YCMenuView menuWithActions:_menuArray2 width:110 relyonView:sender];
    menuView.textColor=ThemeColor;
    menuView.textFont=[UIFont systemFontOfSize:17];

    [menuView show];
}

#pragma mark - Private Logic
- (void)updateUserInfo {
    YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [connect connetNetWithGetMethod:@"users/info" parms:dic type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
        if(fail == 0) {
            UserInfo *userInfo = [[UserInfo alloc] initWithNSDictionary:[dictionary objectForKey:@"data"]];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.access_token forKey:@"access_token"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInfo = userInfo;
            });
        }
    }];
}

- (void)loadSelfCompanyData{
    YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc] init];
    NSString *getStr = [NSString stringWithFormat:@"alumniIdentity/alumni_status"];
    [connect connetNetWithGetMethod:getStr parms:nil type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
        //[self boxDealWithFail:fail msg:dataMessage];
        
        if(fail == 0) {
            //_companyInfoDetail = [[CompanyInfo alloc] initWithNSDictionary:[dictionary objectForKey:@"data"]];
            NSDictionary *InfoDics = [[NSDictionary alloc] init];
            InfoDics = [dictionary objectForKey:@"data"];
            
            for (NSDictionary *infoDic in InfoDics) {
                _companyInfoDetail = [[CompanyInfo alloc] initWithNSDictionary:infoDic];
                NSLog(@"companyid: %@ --applyTime:%@ --reason:%@",self.companyInfoDetail.id,self.companyInfoDetail.applyTime,self.companyInfoDetail.reason);
            }
            NSLog(@"2222companyid: %@ --applyTime:%@ --reason:%@",self.companyInfoDetail.id,self.companyInfoDetail.applyTime,self.companyInfoDetail.reason);
            
            dispatch_async(dispatch_get_main_queue(),^{
                
            });
        }
        if(fail ==1){
            NSLog(@"error selfCompanyinfo %@",dataMessage);
        }
    }];
}
#pragma mark - identify
-(void)identify{
    [self getCurrentLevel];
    _currentLevel = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentLevel"]];
    if([_currentLevel isEqualToString:@"0"]) {
        NSString * msg = [NSString stringWithFormat:@"\n您还未认证，请前往认证"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
//            YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc]init];
//            [connect connetNetWithGetMethod:@"identity/identity_status" parms:nil type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
//                [self boxDealWithFail:fail msg:dataMessage];
//                if(fail == 0) {
//                    NSDictionary * totalDic = [dictionary objectForKey:@"data"];
//                    NSString *state = [totalDic objectForKey:@"state"];
//                    NSString *tipString = [totalDic objectForKey:@"applyTime"];
//                    //审核中
//                    if([state isEqualToString:@"UnderReview"]) {
//                        CertificationStateViewController * csvc = [[CertificationStateViewController alloc] init];
//                        csvc.hidesBottomBarWhenPushed = YES;
//                        csvc.tipString = tipString;
//                        [self.navigationController pushViewController:csvc animated:YES];
//                    } else if([state isEqualToString:@"Reject"]) {
//                        CertificationFailedViewController * cfvc = [[CertificationFailedViewController alloc] init];
//                        cfvc.hidesBottomBarWhenPushed = YES;
//                        cfvc.tipString = [totalDic objectForKey:@"reason"];
//                        cfvc.isAgain = NO;
//                        [self.navigationController pushViewController:cfvc animated:YES];
//                    } else if([state isEqualToString:@"Accept"]) {
//                        SuccessIdentificationViewController * sivc = [[SuccessIdentificationViewController alloc] init];
//                        [self.navigationController pushViewController:sivc animated:YES];
//                    } else {
//                        FirstIndentificationViewController *fivc = [[FirstIndentificationViewController alloc] init];
//                        fivc.hidesBottomBarWhenPushed = YES;
//                        [self.navigationController pushViewController:fivc animated:YES];
//                    }
//
//                }
//            }];
            [[ApiManager shareInstance]GET:@"/identity/identity_status" parameters:nil needsToken:YES Success:^(id responseObject)
            {
                
                NSDictionary *dictionary = (NSDictionary *)responseObject;
                NSString *fail = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"status"]];
                NSString *dataMessage = [dictionary objectForKey:@"message"];
                //[self boxDealWithFail:fail msg:dataMessage];
                if([fail isEqualToString:@"0"])
                {
                    NSDictionary * totalDic = [dictionary objectForKey:@"data"];
                        NSString *state = [totalDic objectForKey:@"state"];
                        NSString *tipString = [totalDic objectForKey:@"applyTime"];
                        //审核中
                        if([state isEqualToString:@"UnderReview"]) {
                            CertificationStateViewController * csvc = [[CertificationStateViewController alloc] init];
                            csvc.hidesBottomBarWhenPushed = YES;
                            csvc.tipString = tipString;
                            [self.navigationController pushViewController:csvc animated:YES];
                        } else if([state isEqualToString:@"Reject"]) {
                            CertificationFailedViewController * cfvc = [[CertificationFailedViewController alloc] init];
                            cfvc.hidesBottomBarWhenPushed = YES;
                            cfvc.isAgain = NO;
                            cfvc.tipString = [totalDic objectForKey:@"reason"];
                            [self.navigationController pushViewController:cfvc animated:YES];
                        } else if([state isEqualToString:@"Accept"]) {
                            SuccessIdentificationViewController * sivc = [[SuccessIdentificationViewController alloc] init];
                            [self.navigationController pushViewController:sivc animated:YES];
                        } else {
                            FirstIndentificationViewController *fivc = [[FirstIndentificationViewController alloc] init];
                            fivc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:fivc animated:YES];
                        }
                    }
            } Failure:^(id error)
            {
                 if(error)
                       {
                           if([error[@"status"] isEqualToNumber:[NSNumber numberWithInt:403]])
                           {
                               [self boxDealWithFail:1 msg:@"登录已过期，请重新登录"];
                           }
                           else
                           [CreateBase showMessage:error[@"message"]];
                       }
                       else
                       [CreateBase showInternetFail];
            }];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
            //[self identify];
        }];
        [alertController addAction:cancleAction];
        [alertController addAction:defaultAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        //[self creatTableView];
    }
}

@end
