//
//  AppData.h
//  SchoolFriendGather
//
//  Created by mac on 2020/9/20.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import <Foundation/Foundation.h>
//13215986477
//127-text
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
+ (AppData*)shareInstance;
@property(nonatomic,strong)UserInfo *userinfo;
@property(nonatomic,strong)NSMutableArray *identities;
@end

NS_ASSUME_NONNULL_END
