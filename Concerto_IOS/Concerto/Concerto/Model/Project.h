//
//  Project.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/6.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Project : JSONModel
@property(nonatomic,strong)NSString* projectDescription;
@property(nonatomic,strong)NSString* projectEndTime;
@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,strong)NSString* projectName;
@property(nonatomic,strong)NSString* projectStartTime;
@property(nonatomic,strong)NSDictionary *admin;
@property(nonatomic,strong)NSMutableArray *members;
@property(nonatomic,strong)NSMutableArray *shenqing;
@property(nonatomic,strong)NSMutableArray *week_tasks;
@property(nonatomic,strong)NSMutableArray *all_tasks;
@end

NS_ASSUME_NONNULL_END
