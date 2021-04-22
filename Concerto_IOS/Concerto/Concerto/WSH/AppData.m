//
//  AppData.m
//  SchoolFriendGather
//
//  Created by mac on 2020/9/20.
//  Copyright © 2020 xianjun yang. All rights reserved.
//

#import "AppData.h"

@implementation AppData
static AppData* mInstance;

+ (AppData*)shareInstance
{
    if (nil == mInstance)
    {
        mInstance = [[AppData alloc] init];
    }
    
    return mInstance;
}

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        self.userinfo = [UserInfo new];
        [CreateBase updateUserInfo];
    }
    
    return self;
}
@end
