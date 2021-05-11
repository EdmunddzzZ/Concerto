//
//  SuggestViewController.m
//  SchoolFriendGather
//
//  Created by demo on 2018/6/27.
//  Copyright © 2018年 xianjun yang. All rights reserved.
//

#import "SuggestViewController.h"
#import "UserInfo.h"
@interface SuggestViewController () <UITextViewDelegate>

@property (nonatomic) UITextView * suggestInput;
@property (nonatomic) UILabel * placeholderLabel;
@property(nonatomic,strong)UIView *topBar;
@property (nonatomic) NSInteger maxLength;
@property (nonatomic) UIButton *submitBtn;
@property (nonatomic) UILabel *surplusLbl ; // 剩余可输入字数
@end

@implementation SuggestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topBar];
    self.maxLength = 200;
    self.view.backgroundColor = mainBackGroundColor;
    //NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    //self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    [self setUpUI];
    // Do any additional setup after loading the view.
}
-(UIView *)topBar
{
    if(!_topBar)
    {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, 50+Safearea)];
        _topBar.backgroundColor = [UIColor whiteColor];
       
        UILabel *login = [[UILabel alloc]initWithFrame:CGRectMake(0,_topBar.frame.size.height-25, screenwith, 20)];
        login.text = @"意见反馈";
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
        
        
    }
    return _topBar;
}
-(void)backToPreView
{
    [CreateBase backToPreView];
}
- (void)setUpUI
{
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.topBar.frame)+20, screenwith - 40, screenwith * 0.35)];
    subView.layer.cornerRadius = 8;
    subView.layer.masksToBounds = YES;
    subView.layer.borderWidth = 0.5;
    [subView setBackgroundColor:[UIColor whiteColor]];
    subView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //subView.layer.borderColor = mainColor.CGColor;
    _suggestInput = [[UITextView alloc] initWithFrame:CGRectMake(8, 5, subView.frame.size.width - 16, subView.frame.size.height - 10)];
    _suggestInput.font = [UIFont systemFontOfSize:18];
    _suggestInput.delegate = self;
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, subView.frame.size.width - 10, 30)];
    _placeholderLabel.text= @"请填写您的意见或建议...";
    _placeholderLabel.font = [UIFont systemFontOfSize:18];
    _placeholderLabel.textColor = [UIColor grayColor];
    [_suggestInput addSubview:_placeholderLabel];
    [subView addSubview:self.suggestInput];
    //[subView setBackgroundColor:[UIColor redColor]];
    self.surplusLbl = [[UILabel alloc] initWithFrame:CGRectMake(screenwith - 90, subView.frame.origin.y + subView.frame.size.height + 5 , 60, 30)];
    self.surplusLbl.text = @"0/200";
    self.surplusLbl.font = [UIFont systemFontOfSize:15];
    self.surplusLbl.textColor = [UIColor grayColor];
    [self.view addSubview:subView];
    [self.view addSubview:_surplusLbl];
    CGFloat buttonWidth = 280;
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenwith / 2 - buttonWidth / 2, self.surplusLbl.frame.origin.y + self.surplusLbl.frame.size.height + 25, buttonWidth, 42)];
    self.submitBtn.layer.cornerRadius = 18;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.backgroundColor = mainColor;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submitSuggest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //[_placeholderLabel resignFirstResponder];
    _placeholderLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(_suggestInput.text.length==0)
    {
        //[_placeholderLabel becomeFirstResponder];
        _placeholderLabel.hidden = NO;
    }
}
- (NSAttributedString *)textViewAttributedStr:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(void)submitSuggest
{
//    [self getCurrentLevel];
    [self.view endEditing:YES];
    if(_suggestInput.text.length <= 10) {
        [LCProgressHUD showMessage:@"字数不少于10个字,请填写详细意见"];
        return;
    }
    NSLog(@"意见:%@",self.suggestInput.text);
    if(self.suggestInput.text.length > 0) {
//        
            
    }
}

// 计算剩余可输入字数 超出最大可输入字数，就禁止输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // 设置占位文字是否隐藏
    if(![text isEqualToString:@""]) {
        [self.placeholderLabel setHidden:YES];
    }
    if([text isEqualToString:@""] && range.length == 1 && range.location == 0){
        [self.placeholderLabel setHidden:NO];
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < self.maxLength) {
            return YES;
        }else{
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = self.maxLength - comcatstr.length;
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0, MAX(len, 0)};
        if (rg.length > 0){
            [textView setAttributedText: [self textViewAttributedStr:[textView.text stringByReplacingCharactersInRange:range withString:[text substringWithRange:rg]]]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.surplusLbl.text = [NSString stringWithFormat:@"%d/%ld",0,(long)self.maxLength];
            
        }
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > self.maxLength){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.maxLength];
        [textView setAttributedText: [self textViewAttributedStr:s]];
    }
    //不让显示负数
    self.surplusLbl.text = [NSString stringWithFormat:@"%ld/%ld",MIN(self.maxLength, existTextNum),(long)self.maxLength];
    
}

-(void)alertWithMsg:(NSString *)msg
{
    msg = [NSString stringWithFormat:@"\n%@",msg];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:defaultAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
