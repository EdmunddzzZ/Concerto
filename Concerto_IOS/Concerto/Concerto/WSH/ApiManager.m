//
//  ApiManager.m
//
//
//  Created by 吴尚辉 on 18/01/07.
//  Copyright © 2018年 吴尚辉 All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

//#import "SizeHeader.h"

//正式环境
static NSString * const BaseURLString = @"http://81.69.253.27:7777";
//测试环境
static NSString * const BaseURLString1 = @"http://xyt.fzu.edu.cn:54321/v1";


static ApiManager *mInstance;
static NSString *TOKEN;
@implementation ApiManager
+ (ApiManager *)shareInstance {
    if (nil == mInstance) {
        mInstance = [[ApiManager alloc] init];
        
    }
    //NSData *deData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
//    UserInfo * userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:deData];
    TOKEN = [AppData shareInstance].token;
    return mInstance;
}
- (void)requestPUTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)( id error))enError{
    NSString *str = TOKEN;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    // 设置请求头
    urlStr = [NSString stringWithFormat:@"%@%@",BaseURLString,urlStr];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:api_key forHTTPHeaderField:@"api_key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"Authorization"];
    [manager PUT:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *errcode = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"errcode"]];
        
        if ([errcode isEqualToString:@"0"]) {
            
            finish(responseObject);
            
        }else{
            NSString *errmsg = [responseObject objectForKey:@"errmsg"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
}


- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
  needsToken:(BOOL)needtoken
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    NSLog(@"请求url = %@",fullUrl);
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSLog(@"body:%@",body);
    NSString *str = TOKEN;
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrl parameters:nil error:nil];
    
    [req setTimeoutInterval:5];
    
    [req setValue:str forHTTPHeaderField:@"token"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            //做是否需要重新登录的判断，其实就是验证token有效性
            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                return ;
            }
            success(responseObject);
        }
        else
        {
            failure(responseObject);
        }
    }] resume];
}
- (void)POST2:(NSString *)url
  parameters:(NSDictionary *)parameters
  needsToken:(BOOL)needtoken
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
    NSArray *keys=[parameters allKeys];
    NSString *content = @"";
    if(keys.count>0)
        content = [NSString stringWithFormat:@"%@=%@",keys[0],[parameters objectForKey:keys[0]]];
    if(keys.count>1)
        for(int i=1;i<keys.count;i++)
        {
            content =[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[parameters objectForKey:keys[i]]];
        }
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    if(![content isEqualToString:@""])
    fullUrl = [NSString stringWithFormat:@"%@?%@",fullUrl,content];
    NSLog(@"请求url = %@",fullUrl);
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSLog(@"body:%@",body);
    NSString *str = TOKEN;
    
    
    NSError *error;
    
   
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrl parameters:nil error:nil];
    
    [req setTimeoutInterval:5];
    
    [req setValue:str forHTTPHeaderField:@"token"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            //做是否需要重新登录的判断，其实就是验证token有效性
            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                return ;
            }
            success(responseObject);
        }
        else
        {
            failure(responseObject);
        }
    }] resume];
}

/*
 更新 get请求 --陈剑英
 */
- (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
 needsToken:(BOOL)needToken
    Success:(void(^)(id responseObject))success
    Failure:(void(^)(id error))failure
{
    NSLog(@"Token:%@",TOKEN);
    NSArray *keys=[parameters allKeys];
    NSString *content = @"";
    if(keys.count>0)
        content = [NSString stringWithFormat:@"%@=%@",keys[0],[parameters objectForKey:keys[0]]];
    if(keys.count>1)
        for(int i=1;i<keys.count;i++)
        {
            content =[NSString stringWithFormat:@"%@&%@=%@",content,keys[i],[parameters objectForKey:keys[i]]];
        }
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    if(![content isEqualToString:@""])
    fullUrl = [NSString stringWithFormat:@"%@?%@",fullUrl,content];
    NSString *str = TOKEN;
    fullUrl = [fullUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    //NSLog(@"fullurl = %@",fullUrl);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    //请求对象
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    //请求方式
    [req setHTTPMethod:@"GET"];
    
    
    //req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setTimeoutInterval:10];

    [req setValue:str forHTTPHeaderField:@"token"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            //
            //            NSLog(@"Reply JSON: %@", responseObject);
            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
//                [DTProgressHUD dismiss];
                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
                
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                return ;
            }
            success(responseObject);
            
        }
        else
        {
            failure(responseObject);
            //            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}

- (void)Post:(NSString *)url
   Parameter:(NSDictionary *)parameter
  imageArray:(NSMutableArray *)fileDataArray
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"token"];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //签名结束
    [manager POST:fullUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         for (NSData *data in fileDataArray) {
             NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
             formatter.dateFormat=@"yyyyMMddHHmmss";
             NSString *str=[formatter stringFromDate:[NSDate date]];
             NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
             [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //不需要实现进度条
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
         //将返回的数据转成json数据格式
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         failure(error);
     }];
}

@end
