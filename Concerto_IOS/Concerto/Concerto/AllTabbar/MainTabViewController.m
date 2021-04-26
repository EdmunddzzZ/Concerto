//
//  MainTabViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "MainTabViewController.h"
#import "myProjectViewController.h"
#import "MyViewController.h"
#import "CreateBase.h"
#import "MainViewController.h"
@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController * mainView = [MainViewController new];
    myProjectViewController * mp = [myProjectViewController new];
    MyViewController *mw = [MyViewController new];
//    mainView.title = @"日程";
//    mp.title = @"我的项目";
//    mw.title = @"我的";
    mainView.tabBarItem.image = [[UIImage imageNamed:@"main"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainView.tabBarItem.selectedImage = [[UIImage imageNamed:@"main"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    mp.tabBarItem.image = [[UIImage imageNamed:@"myProject"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mp.tabBarItem.selectedImage = [[UIImage imageNamed:@"myProject"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    mw.tabBarItem.image = [[UIImage imageNamed:@"my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mw.tabBarItem.selectedImage = [[UIImage imageNamed:@"my"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : mainColor} forState:UIControlStateSelected];
    UIEdgeInsets edge;
    if(Safearea >10 )
    {
        edge = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    else
    {
        edge = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    mainView.tabBarItem.imageInsets = edge;
    mp.tabBarItem.imageInsets = mainView.tabBarItem.imageInsets;
    mw.tabBarItem.imageInsets = mainView.tabBarItem.imageInsets;
    NSArray *vcarray = [NSArray arrayWithObjects:mainView,mp,mw, nil];
    self.viewControllers = vcarray;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.alpha =1;
    self.tabBar.tintColor = mainColor;
    
    // Do any additional setup after loading the view.
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
