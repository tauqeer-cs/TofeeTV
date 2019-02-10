//
//  Song.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "Song.h"

@interface Song()


@property (nonatomic,strong) NSArray * colors;


@end

@implementation Song



+(NSArray *)colors
{
    
    return @[
             [UIColor colorWithRed:29.0/255.0 green:175.0/255.0 blue:236.0/255.0 alpha:1.0],
             [UIColor colorWithRed:245.0/255.0 green:147.0/255.0 blue:49.0/255.0 alpha:1.0],
             [UIColor colorWithRed:141.0/255.0 green:196.0/255.0 blue:72.0/255.0 alpha:1.0],
             [UIColor colorWithRed:240.0/255.0 green:89.0/255.0 blue:52.0/255.0 alpha:1.0],
             [UIColor colorWithRed:33.0/255.0 green:168.0/255.0 blue:156.0/255.0 alpha:1.0],
             [UIColor colorWithRed:235.0/255.0 green:40.0/255.0 blue:124.0/255.0 alpha:1.0],
             ];
}




+(void)callGiveMeSongsListWithComiltionHandler:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(id error))failureHandler
{
    
    
    NSMutableArray * resultAnswer = [NSMutableArray new];
    
    for (int i= 1; i < 13 ; i++)
    {
    
        Song * currentOne = [Song new];
        currentOne.name = [NSString stringWithFormat:@"Song %d",i];;
        currentOne.itemId = i;
        currentOne.itemColor = self.colors[i % self.colors.count ];
        
        if (i < 4) {
            currentOne.isLocked = NO;
            
        }
        else
        {
            currentOne.isLocked = YES;
        }
        
        [resultAnswer addObject:currentOne];
        
    }
    
    completionHandler(resultAnswer);
    
}
@end
