//
//  ThankYouViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ThankYouViewController.h"
#import "Song.h"

@interface ThankYouViewController ()

@property (nonatomic) int obtainedPoints;
@property (nonatomic) int totalPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.lblMessage.text = @"";
    
    [self showLoader];
    
    self.lblMessage.font =  [UIFont fontWithName:FancyFont size:28];
    if (self.currentQuestion) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    

    [Song callGetScoreWithId:self.currentQuestion.itemId
              withComplition:^(id  _Nonnull result) {
    
                  [self hideLoader];
                  //obtained_points
                  
                  
                  //total_points
                  
         self.obtainedPoints =  [[result objectForKey:@"obtained_points"] intValue];
         self.totalPoints =  [[result objectForKey:@"total_points"] intValue];
                  
    self.lblMessage.text = [NSString stringWithFormat:@"Thanks for Playing.\nYou scored %dout of %d",self.obtainedPoints,self.totalPoints];
                  
                  NSLog(@"%@",result);
    } withFailueHandler:^(id  _Nonnull error) {
        
        [self hideLoader];
        NSLog(@"");
        
    }];
    

}

-(void)goHome
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
