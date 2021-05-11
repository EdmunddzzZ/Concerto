//
//  CreateBase.h
//  自定义导航条
//
//  Created by mac on 19/8/4.
//  Copyright © 2019年 Shanghui Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define screenwith [UIScreen mainScreen].bounds.size.width
#define screenheight [UIScreen mainScreen].bounds.size.height
#define sw_(a) a/414.0*screenwith
#define sh_(a) a/736.0*screenheight
#define area ([UIApplication sharedApplication].delegate.window.safeAreaInsets.top >20 ?400:300)
#define Safearea ([UIApplication sharedApplication].delegate.window.safeAreaInsets.top >20 ?44:10)
#define mainColor [CreateBase createColor:101 blue:206 green:185]
#define mainBackGroundColor [CreateBase createColor:252 blue:247 green:234]

@interface CreateBase : NSObject

+(void)showInternetFail;
+(void)showMessage:(NSString *)message;
+(UIButton *)createButton:(CGRect)frame text:(NSString *)text textfont:(float)font target:(SEL)seletor;
+(UIButton *)createButton:(CGRect)frame image:(UIImage *)image target:(SEL)seletor;
+(UIButton *)createButton:(CGRect)frame backgGroundColor:(UIColor *)color target:(SEL)seletor;
+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(float)font backGroundColor:(UIColor *)color textAlignMent:(NSTextAlignment)alignment;
+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(float)font backGroundColor:(UIColor *)color;
+(UILabel *)createLabel:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font;
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color textAlignMent:(NSTextAlignment)alignment;
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color;
+(UITextField *)createTextField:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)color borderWidth:(float)border borderColor:(UIColor *)borderColor;
+(UITextView *)createTextView:(CGRect)frame text:(NSString *)text textfont:(UIFont *)font backGroundColor:(UIColor *)backGroundColor;
+(UITextView *)createTextView:(CGRect)frame backGroundColor:(UIColor *)backGroundColor;
+(UIImageView *)createImageView:(CGRect)frame image:(UIImage *)image;
+(UIColor *)createColor:(float)a blue:(float)b green:(float)c;
+(UIColor *)createColor:(float)a;
+(void)updateUserInfo;
+ (BOOL)judgePhoneNumber:(NSString *)phoneNum;
+(void)backToPreView;
+ (BOOL)validateEmail:(NSString*)email;
+ (NSString *) md5:(NSString *) input;
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) validatePassword:(NSString *)passWord;
+(void)updateProject;
+ (float) heightForString:(UITextView *)textView andWidth:(float)width;
+(NSDate *)stringToDate:(NSString *)str;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSString *) hexFromUIColor: (UIColor*) color;
@end

