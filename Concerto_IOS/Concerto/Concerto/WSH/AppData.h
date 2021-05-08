//
//  AppData.h
//  SchoolFriendGather
//
//  Created by mac on 2020/9/20.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userInfo.h"
//13215986477
//127-text
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
+ (AppData*)shareInstance;
- (void)saveData;
- (void)cleardata;
@property(nonatomic,strong)userInfo *user_info;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSMutableArray *identities;
@property(nonatomic,strong)NSMutableArray *myProject;
@end

NS_ASSUME_NONNULL_END
