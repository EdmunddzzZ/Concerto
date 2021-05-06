//
//  Task.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/3.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task : JSONModel
@property(nonatomic,strong)NSNumber *taskId;
@property(nonatomic,strong)NSNumber *projectId;
@property(nonatomic,strong)NSNumber *parentTaskId;
@property(nonatomic,strong)NSNumber *taskStatus;
@property(nonatomic,strong)NSString *taskVersion;
@property(nonatomic,strong)NSString *taskTitle;
@property(nonatomic,strong)NSNumber *taskType;
@property(nonatomic,strong)NSNumber *taskPriority;
@property(nonatomic,strong)NSString *tastStartTime;
@property(nonatomic,strong)NSString *taskEndTime;
@property(nonatomic,strong)NSNumber *subTaskNum;
@property(nonatomic,strong)NSNumber *subTaskCompletedNum;
@property(nonatomic,strong)NSNumber *taskDays;
@property(nonatomic,strong)NSArray *tags;

@end

NS_ASSUME_NONNULL_END
