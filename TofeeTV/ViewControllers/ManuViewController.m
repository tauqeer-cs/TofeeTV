//
//  ManuViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ManuViewController.h"

@interface ManuViewController ()

@end

@implementation ManuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



    [self showAllFonts];
   
    
}


- (IBAction)btnSongTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueSongsListing" sender:self];
    
}

- (IBAction)btnQuizTapped:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"segueQuizzes" sender:self];
    
}

- (IBAction)btnSongsTapped:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"segueMyScore" sender:self];
    
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
