//
//  ChildProjectDetailViewController.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChildProjectDetailViewController : ViewController
@property(nonatomic,assign)NSInteger leixing;
@property(nonatomic,strong)NSString *pjid;
@property(nonatomic,strong)Project *pj;
@property(nonatomic,strong)NSArray *planArrays;
@end

NS_ASSUME_NONNULL_END
