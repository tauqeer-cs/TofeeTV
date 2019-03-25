//
//  CustomNavViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 24/03/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "CustomNavViewController.h"
#import "AppDelegate.h"
#import "Config.h"

@interface CustomNavViewController ()

@end

@implementation CustomNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    AppDelegate * destination = [[UIApplication sharedApplication] delegate];
    destination.navigation = self;
    
 
    
    
}

- (BOOL)shouldAutorotate
{
    AppDelegate * currentOne = [[UIApplication sharedApplication] delegate];
    
    
    BOOL tmp = [currentOne shouldAutoRotate];
    
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    AppDelegate * currentOne = [[UIApplication sharedApplication] delegate];
    if (currentOne.shouldAutoRotate)
    {
       // return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
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
