//
//  AudioController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 26/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "AudioController.h"
@import AVFoundation;

@interface AudioController()<AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@property (assign) BOOL backgroundMusicPlaying;
@property (assign) BOOL backgroundMusicInterrupted;
@property (assign) SystemSoundID pewPewSound;

@end
@implementation AudioController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileName = @"Barish";
        self.fileType = @"mp3";
        [self configureAudioSession];
        [self configureAudioPlayer];
        [self configureSystemSound];
    }
    return self;
}

- (instancetype)initWithFileName:(NSString *)fileName withFileType:(NSString *)fileType
{
    self = [super init];
    if (self) {
        self.fileName = fileName;
        self.fileType = fileType;
        
        [self configureAudioSession];
        [self configureAudioPlayer];
        [self configureSystemSound];
    }
    return self;
}


- (void)tryPlayMusic {
    // If background music or other music is already playing, nothing more to do here
    if (self.backgroundMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
        return;
    }
    
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    self.backgroundMusicPlaying = YES;
}

-(void)pauseIt
{
    [self.backgroundMusicPlayer stop];
    
}

-(void)endIt{
    
    [self.backgroundMusicPlayer stop];
    
    
}
-(void)resumeIt
{
    [self.backgroundMusicPlayer play];
}

- (void)playSystemSound {
    AudioServicesPlaySystemSound(self.pewPewSound);
}
- (void) configureAudioSession {
    // Implicit initialization of audio session
    self.audioSession = [AVAudioSession sharedInstance];
    
    
    NSError *setCategoryError = nil;
    if ([self.audioSession isOtherAudioPlaying]) { // mix sound effects with music already playing
        [self.audioSession setCategory:AVAudioSessionCategorySoloAmbient error:&setCategoryError];
        self.backgroundMusicPlaying = NO;
    } else {
        [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    }
    if (setCategoryError) {
        NSLog(@"Error setting category! %ld", (long)[setCategoryError code]);
    }
}

- (void)configureAudioPlayer {
    // Create audio player with background music
    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:self.fileType];
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
    self.backgroundMusicPlayer.delegate = self;  // We need this so we can restart after interruptions
    self.backgroundMusicPlayer.numberOfLoops = -1;  // Negative number means loop forever
}

- (void)configureSystemSound {
//.
    NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:self.fileType];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &_pewPewSound);

}

-(void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {
    self.backgroundMusicInterrupted = YES;
    self.backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player withOptions:(NSUInteger) flags{
    
    [self tryPlayMusic];
    self.backgroundMusicInterrupted = NO;
}

@end
