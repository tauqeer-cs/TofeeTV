//
//  AboutUsViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 10/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtView.text = @"ToffeeTV is an animation studio where we develop songs, stories and services in multiple languages. Founders Talea Zafar and Rabia Garib started ToffeeTV as a resource for schools and parents around the world as a fun learning tool to learn concepts and languages. Song videos and quizzes will continuously be updated.\n\nThis app, Singalong with ToffeeTV, is a resource to learn through songs. While the app is free, the paid version is a monthly subscription that allows you to download the videos and use the app without ads.\n\nWe would love to hear from you - tell us what we can do better or how you use our songs in your school or home. Stay connected with us through our website at toffeetv.com and through social media!";
    
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
