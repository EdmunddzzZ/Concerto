//
//  MyViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/24.
//

#import "MyViewController.h"

@interface MyViewController ()
@property(nonatomic,strong)UIView *topBar;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topBar];
    [self.view setBackgroundColor:mainBackGroundColor];
    // Do any additional setup after loading the view.
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0,0,screenwith,Safearea)];
        [_topBar setBackgroundColor:[UIColor whiteColor]];
    }
    return _topBar;
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
