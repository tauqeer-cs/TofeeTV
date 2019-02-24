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

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [Song callGetScoreWithId:self.currentQuestion.itemId
              withComplition:^(id  _Nonnull result) {
        
    } withFailueHandler:^(id  _Nonnull error) {
        
    }];
    

}


@end
