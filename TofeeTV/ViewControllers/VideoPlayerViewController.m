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


@interface VideoPlayerViewController ()

@property (nonatomic) AVPlayer *avPlayer;


@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    


    

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
                


                
                
                NSString *filepath = [[NSBundle mainBundle] pathForResource:item ofType:nil inDirectory:@"CoverImages"];
                
                NSURL *fileURL = [NSURL fileURLWithPath:item];
                self.avPlayer = [AVPlayer playerWithURL:fileURL];
                self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
                
                
                AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
                videoLayer.frame = self.view.bounds;
                videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                [self.view.layer addSublayer:videoLayer];
                
                [self.avPlayer play];
                
                NSLog(@"");
                
                
    } withFailHander:^(int error) {
        
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
