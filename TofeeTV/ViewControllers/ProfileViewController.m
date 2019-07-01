//
//  ProfileViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/06/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ProfileViewController.h"
#import "Song.h"
#import "XLCircleProgress.h"
@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewProgressContainr;

@property (nonatomic) float progressDone;
@property (nonatomic) float obtainedPoints;
@property (nonatomic)float totalPoints;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@end

@implementation ProfileViewController

- (IBAction)btnChangePasswordTapped:(UIButton *)sender {
    
    NSLog(@"");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"My Profile";
 
    
    self.txtName.text = self.myName;
    self.txtEmail.text = self.myEmail;
    
   // [self inititateTheAudioFile:@"App background loop" withFileType:@"wav" withOneTimePlay:NO];
    
    [self showLoader];
    
    [Song callGetScoreWithId:0
              withComplition:^(id  _Nonnull result) {
                  
                  [self hideLoader];
                  //obtained_points
                  
                  
                  //total_points
                  
                  self.obtainedPoints =  [[result objectForKey:@"obtained_points"] floatValue];
                  self.totalPoints =  [[result objectForKey:@"total_points"] floatValue];
                  
                  float percentage =  ( self.obtainedPoints / self.totalPoints ) * 100;
                  
                  self.progressDone = percentage;
                  
                  [self addCircle];
                  
                  
                  NSLog(@"%@",result);
              } withFailueHandler:^(id  _Nonnull error) {
                  
                  [self hideLoader];
                  NSLog(@"");
                  
              }];
}
 XLCircleProgress *_circle2;

-(void)addCircle
{
    
    _circle2 = [[XLCircleProgress alloc] initWithFrame:CGRectMake(0, 0, self.viewProgressContainr.frame.size.width, self.viewProgressContainr.frame.size.height)];
    [self.viewProgressContainr addSubview:_circle2];
    
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIView transitionWithView:_circle2
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            
                            _circle2.progress = self.progressDone;
                            
                        }
                        completion:^(BOOL finished) {
                            
                            
                        }];
        
    });
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
