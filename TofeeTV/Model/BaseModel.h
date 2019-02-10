//
//  BaseModel.h
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 6/28/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestCall.h"

@interface BaseModel : NSObject
+(NSString *)makeURLCompleteFromString:(NSString *)name;
+(BOOL)isSuccessFullWithDictionary:(id)result;

@end
