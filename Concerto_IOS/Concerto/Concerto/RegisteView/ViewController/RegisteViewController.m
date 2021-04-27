//
//  RegisteViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/23.
//

#import "RegisteViewController.h"
#import "CreateBase.h"
#import "ZXCountDownBtn.h"
@interface RegisteViewController ()
@property(nonatomic,strong)UIView *topBar;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UIView *inputView;
@property(nonatomic,strong)UITextField * email;
@property(nonatomic,strong)UITextField * code;
@property(nonatomic,strong)UITextField * psw;
@property(nonatomic,strong)UITextField * repsw;
@property(nonatomic,strong)ZXCountDownBtn *sendMsg;
@property(nonatomic,strong)UIView *agreeView;
@property(nonatomic,assign)bool isAgree;
@property(nonatomic,strong)UIButton *agree;
@property(nonatomic,strong)UIButton *registe;
@property(nonatomic,strong)UIButton *backToLogin;
@property(nonatomic,strong)UITextField *name;

@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [CreateBase createColor:252 blue:247 green:234];
    [self.view addSubview:self.topBar];
    //[self.view addSubview:self.icon];
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.agreeView];
    [self.view addSubview:self.registe];
    [self.view addSubview:self.backToLogin];
    [self.sendMsg setCountDown:60 mark:@"GetCodeBtn" resTextFormat:^NSString * _Nullable(long remainSec) {
        if(remainSec)
        {
            [self.sendMsg setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.sendMsg.layer setBorderColor:[UIColor grayColor].CGColor];
            [self.sendMsg setEnabled:NO];
        }
        else
        {
            [self.sendMsg setTitleColor:[CreateBase createColor:101 blue:206 green:185] forState:UIControlStateNormal];
            [self.sendMsg.layer setBorderColor:[CreateBase createColor:101 blue:206 green:185].CGColor];
            [self.sendMsg setEnabled:YES];
        }
        return [NSString stringWithFormat:@"%ld秒后重发",remainSec];
    }];
    // Do any additional setup after loading the view.
}
-(UIButton *)backToLogin
{
    if(!_backToLogin)
    {
        _backToLogin = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.registe.frame)+20, screenwith, 15)];
        [_backToLogin setTitleColor:[CreateBase createColor:101 blue:206 green:185] forState:UIControlStateNormal];
        [_backToLogin.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_backToLogin addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
        [_backToLogin setTitle:@"已有账户？立即登录" forState:UIControlStateNormal];
    }
    return _backToLogin;
}
-(UIButton *)registe
{
    if(!_registe)
    {
        _registe = [[UIButton alloc]initWithFrame:CGRectMake(self.inputView.frame.origin.x, CGRectGetMaxY(self.agreeView.frame)+25, self.inputView.frame.size.width, 55)];
        [_registe setBackgroundColor:[CreateBase createColor:101 blue:206 green:185]];
        [_registe setTitle:@"注册" forState:UIControlStateNormal];
        [_registe addTarget:self action:@selector(registeClick) forControlEvents:UIControlEventTouchUpInside];
        [_registe.layer setCornerRadius:5];
        [_registe.layer setMasksToBounds:YES];
    }
    return _registe;
}
-(UIView *)agreeView
{
    if(!_agreeView)
    {
        _agreeView = [[UIView alloc]initWithFrame:CGRectMake(self.inputView.frame.origin.x+20, CGRectGetMaxY(self.inputView.frame)+30, self.inputView.frame.size.width-40, 30)];
//        _agreeView.backgroundColor = [UIColor whiteColor];
        _agree = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        //[_agree setBackgroundColor:[CreateBase createColor:101 blue:206 green:185]];
        [_agree.layer setCornerRadius:9];
        [_agree addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
        _isAgree = NO;
        [_agree.layer setBorderColor:[CreateBase createColor:101 blue:206 green:185].CGColor];
        [_agree.layer setBorderWidth:1];
        [_agree.layer setMasksToBounds:YES];
        [_agreeView addSubview:_agree];
        UILabel *settlement = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_agree.frame)+10, _agree.frame.origin.y, 200, 18)];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"同意《用户服务协议》"];
        [str addAttribute:NSForegroundColorAttributeName value:[CreateBase createColor:101 blue:206 green:185] range:NSMakeRange(3, 6)];
        settlement.attributedText = str;
        settlement.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeToSettlement)];
        [settlement addGestureRecognizer:tap];
        [_agreeView addSubview: settlement];
    }
    return _agreeView;
}
-(void)takeToSettlement
{
    NSLog(@"带我去服务协议");
}
-(UIView *)inputView
{
    if(!_inputView)
    {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.topBar.frame)+50, screenwith-80, 65*5)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.layer.cornerRadius = 5;
        _inputView.layer.masksToBounds = YES;
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, screenwith, 1)];
        line1.backgroundColor = [CreateBase createColor:228];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, screenwith, 1)];
        line2.backgroundColor = [CreateBase createColor:228];
        UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 195, screenwith, 1)];
        UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 195+65, screenwith, 1)];
        line4.backgroundColor = [CreateBase createColor:228];
        [_inputView addSubview:line4];
        _name = [[UITextField alloc]initWithFrame:CGRectMake(_inputView.frame.size.width*0.2, 15, _inputView.frame.size.width*0.8, 35)];
        
        _name.placeholder = @"请输入用户名（至少6位）";
        _name.font = [UIFont systemFontOfSize:14];
        [_inputView addSubview:_name];
        _email = [[UITextField alloc]initWithFrame:CGRectMake(_inputView.frame.size.width*0.2, CGRectGetMaxY(line1.frame)+15, _inputView.frame.size.width*0.8, 35)];
        _email.placeholder = @"请输入邮箱地址";
        _email.font = [UIFont systemFontOfSize:14];
        [_inputView addSubview:_email];
        _inputView.layer.borderWidth = 1;
        _inputView.layer.borderColor = [CreateBase createColor:228].CGColor
        ;
        
        line3.backgroundColor = [CreateBase createColor:228];
        [_inputView addSubview:line1];
        [_inputView addSubview:line2];
        [_inputView addSubview:line3];
        _code = [[UITextField alloc]initWithFrame:CGRectMake(_inputView.frame.size.width*0.2, CGRectGetMaxY(line2.frame)+15, _inputView.frame.size.width*0.4, 35)];
        _code.placeholder = @"请输入邮箱验证码";
        _code.font = [UIFont systemFontOfSize:14];
        _psw = [[UITextField alloc]initWithFrame:CGRectMake(_inputView.frame.size.width*0.2, CGRectGetMaxY(line3.frame)+15, _inputView.frame.size.width*0.8, 35)];
        _psw.font = [UIFont systemFontOfSize:14];
        _psw.placeholder = @"请设置6-20位登录密码";
        _psw.secureTextEntry = YES;
        
        _repsw = [[UITextField alloc]initWithFrame:CGRectMake(_inputView.frame.size.width*0.2, CGRectGetMaxY(line4.frame)+15, _inputView.frame.size.width*0.8, 35)];
        _repsw.secureTextEntry = YES;
        _repsw.placeholder = @"请再次确认密码";
        _repsw.font = [UIFont systemFontOfSize:14];
        [_inputView addSubview:_repsw];
        [_inputView addSubview:_psw];
        [_inputView addSubview:_code];
        _sendMsg = [[ZXCountDownBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_code.frame)+30, _code.frame.origin.y, _inputView.frame.size.width*0.25, 35)];
        [_sendMsg setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendMsg.layer setBorderWidth:1];
        [_sendMsg.layer setBorderColor:[CreateBase createColor:101 blue:206 green:185].CGColor];
        [_sendMsg.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sendMsg.layer setCornerRadius:5];
        [_sendMsg setTitleColor:[CreateBase createColor:101 blue:206 green:185] forState:UIControlStateNormal];
        [_sendMsg addTarget:self action:@selector(sendmsg) forControlEvents:UIControlEventTouchUpInside];
        [_inputView addSubview:_sendMsg];
        
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
-(void)agreeClick
{
    if(self.isAgree == NO)
    {
        [self.agree setBackgroundColor:[CreateBase createColor:101 blue:206 green:185]];
        self.isAgree = YES;
    }
    else
    {
        [self.agree setBackgroundColor:[UIColor clearColor]];
        self.isAgree = NO;
    }
}
-(void)sendmsg
{
    if(![CreateBase validateEmail:self.email.text])
    {
        [WHToast showMessage:@"请输入正确的邮箱地址" originY:screenheight- 200 duration:1 finishHandler:^{
                    
        }];
        return;
    }
   // [self.view endEditing:YES];
   // [self.sendMsg setEnabled:NO];
    
    NSDictionary *dic = @{@"email":self.email.text};
    NSString *url = [NSString stringWithFormat:@"/User/Captcha/%@",self.email.text];
    NSMutableDictionary *test = [NSMutableDictionary new];
    [test setObject:@"111" forKey:@"status"];
    [test setObject:@"222" forKey:@"message"];
    [test setObject:[NSDictionary new] forKey:@"data"];
    [test removeObjectForKey:@"status"];
    RespondObject *obj1 = [[RespondObject alloc]initWithDictionary:test error:nil];
    NSLog(@"%@",obj1);
    [[ApiManager shareInstance]GET:url parameters:nil needsToken:NO Success:^(id responseObject)
        {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];;
        NSString *data = (NSString *)[dic objectForKey:@"data"];
        if(data.length == 0)
        {
            [dictionary setObject:[NSDictionary new] forKey:@"data"];
        }
        RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
        if([obj isSuccessful])
        {
            [CreateBase showMessage:@"发送成功"];
            [self.sendMsg setEnabled:YES];
            [self.sendMsg startCountDown];

        }
       //     NSLog(@"%@",(NSDictionary *)responseObject);
        } Failure:^(id error) {
            [CreateBase showMessage:@"发送失败"];
            [self.sendMsg setEnabled:YES];
        }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)registeClick
{
    if(self.name.text.length <= 6 && ![CreateBase validateUserName:self.name.text])
    {
        [CreateBase showMessage:@"请输入正确的用户名"];
    }
    else if(self.email.text.length == 0)
    {
        [CreateBase showMessage:@"请输入正确的邮箱地址"];
    }
    else if(self.code.text.length != 4)
    {
        [CreateBase showMessage:@"请输入正确的验证码"];
    }
    else if(self.psw.text.length == 0)
    {
        [CreateBase showMessage:@"请输入密码"];
    }
    else if(![self.psw.text isEqual:self.repsw.text])
    {
        [CreateBase showMessage:@"两次输入密码不一致"];
    }
    else if(!self.isAgree)
    {
        [CreateBase showMessage:@"请同意《用户服务协议》"];
    }
    else
    {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:self.email.text forKey:@"email"];
        [dic setObject:[CreateBase md5:self.psw.text] forKey:@"password"];
        [dic setObject:self.name.text forKey:@"name"];
        [dic setObject:self.code.text forKey:@"captcha"];
        NSLog(@"%@",dic);
        [[ApiManager shareInstance]POST:@"/User/Register" parameters:dic needsToken:NO Success:^(id responseObject) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:(NSDictionary *)responseObject];;
            NSString *data = (NSString *)[dic objectForKey:@"data"];
            if(data.length == 0)
            {
                [dictionary setObject:[NSDictionary new] forKey:@"data"];
            }
            RespondObject *obj = [[RespondObject alloc]initWithDictionary:dictionary error:nil];
            if([obj isSuccessful])
            {
                [CreateBase showMessage:@"注册成功"];
                [[ViewManager shareInstance].NavigationController popViewControllerAnimated:YES];
                //[self.sendMsg startCountDown];
            }
            else
            {
                [CreateBase showMessage:obj.message];
            }
                } Failure:^(id error) {
                    
                }];
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
