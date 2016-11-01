//
//  AppDelegate.m
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/5/24.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

//Step_1:  引用头文件"SIDHeader.h"
#import "SIDHeader.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建window并显示
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //Step_2:  使用从一登官网创建的App应用获取到的AppID和AppSecret,注册一登SDK服务
    [SuperID registerAppWithAppID:@"5700d5864bed786df6684670" withAppSecret:@"7b431e54c5b217f23a02d2c8"];
    
    //Step_3:  开启或关闭调试模式,YES开启调试模式,App在运行时,控制台会输出相应信息
    [SuperID setDebugMode:YES];
    
    //Step_4:  设置一登SDK的展示的UI语言模式，默认为自动模式
    [SuperID setLanguageMode:SIDAutoMode];
    

    
    //进入Demo主页
    HomeViewController *home = [[HomeViewController alloc] init];
    home.title = @"一登SDK功能列表";
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = homeNav;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
