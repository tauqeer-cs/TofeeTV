//
//  AppDelegate.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 03/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AudioController.h"

@import GoogleMobileAds;

@interface AppDelegate ()
@property (nonatomic) BOOL isPaused;

@end

@implementation AppDelegate

-(void)pauseTheMusic{
    
    //[self resumeFromPausedState];
    [self.audioController pauseIt];
    self.isPaused = YES;
    
}

-(void)resumeFromPausedState{
    if (self.isPaused) {
        self.isPaused = NO;
        [self.audioController resumeIt];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    //App ID:

    //ca-app-pub-2522914220379856/3130957071 banner
   // [GADMobileAds configureWithApplicationID:@"ca-app-pub-4058691632572433~6497028034"];
    
     [GADMobileAds configureWithApplicationID:@"ca-app-pub-2522914220379856~9609747274"];
    [GADMobileAds sharedInstance];
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    //isFirstTimeSignUp
    id isFirstTimeRunDone = [currentUserDefault objectForKey:@"isFirstTimeSignUp"];
    if (!isFirstTimeRunDone)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
        UIViewController *initViewController;
        initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SignUpRoot"];
        self.window.rootViewController = initViewController;
    }
    

    
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return  UIInterfaceOrientationMaskAll;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
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
