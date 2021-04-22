//
//  identities.h
//  SchoolFriendGather
//
//  Created by mac on 2020/9/20.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface identities : JSONModel
@property(nonatomic,strong) NSString *iid;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *sexual;
@property(nonatomic,strong) NSString *grade;
@property(nonatomic,strong) NSString *academy;
@property(nonatomic,strong) NSString *personalid;
@property(nonatomic,strong) NSString *identityauth;
@property(nonatomic,strong) NSString *department;
@property(nonatomic,strong) NSString *graduation;
@end

NS_ASSUME_NONNULL_END
