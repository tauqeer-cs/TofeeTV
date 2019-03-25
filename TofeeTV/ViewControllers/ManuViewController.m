//
//  ManuViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ManuViewController.h"
#import "AudioController.h"
#import "ThankYouViewController.h"


@interface ManuViewController ()
@property (strong, nonatomic) AudioController *audioController;


@property (nonatomic) BOOL isPaused;

@end

@implementation ManuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    [self showAllFonts];
   
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
}

-(void)viewDidAppear:(BOOL)animated
{
 
    [super viewDidAppear:animated];
    
    if (self.isPaused) {
        
        self.isPaused = NO;
        [self.audioController resumeIt];
        
        
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
 
    [super viewDidDisappear:animated];
    
    [self.audioController pauseIt];
    
    self.isPaused = YES;
    
    
}

- (IBAction)btnSongTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueSongsListing" sender:self];
    
}

- (IBAction)btnQuizTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueQuizzes" sender:self];
    
}

- (IBAction)btnSongsTapped:(UIButton *)sender {
    
    
   // [self performSegueWithIdentifier:@"segueMyScore" sender:self];
    ThankYouViewController * destination  = [[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil];
    
    //destination.currentQuestion = self.selectedSong;
    
    
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
