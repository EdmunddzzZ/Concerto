//
//  WSHPickerView.h
//  SchoolFriendGather
//
//  Created by mac on 2020/7/11.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define area ([UIApplication sharedApplication].delegate.window.safeAreaInsets.top >20 ?400:300)
#define Safearea ([UIApplication sharedApplication].delegate.window.safeAreaInsets.top >20 ?30:0)
@interface WSHPickerView : UIView
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSString *currentSelect;
@property(nonatomic,strong)UIButton *cancelbtn; // 取消按钮
@property(nonatomic,strong)UIButton *confirmbtn;// 确定按钮
@property(nonatomic,strong)UIPickerView *dataPicker;
-(void)show;
-(void)hidden;
-(instancetype)initWithFrame:(CGRect)frame anddata:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
