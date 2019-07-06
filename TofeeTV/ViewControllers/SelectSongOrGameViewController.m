//
//  SelectSongOrGameViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 22/06/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "SelectSongOrGameViewController.h"
#import "Song.h"
#import "VideoPlayerViewController.h"
#import "QuestionViewController.h"

@interface SelectSongOrGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *lblSong;
@property (weak, nonatomic) IBOutlet UIButton *btnSong;

@property (weak, nonatomic) IBOutlet UIButton *btnGame;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *distanceFromSides;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfView;

@end

@implementation SelectSongOrGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Select option";
    
    
    
    
    self.request = [GADRequest request];
    self.request.testDevices = @[ @"f2d702823400817844a80703be06886b" ,@"4f2b62a930ebbb22ac092b428fb74a67",@"4fb9829edac4b523686799880a3fea36",@"35cbf4628e8467f7c7bbb209f6a9b681",kGADSimulatorID];
    
    self.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-1949777708516294/9068499910"];
    
    self.interstitial.delegate = self;
    
    [self.interstitial loadRequest:self.request];
    [self.interstitial presentFromRootViewController:self];
    
    
    [self.btnGame.titleLabel setFont:self.lblSong.font];
    self.btnGame.backgroundColor = DefaultYellowColor2;
    self.btnGame.layer.cornerRadius = 40;
    [self.btnGame setTitle:@"Game" forState:UIControlStateNormal];
    
    [self.btnSong.titleLabel setFont:self.lblSong.font];
    self.btnSong.backgroundColor = DefaultYellowColor2;
    self.btnSong.layer.cornerRadius = 40;
    [self.btnSong setTitle:@"Song" forState:UIControlStateNormal];
    
    
    
    if (IS_IPad)
    {
    
        for (NSLayoutConstraint * currentItem in self.distanceFromSides) {
        
            currentItem.constant = 48;
            
        }
        
        self.heightOfView.constant = 180+24;
        
    }

    
    //btnFeedback.layer.cornerRadius  = 25;
    
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
    [ad presentFromRootViewController:self];
    
    NSLog(@"");
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    
    NSLog(@"");
}


-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void)gameLabelTapped {
    [self buttonBlip];
    
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:self.questionViewControllerName bundle:nil];
    
    destination.questionIndex = 0;
    destination.selectedSong = self.objectComing;
    
    [self.navigationController showViewController:destination sender:nil];
    
    
}
- (IBAction)btnGameTapped:(id)sender {
    [self gameLabelTapped];
    
}

- (IBAction)btnSongTapped:(id)sender {
    [self songItemTapped];
    
}
-(void)songItemTapped {
    
    [self buttonBlip];
    
    
    AppDelegate * currentOne  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentOne.shouldAutoRotate = YES;
    
    
    
    VideoPlayerViewController * destination = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
    
    AppDelegate * currentApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentApp.currentSelectedItem = self.objectComing;
    destination.currentSong = self.objectComing;
    
    destination.delegate = self;
    
    [self presentViewController:destination animated:YES completion:^{
    }];

}


-(void)quizTapped:(id)itemTapped
{
    
    [self buttonBlip];
    
    
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:self.questionViewControllerName bundle:nil];
    destination.questionIndex = 0;
    destination.selectedSong = itemTapped;
    [self.navigationController showViewController:destination sender:nil];
    
    
}




@end
