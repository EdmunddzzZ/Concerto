//
//  WSHPickerView.m
//  SchoolFriendGather
//
//  Created by mac on 2020/7/11.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import "WSHPickerView.h"
#define sw [[UIScreen mainScreen] bounds].size.width
#define sh [[UIScreen mainScreen] bounds].size.height

@interface WSHPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>



@property(nonatomic,strong)UIView *background;
@end
@implementation WSHPickerView
-(instancetype)initWithFrame:(CGRect)frame anddata:(NSArray *)array
{
   self =  [super initWithFrame:frame];
    self.data = array;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.background = [[UIView alloc]initWithFrame:CGRectMake(0, sh, sw, area)];
    [self.background setBackgroundColor:[UIColor whiteColor]];
    self.background.layer.cornerRadius = 10;
    self.background.layer.masksToBounds = YES;
    _dataPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(sw/2-100, -50-Safearea, 200, area)];
    _dataPicker.showsSelectionIndicator = YES;
    _dataPicker.dataSource = self;
    _dataPicker.delegate = self;
    _dataPicker.backgroundColor = [UIColor whiteColor];
    [self.background addSubview:_dataPicker];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, sw, 0.5)];
    [line setBackgroundColor:[UIColor grayColor]];
    //[self addSubview:line];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, sw, 20)];
    title.text = @"请选择身份";
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:20 weight:0.5];
    title.textAlignment = NSTextAlignmentCenter;
    //[self.background addSubview:title];
    self.cancelbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    [_cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    // [_cancelbtn setTitleColor:[UIColor colorWithRed:0 green:149/255.0 blue:247/255.0 alpha:1] forState:UIControlStateNormal];
    [_cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelbtn addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    [self.background addSubview:_cancelbtn];
    _confirmbtn = [[UIButton alloc]initWithFrame:CGRectMake(sw-50, 20, 40, 20)];
    [_confirmbtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmbtn setTitleColor:[UIColor colorWithRed:0 green:149/255.0 blue:247/255.0 alpha:1] forState:UIControlStateNormal];
    [_confirmbtn setTitleColor:[CreateBase createColor:211 blue:58 green:64] forState:UIControlStateNormal];
    //[_confirmbtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.background addSubview:_confirmbtn];
    [self addSubview:self.background];
    
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.data.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.data[row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 200;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
-(void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
//        self.background.frame = CGRectMake(0, self.background.frame.origin.y-area, self.background.frame.size.width, area);
        self.background.frame = CGRectMake(0, sh-area, self.background.frame.size.width, area);
    } completion:^(BOOL finished) {
        //NSLog(@"-------%f--------",self.background.frame.origin.y);
    }];
    
    
}

-(void)hidden
{
    self.currentSelect = [self.data objectAtIndex:[self.dataPicker selectedRowInComponent:0]];
    
    [UIView animateWithDuration:0.3 animations:^{
//        self.background.frame = CGRectMake(0, self.background.frame.origin.y+area, self.background.frame.size.width, area);
        self.background.frame = CGRectMake(0, sh+area, self.background.frame.size.width, area);
    } completion:^(BOOL finished) {
        //[_dataPicker removeFromSuperview];
        //self.dataPicker = nil;
        self.hidden = YES;
        
        //[self removeFromSuperview];
    }];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
   // NSLog(@"%f--%f",point.x,point.y);
//    if(![self.background.layer containsPoint:point])
//    {
//        [self hidden];
//    }
    if(point.y < sh-area)
    {
        [self hidden];
    }
}



@end
