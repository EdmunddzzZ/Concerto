//
//  RegisteViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/23.
//

#import "RegisteViewController.h"
#import "CreateBase.h"
@interface RegisteViewController ()
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIView *inputView;
@property(nonatomic,strong)UITextField * email;
@property(nonatomic,strong)UITextField * code;
@property(nonatomic,strong)UITextField * psw;
@property(nonatomic,strong)UITextField * repsw;
@property(nonatomic,strong)UIButton *sendMsg;
@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [CreateBase createColor:252 blue:247 green:234];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.icon];
    [self.view addSubview:_inputView];
    // Do any additional setup after loading the view.
}
-(UIView *)inputView
{
    if(!_inputView)
    {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.icon.frame)+50, screenwith-80, 320)];
        _inputView.backgroundColor = [UIColor whiteColor];
        
    }
    return _inputView;
}
-(UIImageView *)icon
{
    if(!_icon)
    {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(screenwith/2-70, CGRectGetMaxY(self.topBar.frame)+40, 140, 140)];
        _icon.backgroundColor = [UIColor whiteColor];
        _icon.layer.cornerRadius =70;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-30, screenwith, 20)];
        login.text = @"新用户注册";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentCenter;
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, _topBar.frame.size.height-30, 20, 20)];
        [backBtn addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        backBtn.adjustsImageWhenHighlighted = NO;
        [_topBar addSubview:backBtn];
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        line.backgroundColor = [CreateBase createColor:228];
        [_topBar addSubview:line];
        [_topBar addSubview:login];
        
    }
    return _topBar;
}
-(void)backToPreView
{
    [CreateBase backToPreView];
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
