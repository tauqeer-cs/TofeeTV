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
@property (weak, nonatomic) IBOutlet UIButton *btnBackBack;
@property (weak, nonatomic) IBOutlet UIButton *btnQuiz;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopBottom;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *topBottom;

@end

@implementation VideoPlayerViewController
- (IBAction)btnQuizMeTapped:(UIButton *)sender {
    
    
}
- (IBAction)btnBackBackTapped:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate * currentOne  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentOne.shouldAutoRotate = YES;

    self.btnQuiz.backgroundColor = DefaultYellowColor2;
    self.btnQuiz.layer.cornerRadius = 15;
    
    
    if (IS_IPad)
    {
        for (NSLayoutConstraint * currentOne in self.topBottom) {
            
            currentOne.constant = 40;
            
        }
    }
    
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

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
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
    AppDelegate * currentOne  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [currentOne resumeFromPausedState];
    
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
-(void)viewWillDisappear:(BOOL)animated
{
    
    AppDelegate * currentOne  = [[UIApplication sharedApplication] delegate];
    currentOne.shouldAutoRotate = NO;
    
    
    
    
}
- (BOOL)shouldAutorotate
{

    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    AppDelegate * currentOne = [[UIApplication sharedApplication] delegate];
    return UIInterfaceOrientationMaskLandscape;
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    [self showLoader];
    
    [FileManager loadVideoFromurl:self.currentSong.videoUrl
            withComplitionHandler:^(id item) {
                
                AppDelegate * currentOne  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [currentOne pauseTheMusic];
                
                
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
                [self.videoContainer.layer addSublayer:videoLayer];
                
                self.avPlayer.accessibilityFrame = self.videoContainer.frame;
                videoLayer.videoGravity = AVLayerVideoGravityResize;

                
                if(IS_IPad)
                {
                videoLayer.frame = [UIScreen mainScreen].bounds;
                videoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                videoLayer.videoGravity = AVLayerVideoGravityResize;
                    //this is
                    
                }
                

                [self.avPlayer play];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
                
                
                [self.view bringSubviewToFront:self.btnBackBack];
                
                
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

    
    [self dismissViewControllerAnimated:YES completion:^{
    
        [self.delegate quizTapped:self.currentSong];
        
    }];

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
