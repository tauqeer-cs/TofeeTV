//
//  CustomViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 20/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(BOOL)shouldAutorotate
{
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.topViewController shouldAutorotate];
    }
    else {
        return YES;
    }
}


-(NSUInteger) supportedInterfaceOrientations {
    if([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
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
