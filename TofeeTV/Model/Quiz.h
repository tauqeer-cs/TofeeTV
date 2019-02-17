//
//  Quiz.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 17/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//


#import "ModelBase.h"
#import "Question.h"
#import "Song.h"

NS_ASSUME_NONNULL_BEGIN

@interface Quiz : Song

+(void)callQuiztionsListingWithComiltionHandler:(void(^)(id result))completionHandler
                              withFailueHandler:(void(^)(id error))failureHandler;




@end

NS_ASSUME_NONNULL_END
