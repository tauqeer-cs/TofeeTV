//
//  ManuViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ManuViewController.h"

#import "ThankYouViewController.h"


@interface ManuViewController ()





@end

@implementation ManuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    [self showAllFonts];
   

    [self inititateTheAudioFile:@"Barish" withFileType:@"mp3" withOneTimePlay:NO];

}

-(void)viewDidAppear:(BOOL)animated
{
 
    [super viewDidAppear:animated];
    [self resumeFromPausedState];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
 
    [super viewDidDisappear:animated];
    
    
    [self pauseTheMusic];
    
}

- (IBAction)btnSongTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueSongsListing" sender:self];
    
}

- (IBAction)btnQuizTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueQuizzes" sender:self];
    
}

- (IBAction)btnSongsTapped:(UIButton *)sender {
    
    
    ThankYouViewController * destination  = [[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil];
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
