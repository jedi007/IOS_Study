//
//  AppDelegate.m
//  testUITabbarController
//
//  Created by dev on 2019/6/23.
//  Copyright © 2019 李杰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化一个tabBar控制器
    UITabBarController *tb = [[UITabBarController alloc]init];
    //设置UIWindow的rootViewController为UITabBarController
    self.window.rootViewController = tb;
    
    //创建相应的子控制器
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor greenColor];
    vc1.tabBarItem.title = @"首页";
    vc1.tabBarItem.image = [[UIImage imageNamed:@"home2"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    vc2.tabBarItem.title = @"分类";
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor redColor];
    vc3.tabBarItem.title = @"设置";
    
    //普通状态颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0],NSForegroundColorAttributeName, [UIFont systemFontOfSize:10.0],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    //选中的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255 green:73.0/255 blue:87.0/255 alpha:1.0],NSForegroundColorAttributeName, [UIFont systemFontOfSize:10.0],NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    //把子控制器添加到UITabBarController
    //[tb addChildViewController:c1];
    //[tb addChildViewController:c2];
    //或者
    tb.viewControllers = @[vc1,vc2,vc3];
    //[self.window makeKeyAndVisible];
    
    tb.tabBar.tintColor = [UIColor grayColor];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
