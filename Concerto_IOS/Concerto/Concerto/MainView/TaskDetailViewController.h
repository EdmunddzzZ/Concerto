//
//  TaskDetailViewController.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/13.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailViewController : ViewController
@property(nonatomic,strong)NSString *projectID;
@property(nonatomic,strong)Task *task;
@property(nonatomic,strong)Project *pj;
@property(nonatomic,strong)NSMutableArray *tags;
@property(nonatomic,strong)NSMutableArray *partispants;
@property(nonatomic,strong)NSMutableArray *selectParts;

@end

NS_ASSUME_NONNULL_END
