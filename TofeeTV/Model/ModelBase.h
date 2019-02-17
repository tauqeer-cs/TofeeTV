//
//  ModelBase.h
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 17/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestCall.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelBase : NSObject

+(NSString *)makeURLCompleteFromString:(NSString *)name;
+(BOOL)isSuccessFullWithDictionary:(id)result;
@end

NS_ASSUME_NONNULL_END
