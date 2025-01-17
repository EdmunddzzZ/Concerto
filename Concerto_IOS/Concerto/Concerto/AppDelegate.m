//
//  AppDelegate.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/22.
//

#import "AppDelegate.h"
#import "ViewManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    userInfo *info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [AppData shareInstance].user_info = info;
    [AppData shareInstance].token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if([AppData shareInstance].token.length != 0)
    {
        [CreateBase updateUserInfo];
        [CreateBase updateProject];
    }
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [ViewManager shareInstance].NavigationController;
    [self.window makeKeyAndVisible];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [WHToast setShowMask:NO];
    return YES;
}

-(void)applicationWillTerminate:(UIApplication *)application
{
    [[AppData shareInstance] saveData];
}
#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
