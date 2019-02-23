//
//  ThankYouViewController.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class Song;

@interface ThankYouViewController : BaseViewController

@property (nonatomic,strong) Song * currentQuestion;

@end

NS_ASSUME_NONNULL_END
