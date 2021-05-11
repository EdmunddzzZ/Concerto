//
//  ApiManager.h
//  AFNetWorking库初试
//
//  Created by 吴尚辉 on 18/01/07.
//  Copyright © 2018年 吴尚辉 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

+ (ApiManager *)shareInstance;


- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     needsToken:(BOOL)needtoken
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure;

- (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
needsToken:(BOOL)needToken
    Success:(void(^)(id responseObject))success
    Failure:(void(^)(id error))failure;
- (void)requestPUTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(id error))enError;
- (void)Post:(NSString *)url
 Parameter:(NSDictionary *)parameter
imageArray:(NSMutableArray *)fileDataArray
   Success:(void(^)(id responseObject))success
   Failure:(void(^)(NSError *error))failure;
- (void)POST2:(NSString *)url
  parameters:(NSDictionary *)parameters
  needsToken:(BOOL)needtoken
     Success:(void(^)(id responseObject))success
      Failure:(void(^)(id error))failure;

@end
