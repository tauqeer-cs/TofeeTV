//
//  QuestionViewController.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 23/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Song;

NS_ASSUME_NONNULL_BEGIN

@interface QuestionViewController : BaseViewController

@property (nonatomic) int questionIndex;

@property (nonatomic,strong) Song * selectedSong;

@end

NS_ASSUME_NONNULL_END
