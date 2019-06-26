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
@property (weak, nonatomic) IBOutlet UILabel *lblGame;

@end

@implementation SelectSongOrGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Select option";
    [self setTouchMethodWithLabel:self.lblSong withSelector:@selector(songItemTapped)];
    [self setTouchMethodWithLabel:self.lblGame withSelector:@selector(gameLabelTapped)];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void)gameLabelTapped {
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    destination.questionIndex = 0;
    destination.selectedSong = self.objectComing;
    
    [self.navigationController showViewController:destination sender:nil];
    
    
}
-(void)songItemTapped {
    
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
    
    
    QuestionViewController * destination = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    destination.questionIndex = 0;
    destination.selectedSong = itemTapped;
    [self.navigationController showViewController:destination sender:nil];
    
    
}




@end
