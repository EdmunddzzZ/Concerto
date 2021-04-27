//
//  RespondObject.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/27.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RespondObject : JSONModel
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSDictionary<Optional> *data;
-(BOOL)isSuccessful;
@end

NS_ASSUME_NONNULL_END
