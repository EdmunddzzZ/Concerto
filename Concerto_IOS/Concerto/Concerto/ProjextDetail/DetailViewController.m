//
//  DetailViewController.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UILabel *title1;
@property(nonatomic,strong)UILabel *title2;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UITextField *pjtitle;
@property(nonatomic,strong)UILabel *startTime;
@property(nonatomic,strong)UIButton *startBtn;

@property(nonatomic,strong)UILabel *endTime;
@property(nonatomic,strong)UIButton *endBtn;
@property(nonatomic,strong)UILabel *Code;
@property(nonatomic,strong)UIView *decBack;
@property(nonatomic,strong)UITextView *dec;
@property(nonatomic,strong)UIButton *change;
@property(nonatomic,strong)UIButton *cancel;
@property(nonatomic,strong)UIButton *certain;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:mainBackGroundColor];
    [self.view addSubview:self.title1];
    [self.view addSubview:self.baseView];
    [self.view addSubview:self.title2];
    [self.view addSubview:self.decBack];
    [self.view addSubview:self.change];
    [self.view addSubview:self.cancel];
    [self.view addSubview:self.certain];
    // Do any additional setup after loading the view.
}
-(UIButton *)change
{
    if(!_change)
    {
        _change = [[UIButton alloc]initWithFrame:CGRectMake(screenwith/2-75, CGRectGetMaxY(self.decBack.frame)+30, 150, 50)];
        [_change setTitle:@"修改" forState:UIControlStateNormal];
        _change.layer.cornerRadius = 10;
        _change.layer.masksToBounds = YES;
        [_change setBackgroundColor:mainColor];
        [_change addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _change;
}
-(UIButton *)cancel
{
    if(!_cancel)
    {
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake((screenwith-300)/3, CGRectGetMaxY(self.decBack.frame)+30, 150, 50)];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setBackgroundColor:[UIColor grayColor]];
        _cancel.layer.cornerRadius = 10;
        _cancel.layer.masksToBounds = YES;
        _cancel.alpha = 0;
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        _cancel.hidden = YES;
    }
    return _cancel;
}
-(UIButton *)certain
{
    if(!_certain)
    {
        _certain = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancel.frame)+(screenwith-300)/3, CGRectGetMaxY(self.decBack.frame)+30, 150, 50)];
        [_certain setTitle:@"确定" forState:UIControlStateNormal];
        [_certain setBackgroundColor:mainColor];
        _certain.layer.cornerRadius = 10;
        _certain.alpha = 0;
        _certain.layer.masksToBounds = YES;
        [_certain addTarget:self action:@selector(certainClick) forControlEvents:UIControlEventTouchUpInside];
        _certain.hidden = YES;
    }
    return _certain;
}
-(void)cancelClick
{
    self.pjtitle.enabled = NO;
    self.startBtn.enabled = NO;
    self.endBtn.enabled = NO;
    self.change.hidden = NO;
    [self.dec setEditable:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.change.alpha = 1;
        self.certain.alpha = 0;
        self.cancel.alpha = 0;
    } completion:^(BOOL finished) {
        
        self.certain.hidden = YES;
        self.cancel.hidden = YES;
        
    }];
}
-(void)changeClick
{
    self.pjtitle.enabled = YES;
    self.startBtn.enabled = YES;
    [self.dec setEditable:YES];
    self.endBtn.enabled = YES;
    self.certain.hidden = NO;
    self.cancel.hidden = NO;
    [self.pjtitle becomeFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.change.alpha = 0;
        self.certain.alpha = 1;
        self.cancel.alpha = 1;
    } completion:^(BOOL finished) {
        self.change.hidden = YES;
    }];
}
-(UIView *)decBack
{
    if(!_decBack)
    {
        self.dec = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, screenwith - 2*20, 1)];
        self.dec.text = @"12345678987654321`123456789876543212345678987654321`23456789";
        self.dec.font = [UIFont systemFontOfSize:14 weight:0.5];
        self.dec.delegate = self;
        self.dec.returnKeyType = UIReturnKeyDone;
        [self.dec setEditable:NO];
        [self.dec setTextColor:[UIColor blackColor]];
        
        float height = [CreateBase heightForString:self.dec andWidth:screenwith- 2*20];
        height = MAX(100, height);
        self.dec.frame = CGRectMake(0, 0, screenwith-40, height);
        _decBack = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.title2.frame)+25, screenwith- 40, height)];
        [_decBack setBackgroundColor:[UIColor whiteColor]];
        _decBack.layer.cornerRadius = 10;
        _decBack.layer.masksToBounds = YES;
        [_decBack addSubview:self.dec];
    }
    return _decBack;
}
-(UILabel *)title2
{
    if(!_title2)
    {
        _title2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.baseView.frame)+25, screenwith, 15)];
        _title2.text = @"项目描述";
        _title2.font = [UIFont systemFontOfSize:14 weight:0.5];
        _title2.textColor = [UIColor blackColor];
    }
    return _title2;
}
-(UIView *)baseView
{
    if(!_baseView)
    {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(self.title1.frame.origin.x, CGRectGetMaxY(self.title1.frame)+20, screenwith - 2*self.title1.frame.origin.x , 150)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 10;
        _baseView.layer.masksToBounds = YES;
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenwith, 15)];
        name.textAlignment = NSTextAlignmentLeft;
        name.font = [UIFont systemFontOfSize:14 weight:0.5];
        name.text = @"项目名称";
        name.textColor = [UIColor blackColor];
        [_baseView addSubview:name];
        
        UILabel *start = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x, CGRectGetMaxY(name.frame)+30, screenwith, 15)];
        
        start.textAlignment = NSTextAlignmentLeft;
        start.font = [UIFont systemFontOfSize:14 weight:0.5];
        start.text = @"开始时间";
        start.textColor = [UIColor blackColor];
        [_baseView addSubview:start];
        
        UILabel *end = [[UILabel alloc]initWithFrame:CGRectMake(_baseView.frame.size.width/2, start.frame.origin.y, screenwith, 15)];
        end.textAlignment = NSTextAlignmentLeft;
        end.font = [UIFont systemFontOfSize:14 weight:0.5];
        end.text = @"结束时间";
        end.textColor = [UIColor blackColor];
        [_baseView addSubview:end];
        
        UILabel *invite = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(start.frame)+35, screenwith, 15)];
        invite.textAlignment = NSTextAlignmentLeft;
        invite.font = [UIFont systemFontOfSize:14 weight:0.5];
        invite.text = @"邀请码";
        invite.textColor = [UIColor blackColor];
        [_baseView addSubview:invite];
        
        self.pjtitle = [[UITextField alloc]initWithFrame:CGRectMake(100, name.frame.origin.y-5, _baseView.frame.size.width-150, 25)];
        [self.pjtitle setPlaceholder:@"请在此输入项目名称"];
        self.pjtitle.returnKeyType = UIReturnKeyDone;
        self.pjtitle.delegate = self;
        [self.pjtitle setTextAlignment:NSTextAlignmentCenter];
        [self.pjtitle setEnabled: NO];
        self.pjtitle.font = [UIFont systemFontOfSize:15 weight:0.5];
        //[self.pjtitle becomeFirstResponder];
        //[self.pjtitle setBackgroundColor:[UIColor greenColor]];
        [_baseView addSubview:self.pjtitle];
        self.startTime = [[UILabel alloc]initWithFrame:CGRectMake(0.25 *_baseView.frame.size.width, start.frame.origin.y-5, 0.25*_baseView.frame.size.width, 25)];
        self.startTime.font = [UIFont systemFontOfSize:13 weight:0.3];
        self.startBtn = [[UIButton alloc]initWithFrame:self.startTime.frame];
        self.startBtn.tag = 10001;
        [self.startBtn addTarget:self action:@selector(selectedTime:) forControlEvents:UIControlEventTouchUpInside];
       // [self.startTime setBackgroundColor:[UIColor greenColor]];
        self.startTime.textColor = [UIColor grayColor];
        [self.startTime setText:@"2000-11-01"];
        [_baseView addSubview:self.startTime];
        
        
        
        self.endTime = [[UILabel alloc]initWithFrame:CGRectMake(240.0/350 *_baseView.frame.size.width, start.frame.origin.y-5, 0.25*_baseView.frame.size.width, 25)];
        self.endBtn = [[UIButton alloc]initWithFrame:self.endTime.frame];
        self.endBtn.tag = 10002;
        self.endTime.font = [UIFont systemFontOfSize:13 weight:0.3];
        [self.endBtn addTarget:self action:@selector(selectedTime:) forControlEvents:UIControlEventTouchUpInside];
        //[self.endTime setBackgroundColor:[UIColor greenColor]];
        self.endTime.textColor = [UIColor grayColor];
        [self.endTime setText:@"2000-11-01"];
        [_baseView addSubview:self.endTime];
        
        self.Code = [[UILabel alloc]initWithFrame:CGRectMake(self.startTime.frame.origin.x, invite.frame.origin.y-5, _baseView.frame.size.width-2*self.startTime.frame.origin.x, 25)];
        self.Code.font = [UIFont systemFontOfSize:14 weight:0.5];
        self.Code.textAlignment = NSTextAlignmentLeft;
        [self.Code setText:@"123456"];
        [_baseView addSubview:self.Code];
        UIButton *cpBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.endTime.frame.origin.x, invite.frame.origin.y-10, 70.0/350 * _baseView.frame.size.width, 30)];
        [cpBtn setBackgroundColor:mainColor];
        [cpBtn setTitle:@"拷贝" forState:UIControlStateNormal];
        [cpBtn addTarget:self action:@selector(CopyClick) forControlEvents:UIControlEventTouchUpInside];
        [cpBtn.layer setCornerRadius:10];
        [cpBtn.layer setMasksToBounds:YES];
        [_baseView addSubview:cpBtn];
    }
    return _baseView;
}
-(UILabel *)title1
{
    if(!_title1)
    {
        _title1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, screenwith, 15)];
        _title1.text = @"基本资料";
        _title1.font = [UIFont systemFontOfSize:14 weight:0.5];
        _title1.textColor = [UIColor blackColor];
    }
    return _title1;
}
-(void)textViewDidChange:(UITextView *)textView
{
    
    
    float height = [CreateBase heightForString:self.dec andWidth:screenwith- 2*20];
    height = MAX(100, height);
    self.dec.frame = CGRectMake(0, 0, screenwith-40, height);
    self.decBack.frame = CGRectMake(20, CGRectGetMaxY(self.title2.frame)+25, screenwith- 40,height);
    self.change.frame = CGRectMake(screenwith/2-75, CGRectGetMaxY(self.decBack.frame)+30, 150, 50);
    self.cancel.frame =CGRectMake((screenwith-300)/3, CGRectGetMaxY(self.decBack.frame)+30, 150, 50);
    self.certain.frame = CGRectMake(CGRectGetMaxX(self.cancel.frame)+(screenwith-300)/3, CGRectGetMaxY(self.decBack.frame)+30, 150, 50);
}
-(void)CopyClick
{
    UIPasteboard *pab= [UIPasteboard generalPasteboard];
    pab.string = self.Code.text;
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    [SVProgressHUD showSuccessWithStatus:@"已复制至剪切板"];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end

