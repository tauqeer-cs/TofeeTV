//
//  ContactUsViewController.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 10/07/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@property (nonatomic,weak) NSString * emailUsing;
@end

@implementation ContactUsViewController

-(NSString *)emailUsing {
 
    return @"info@toffeetv.com";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.emailUsing);
    
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
