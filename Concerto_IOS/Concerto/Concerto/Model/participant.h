//
//  participant.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/6.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface participant : JSONModel
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userEmail;
@end

NS_ASSUME_NONNULL_END
