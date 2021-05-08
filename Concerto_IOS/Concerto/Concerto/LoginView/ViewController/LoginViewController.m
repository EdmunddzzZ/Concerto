//
//  LoginViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/22.
//

#import "LoginViewController.h"
#import "CreateBase.h"
#import "ViewManager.h"
#import "RegisteViewController.h"
#import "MainTabViewController.h"
@interface LoginViewController ()
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIView *accountView;
@property(nonatomic,strong)UIView *pswView;
@property(nonatomic,strong)UITextField *account;
@property(nonatomic,strong)UITextField *psw;
@property(nonatomic,strong)UIButton *login;
@property(nonatomic,strong)UIButton *registe;
@property(nonatomic,strong)UIButton *forget;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [CreateBase createColor:252 blue:247 green:234];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.icon];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.pswView];
    [self.view addSubview:self.login];
    [self.view addSubview:self.registe];
    [self.view addSubview:self.forget];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(UIButton *)registe
{
    if(!_registe)
    {
        _registe = [[UIButton alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(self.login.frame)+40, 100, 15)];
        [_registe setTitle:@"注册新用户" forState:UIControlStateNormal];
        [_registe setTitleColor:[CreateBase createColor:101 blue:206 green:185] forState:UIControlStateNormal];
        [_registe.titleLabel setFont:[UIFont systemFontOfSize:14 weight:0.5]];
        [_registe addTarget:self action:@selector(RegisteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registe;
}
-(UIButton *)forget
{
    if(!_forget)
    {
        _forget = [[UIButton alloc]initWithFrame:CGRectMake(screenwith-150, CGRectGetMaxY(self.login.frame)+40, 100, 15)];
        [_forget setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forget setTitleColor:[CreateBase createColor:101 blue:206 green:185] forState:UIControlStateNormal];
        [_forget.titleLabel setFont:[UIFont systemFontOfSize:14 weight:0.5]];
    }
    return _forget;
}
-(UIButton *)login
{
    if(!_login)
    {
        _login = [[UIButton alloc]initWithFrame:CGRectMake(self.accountView.frame.origin.x, CGRectGetMaxY(self.pswView.frame)+50, self.accountView.frame.size.width, 50)];
        [_login setBackgroundColor:[CreateBase createColor:101 blue:206 green:185]];
        _login.layer.cornerRadius = 5;
        _login.layer.masksToBounds = YES;
        [_login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
    }
        return _login;
}
-(UIView *)accountView
{
    if(!_accountView)
    {
        _accountView = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.icon.frame)+50, screenwith-2*40, 55)];
        _accountView.backgroundColor = [UIColor whiteColor];
        _account = [[UITextField alloc]initWithFrame:CGRectMake(_accountView.frame.size.width*0.2, 10, _accountView.frame.size.width*0.8, _accountView.frame.size.height-20)];
        _account.placeholder = @"请输入您的邮箱";
        _accountView.layer.borderWidth = 1;
        _accountView.layer.cornerRadius = 4;
        _accountView.layer.masksToBounds = YES;
        _accountView.layer.borderColor = [CreateBase createColor:228].CGColor;
        [_accountView addSubview:_account];
    }
    return _accountView;
}
-(UIView *)pswView
{
    if(!_pswView)
    {
        _pswView = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.accountView.frame), screenwith-2*40, 55)];
        _pswView.backgroundColor = [UIColor whiteColor];
        _psw = [[UITextField alloc]initWithFrame:CGRectMake(_pswView.frame.size.width*0.2, 10, _pswView.frame.size.width*0.8, _pswView.frame.size.height-20)];
        _psw.placeholder = @"请输入您的密码";
        _pswView.layer.borderWidth = 1;
        _pswView.layer.cornerRadius = 4;
        _pswView.layer.masksToBounds = YES;
        _psw.secureTextEntry = YES;
        //_pswView.layer.borderColor = [CreateBase createColor:228].CGColor;
        _pswView.layer.borderColor = [CreateBase createColor:228].CGColor;
        [_pswView addSubview:_psw];
    }
    return _pswView;
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
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-25, screenwith, 20)];
        login.text = @"登   录";
        login.font = [UIFont systemFontOfSize:20 weight:1.0];
        login.textColor = [UIColor blackColor];
        login.textAlignment = NSTextAlignmentCenter;
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _topBar.frame.size.height, screenwith, 1)];
        line.backgroundColor = [CreateBase createColor:228];
        [_topBar addSubview:line];
        [_topBar addSubview:login];
        
    }
    return _topBar;
}
-(void)RegisteClick
{
    [[ViewManager shareInstance].NavigationController pushViewController:[RegisteViewController new] animated:YES];
}
-(void)loginClick
{
    if(![CreateBase validateEmail:self.account.text])
    {
        [CreateBase showMessage:@"请输入正确的用户名"];
        return;
    }
//    else if(![CreateBase validatePassword:self.psw.text])
//    {
//        [CreateBase showMessage:@"请输入正确的密码"];
//    }
    //[SVProgressHUD showWithStatus:@""];
    [LCProgressHUD showLoading:@""];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:self.account.text forKey:@"email"];
    [dic setObject:[CreateBase md5:self.psw.text] forKey:@"password"];
    self.login.enabled = NO;
    [[ApiManager shareInstance]POST:@"/User/Login" parameters:dic needsToken:NO Success:^(id responseObject) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];;
        NSLog(@"%@",dictionary);
        NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"data"]];;
        if(data.length == 0)
        {
            [dictionary setObject:[NSDictionary new] forKey:@"data"];
        }
        RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
        if([obj isSuccessful])
        {
            NSString *token = (NSString *)obj.data;
            [AppData shareInstance].token = token;
            [[AppData shareInstance] saveData];
            NSLog(@"%@",token);
            [LCProgressHUD hide];
            [CreateBase showMessage:@"登录成功"];
            self.login.enabled = YES;
            self.account.text = @"";
            self.psw.text = @"";
            [CreateBase updateUserInfo];
            [CreateBase updateProject];
            [[ViewManager shareInstance].NavigationController pushViewController:[MainTabViewController new] animated:YES];
            //[self.sendMsg startCountDown];
        }
        else
        {
            //[SVProgressHUD dismiss];
            [LCProgressHUD hide];
            self.login.enabled = YES;
            [CreateBase showMessage:obj.message];
        }
        } Failure:^(id error) {
            //[SVProgressHUD dismiss];
            [LCProgressHUD hide];
            self.login.enabled = YES;
            [CreateBase showInternetFail];
        }];
    //[[ViewManager shareInstance].NavigationController pushViewController:[MainTabViewController new] animated:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.login.enabled = YES;
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
