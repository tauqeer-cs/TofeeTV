//
//  Setting.h
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 6/28/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "BaseModel.h"

@class Lessons;


@interface Setting : BaseModel


+(void)getSettingsWithcomplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(id error))failureHandler;

@property (nonatomic,strong) NSString * benefits;
@property (nonatomic,strong) NSString * descriptionText;
@property (nonatomic,strong) NSString * getStarted;


@property (nonatomic,strong) id story;

@property (nonatomic,strong) Lessons * currentLesson;

@end
