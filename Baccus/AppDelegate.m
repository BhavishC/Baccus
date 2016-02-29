//
//  AppDelegate.m
//  Baccus
//
//  Created by Bhavish Chandnani on 12/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "AppDelegate.h"
#import "BVCWineryModel.h"
#import "BVCWineryTableViewController.h"
#import "BVCWebViewController.h"
#import "BVCWineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (UIViewController *) rootViewControllerForPadWithModel:(BVCWineryModel *) wineryModel{
    
    // Creamos los controladores y los navigation
    BVCWineryTableViewController *wineryVC = [[BVCWineryTableViewController alloc]initWithModel:wineryModel style:UITableViewStylePlain];
    UINavigationController *wineryNavVC = [[UINavigationController alloc] initWithRootViewController: wineryVC];
    BVCWineViewController *wineVC = [[BVCWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    UINavigationController *wineNavVC = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    //Creamos el combinador: SplitView
    UISplitViewController *splitVC = [[UISplitViewController alloc]init];
    splitVC.viewControllers = @[wineryNavVC, wineNavVC];
    
    //Asignamos delegados
    splitVC.delegate=wineVC;
    wineryVC.delegate =wineVC;
    
    //Devolvemos el VC que se le asignar controlador raíz
    return splitVC;
}

- (UIViewController *) rootViewControllerForPhoneWithModel:(BVCWineryModel *) wineryModel{
    
    // Creamos los controladores y los navigation
    BVCWineryTableViewController *wineryVC = [[BVCWineryTableViewController alloc]initWithModel:wineryModel style:UITableViewStylePlain];
    UINavigationController *wineryNavVC = [[UINavigationController alloc] initWithRootViewController: wineryVC];
    wineryVC.delegate = wineryVC;
    
    return wineryNavVC;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	//Creamos el modelo
	BVCWineryModel *winery = [[BVCWineryModel alloc] init];
    
    //Configuración de controladores, combinadores y delegados en base al tipo de dispositivo
    UIViewController *rootVC =nil;
    if (!IS_IPHONE){
        rootVC = [self rootViewControllerForPadWithModel:winery];
    }else{
        rootVC = [self rootViewControllerForPhoneWithModel:winery];
    }
    
    self.window.rootViewController=rootVC;
	
	//self.window.backgroundColor = [UIColor whiteColor];
    [self customizeAppearance];
	[self.window makeKeyAndVisible];
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

-(void) customizeAppearance{
    
    UIColor *wineColor = [UIColor colorWithRed:120.0/255.0
                                green:10.0/255.0
                                 blue:10.0/255.0
                                alpha:1];
    UIColor *lightYellowColor= [UIColor colorWithRed:255.0/255.0
                                      green:250.0/255.0
                                       blue:160.0/255.0
                                      alpha:1];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Cochin-Bold" size:20], NSFontAttributeName,lightYellowColor, NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor: wineColor];
    
    [[UIBarButtonItem appearance] setTintColor:lightYellowColor];
    
}


@end
