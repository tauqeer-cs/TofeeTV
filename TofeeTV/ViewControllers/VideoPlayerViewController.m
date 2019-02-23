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


@end

@implementation VideoPlayerViewController
- (IBAction)btnQuizMeTapped:(UIButton *)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [FileManager loadVideoFromurl:self.currentSong.videoUrl
            withComplitionHandler:^(id item) {
                
                
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
