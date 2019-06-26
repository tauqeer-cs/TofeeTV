//
//  ThankYouViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ThankYouViewController.h"
#import "Song.h"
#import "XLCircleProgress.h"

@interface ThankYouViewController ()

@property (nonatomic) float obtainedPoints;
@property (nonatomic)float totalPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@property (weak, nonatomic) IBOutlet UIView *viewProgressContainr;

@property (nonatomic) float progressDone;


@end

@implementation ThankYouViewController
    XLCircleProgress *_circle;

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
                  
         self.obtainedPoints =  [[result objectForKey:@"obtained_points"] floatValue];
         self.totalPoints =  [[result objectForKey:@"total_points"] floatValue];
        
        float percentage =  ( self.obtainedPoints / self.totalPoints ) * 100;
                  
                  self.progressDone = percentage;
                  
            NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", percentage];

                  
        self.lblMessage.text = [NSString stringWithFormat:@"Thank you for Playing.\nYou have finished %@ percent of game ",formattedNumber];
                  
                  
                  [self addCircle];

                  
                  NSLog(@"%@",result);
    } withFailueHandler:^(id  _Nonnull error) {
        
        [self hideLoader];
        NSLog(@"");
        
    }];
    

}
-(void)addCircle
{

    _circle = [[XLCircleProgress alloc] initWithFrame:CGRectMake(0, 0, self.viewProgressContainr.frame.size.width, self.viewProgressContainr.frame.size.height)];
    [self.viewProgressContainr addSubview:_circle];
 
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIView transitionWithView:_circle
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            
                                _circle.progress = self.progressDone;
                            
                        }
                        completion:^(BOOL finished) {
                            
                            
                        }];
        
    });
}



-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}



-(void)goHome
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
