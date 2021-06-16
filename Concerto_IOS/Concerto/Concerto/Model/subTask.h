//
//  subTask.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/6.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface subTask : JSONModel
@property(nonatomic,strong)NSNumber *taskId;
@property(nonatomic,strong)NSString *taskTitle;
@property(nonatomic,strong)NSNumber *taskStatus;
@property(nonatomic,strong)NSMutableArray *participants;
@end

NS_ASSUME_NONNULL_END
