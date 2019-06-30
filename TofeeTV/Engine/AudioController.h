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

@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,strong) NSString * fileType;

- (instancetype)initWithFileName:(NSString *)fileName withFileType:(NSString *)fileType withOneTimePlay:(BOOL)oneTime;


@end

NS_ASSUME_NONNULL_END
