//
//  CustomNavViewController2.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 24/03/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "CustomNavViewController2.h"
#import "VideoPlayerViewController.h"

@interface CustomNavViewController2 ()

@end

@implementation CustomNavViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    AppDelegate * currentApp = [[UIApplication sharedApplication] delegate];
    
    VideoPlayerViewController * destination = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
    destination.currentSong = currentApp.currentSelectedItem;
    [self initWithRootViewController:destination];

}

- (BOOL)shouldAutorotate
{
    
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{

    return UIInterfaceOrientationMaskLandscape;
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
