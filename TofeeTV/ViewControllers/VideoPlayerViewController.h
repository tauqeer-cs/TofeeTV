//
//  VideoPlayerViewController.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 19/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Song.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerViewController : BaseViewController

@property (nonatomic,strong) Song * currentSong;

@end

NS_ASSUME_NONNULL_END
