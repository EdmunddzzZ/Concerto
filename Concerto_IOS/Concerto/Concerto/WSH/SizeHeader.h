//
//  SizeHeader.h
//  projectBase
//
//  Created by shanghui wu on 19-5-11.
//  Copyright (c) 2019年 shanghuiwu. All rights reserved.
//

#ifndef projectBase_SizeHeader_h
#define projectBase_SizeHeader_h

#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height
#define iOS7AndAbove            ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define TopBarHeight            (iOS7AndAbove ? 64:44)
#define TopAndSystemHeight      (ScreenHeight == 812.0 ? 88 : 64)
//#define TopAndSystemHeight      (TopBarHeight + SystemHeight)
#define SystemTopY              (iOS7AndAbove ? 20:0)
#define SystemHeight            (iOS7AndAbove ? 0:20)
#define BottomHeight            53
#define StateBarHeight          [[UIApplication sharedApplication] statusBarFrame].size.height//电源条


#define HeadUrl    @"http://115.159.1.248:56666/" //测试使用
#define HostUrl    @"http://115.159.1.248:56666/" //测试使用
#define YOUHUASHUOUrl    @"http://gy.fjmaimaimai.com:5669/" //测试使用

//iPhone X的宽高适配   以iPhone8 高度667.0 为例     iPhone X（1125 * 2436）
#define CJYWidthCoefficient (ScreenHeight == 812.0 ? 375.0/375.0 : ScreenWidth/375.0) //适配系数
#define CJYHeightCoefficient (ScreenHeight == 812.0 ? 667.0/667.0 : ScreenHeight/667.0) //适配系数
#define SafeAreaTopHeight (ScreenHeight == 812.0 ? 88 : 64) //顶部高度
#define SafeAreaBottomHeight (ScreenHeight == 812.0 ? 34 : 0)//底部高度


#define UmengAppkey   @"563c4af467e58e523600246e"


#define MainColor    CJYColor(0, 174, 255)

#define MainBgColor    [UIColor colorWithRed:249.0/255 green:249.0/255 blue:249.0/255 alpha:1.0]
#define SelectedColor    [UIColor colorWithRed:98.0/255 green:55.0/255 blue:41.0/255 alpha:1.0]
#define TextBgColor      [UIColor colorWithRed:244.0/255 green:237.0/255 blue:231.0/255 alpha:1.0]
#define CJYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorRGB(value) [UIColor colorWithRed:value/255.0 green:value/255.0 blue:value/255.0 alpha:1.0]







#endif

