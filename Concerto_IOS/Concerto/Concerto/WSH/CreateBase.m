//
//  CreateBase.m
//
//
//  Created by mac on 19/8/4.
//  Copyright © 2019年 Shanghui Wu. All rights reserved.
//

#import "CreateBase.h"

@implementation CreateBase
+(UIButton *)createButton:(CGRect)frame image:(UIImage *)image target:(SEL)seletor
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIButton *)createButton:(CGRect)frame text:(NSString *)text textfont:(float)font target:(SEL)seletor
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [btn addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIButton *)createButton:(CGRect)frame backgGroundColor:(UIColor *)color target:(SEL)seletor
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setBackgroundColor:color];
    [btn addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+(UIImageView *)createImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:frame];
    [img setImage:image];
    return img;
}
+(UITextView *)createTextView:(CGRect)frame backGroundColor:(UIColor *)backGroundColor
{
    UITextView *tv = [[UITextView alloc]initWithFrame:frame];
    [tv setBackgroundColor:backGroundColor];
    return tv;
}
+(UITextView *)createTextView:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)backGroundColor
{
    UITextView *tv = [[UITextView alloc]initWithFrame:frame];
    [tv setText:text];
    [tv setFont:font];
    [tv setBackgroundColor:backGroundColor];
    return tv;
}

+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(float)font backGroundColor:(UIColor *)color
{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    [lab setText:text];
    [lab setFont:[UIFont systemFontOfSize:font]];
    [lab setBackgroundColor:color];
    return lab;
    
}
+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(float)font backGroundColor:(UIColor *)color textAlignMent:(NSTextAlignment)alignment
{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    [lab setText:text];
    [lab setFont:[UIFont systemFontOfSize:font]];
    [lab setBackgroundColor:color];
    [lab setTextAlignment:alignment];
    return lab;
}
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color
{
    UITextField *tx = [[UITextField alloc]initWithFrame:frame];
    [tx setText:text];
    [tx setFont:font];
    [tx setBackgroundColor:color];
    return tx;
}
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color textAlignMent:(NSTextAlignment)alignment
{
    UITextField *tx = [[UITextField alloc]initWithFrame:frame];
    [tx setText:text];
    [tx setFont: font];
    [tx setBackgroundColor:color];
    [tx setTextAlignment:alignment];
    return tx;
}
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color borderWidth:(float)border borderColor:(UIColor *)borderColor
{
    UITextField *tf = [[UITextField alloc]initWithFrame:frame];
    [tf setText:text];
    [tf setFont:font];
    [tf setBackgroundColor:color];
    [tf.layer setBorderWidth:border];
    [tf.layer setMasksToBounds:YES];
    [tf.layer setBorderColor:borderColor.CGColor];
    return tf;
}
+(UIColor *)createColor:(float)a
{
    UIColor *tem = [UIColor colorWithRed:a/255.0 green:a/255.0 blue:a/255.0 alpha:1];
    return tem;
}
+(UIColor *)createColor:(float)a blue:(float)b green:(float)c
{
    UIColor *tem = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1];
    return tem;
}
+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font
{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    [lab setText:text];
    [lab setFont:font];
    return lab;
}
+(void)showInternetFail
{
    [WHToast showMessage:@"连接超时!" originY:screenheight - 150 duration:2 finishHandler:^{
    }];
}
+(void)showMessage:(NSString *)message
{
    [WHToast showMessage:message originY:screenheight - 150 duration:1.5 finishHandler:^{
    }];
}
// 判断是否是11位手机号码
+ (BOOL)judgePhoneNumber:(NSString *)phoneNum
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    // 一个判断是否是手机号码的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
        NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (mobile.length != 11) {
            NO;
        }
        
        // 无符号整型数据接收匹配的数据的数目
        NSUInteger numbersOfMatch = [regularExpression numberOfMatchesInString:mobile options:NSMatchingReportProgress range:NSMakeRange(0, mobile.length)];
        if (numbersOfMatch>0) return YES;
    
    return NO;
    
}
+ (void)updateUserInfo {
    YXJInterfaceConnection *connect = [[YXJInterfaceConnection alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [connect connetNetWithGetMethod:@"users/info" parms:dic type:0 block:^(int fail,NSString *dataMessage,NSDictionary *dictionary){
        if(fail == 0) {
            UserInfo *userInfo = [[UserInfo alloc] initWithNSDictionary:[dictionary objectForKey:@"data"]];
            NSMutableArray *idens  = [NSMutableArray new];
            for (NSDictionary *dic in userInfo.identities)
            {
                
                identities *iden = [[identities alloc]initWithDictionary:dic error:nil];
                [idens addObject:iden];
            }
            [AppData shareInstance].identities = idens;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.access_token forKey:@"access_token"];
            [AppData shareInstance].userinfo = userInfo;
        }
    }];
}









@end
