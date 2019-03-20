//
//  VideoPlayerViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 19/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "FileManager.h"
#import <AVFoundation/AVFoundation.h>
#import "QuestionViewController.h"
#import "Song.h"
#import "Question.h"


@interface VideoPlayerViewController ()

@property (nonatomic) AVPlayer *avPlayer;
@property (weak, nonatomic) IBOutlet UIView *videoContainer;

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;

@end

@implementation VideoPlayerViewController
- (IBAction)btnQuizMeTapped:(UIButton *)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}
- (IBAction)btnPauseTapped:(UIButton *)sender {
    
    if (sender.selected) {
        [self.avPlayer play];
        
    }
    else
    {
        [self.avPlayer pause];
        
        
    }
    
    [sender setSelected:!sender.selected];
    
    
}
- (IBAction)btnForwardTapped:(UIButton *)sender {
    
    //self.avPlayer forwardInvocation:<#(NSInvocation *)#>
    
   
    float playerCurrentTime = [self getCurrentTime];
    float newTime = playerCurrentTime + 2;

    CMTime time = CMTimeMake(newTime*1000, 1000);
    [self.avPlayer seekToTime:time completionHandler:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            // playerSliderisScrubbing = NO;
        });
    }];
    
    
}


- (IBAction)btnBackTapped:(UIButton *)sender {
    float playerCurrentTime = [self getCurrentTime];
    float newTime = playerCurrentTime - 2;
    
    if (newTime < 0) {
        newTime = 0;
        
        
    }
    
    CMTime time = CMTimeMake(newTime*1000, 1000);
    [self.avPlayer seekToTime:time completionHandler:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // playerSliderisScrubbing = NO;
        });
    }];
    
    
    
}

- (float)getCurrentTime {
    float seconds = 0;
    if (self.avPlayer) {
        seconds = CMTimeGetSeconds([self.avPlayer currentTime]);
    }
    return seconds;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showLoader];
    
    [FileManager loadVideoFromurl:self.currentSong.videoUrl
            withComplitionHandler:^(id item) {
                
                [self hideLoader];
                
                
                NSURL *vedioURL = item;
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory  error:nil];
                
                NSLog(@"files array %@", filePathsArray);
                NSString *fullpath;
                
                
                for ( NSString *apath in filePathsArray )
                {
                    fullpath = [documentsDirectory stringByAppendingPathComponent:apath];
                    vedioURL =[NSURL fileURLWithPath:fullpath];
                }
                
                NSLog(@"");
                
                
                
                
                
                
                NSURL *fileURL = [NSURL fileURLWithPath:item];
                self.avPlayer = [AVPlayer playerWithURL:fileURL];
                self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
                
                
                AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
                videoLayer.frame = self.videoContainer.frame;
                videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                [self.view.layer addSublayer:videoLayer];
                
                self.avPlayer.accessibilityFrame = self.view.frame;
                videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                videoLayer.frame = self.videoContainer.frame;
                

                [self.avPlayer play];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
                
                
                NSLog(@"");
                
                
            } withFailHander:^(int error) {
                
            }];
    
}
- (void)itemDidFinishPlaying:(NSNotification *)notification {
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero];
    
    [self.avPlayer pause];
    
    
    [self.btnPlay setSelected:!self.btnPlay.selected];
    
}

- (IBAction)quizMeTapped:(UIButton *)sender
{

    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    destination.questionIndex = 0;
    destination.selectedSong = self.currentSong;
    
    [self.navigationController showViewController:destination sender:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
