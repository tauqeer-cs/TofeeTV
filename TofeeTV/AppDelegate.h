//
//  AppDelegate.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 03/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  AudioController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL shouldAutoRotate;

@property (nonatomic) id currentSelectedItem;
@property (nonatomic,strong) id navigation;

@property (nonatomic,strong) AudioController * audioController;
-(void)pauseTheMusic;

-(void)resumeFromPausedState;

@end

