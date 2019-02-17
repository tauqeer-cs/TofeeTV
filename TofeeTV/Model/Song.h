//
//  Song.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseModel.m"
#import "ModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface Song : ModelBase


@property (nonatomic,strong) NSString * name;
@property (nonatomic) int itemId;
@property (nonatomic) BOOL isLocked;
@property (nonatomic,strong) UIColor * itemColor;
@property (nonatomic) BOOL fileOwned;
@property (nonatomic,strong) NSString * thumbNailUrl;

@property (nonatomic,strong) NSString * videoUrl;

@property (nonatomic,strong) NSString * inAppPurchaseId;
+(void)callGiveMeSongsListWithComiltionHandler:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(id error))failureHandler;



@end

NS_ASSUME_NONNULL_END
