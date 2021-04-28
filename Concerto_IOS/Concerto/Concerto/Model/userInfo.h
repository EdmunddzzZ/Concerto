//
//  UserInfo.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/28.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface userInfo : JSONModel
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userPhone;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userEmail;
@property(nonatomic,strong)NSString *userIntroduction;
@end

NS_ASSUME_NONNULL_END
