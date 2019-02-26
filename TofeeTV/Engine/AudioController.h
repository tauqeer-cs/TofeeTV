//
//  AudioController.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 26/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioController : NSObject
- (instancetype)init;
- (void)tryPlayMusic;
- (void)playSystemSound;

-(void)pauseIt;

-(void)resumeIt;
@end

NS_ASSUME_NONNULL_END
