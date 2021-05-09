//
//  NewTaskViewController.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/8.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewTaskViewController : ViewController
@property(nonatomic,strong)NSString *projectID;
@property(nonatomic,strong)NSMutableArray *tags;
@property(nonatomic,strong)NSMutableArray *partispants;
@property(nonatomic,strong)NSMutableArray *selectParts;

@end

NS_ASSUME_NONNULL_END
