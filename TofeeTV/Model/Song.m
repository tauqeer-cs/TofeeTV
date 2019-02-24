//
//  Song.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 06/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "Song.h"
#import "RestCall.h"
#import "Question.h"

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




+(NSMutableArray *)parseTheSongsService:(id)item
{
    
    NSMutableArray * resultArray = [NSMutableArray new];
    
    
    Song * tmpCurrentSong;
    
    for (id currentItemShowing in item) {
        tmpCurrentSong  = [Song new];
        
        
        tmpCurrentSong.itemId = [[currentItemShowing objectForKey:@"id"] intValue];
        tmpCurrentSong.name = [currentItemShowing objectForKey:@"title"];
        tmpCurrentSong.isLocked = [[currentItemShowing objectForKey:@"is_locked"] boolValue];
        
        tmpCurrentSong.inAppPurchaseId = [currentItemShowing objectForKey:@"in_app_purchase_ios"];
        tmpCurrentSong.fileOwned = [[currentItemShowing objectForKey:@"is_owned"] boolValue];
        
        tmpCurrentSong.thumbNailUrl = [currentItemShowing objectForKey:@"thumbnail_file"];
        //tmpCurrentSong.thumbNailUrl = @"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg";
        
        //
        tmpCurrentSong.videoUrl = [currentItemShowing objectForKey:@"video_file"];
        //tmpCurrentSong.videoUrl = @"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
        
        
        tmpCurrentSong.itemColor = self.colors[tmpCurrentSong.itemId % self.colors.count ];
        
        id answerArray = [Question listQuestionsWithArray:[currentItemShowing objectForKey:@"questions"]];
        
        tmpCurrentSong.myQuestions = answerArray;
        
        NSLog(@"");
        
        
        [resultArray addObject:tmpCurrentSong];
        
        
        
        
    }
    
    return resultArray;
    
}

+(void)callGiveMeSongsListWithComiltionHandler:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(id error))failureHandler
{
    
    
    NSMutableArray * resultAnswer = [NSMutableArray new];
    
  
    
    
    
    NSMutableDictionary * currentDictionary = [NSMutableDictionary new];
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"songs"]
                              isPostService:NO
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             id dataObject = [result objectForKey:@"data"];
             NSMutableArray * resultToSend = [self parseTheSongsService:dataObject];
             [resultToSend addObjectsFromArray:resultToSend];
             [resultToSend addObjectsFromArray:resultToSend];
             [resultToSend addObjectsFromArray:resultToSend];
             
             
             completionHandler(resultToSend);
             
         }
         else
         {
             
             
            // [self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
}


+(void)callGetScoreWithId:(int)songId
           withComplition:(void(^)(id result))completionHandler
                             withFailueHandler:(void(^)(id error))failureHandler
{
    
    
    

    
    
    
    
    NSMutableDictionary * currentDictionary = [NSMutableDictionary new];
    
    if (songId > 0)
    {
        
        
        
        [currentDictionary setObject:[NSString stringWithFormat:@"%d",songId] forKey:@"song_id"];
        
        
    }
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"user/score"]
                              isPostService:NO
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             id dataObject = [result objectForKey:@"data"];
             NSMutableArray * resultToSend = [self parseTheSongsService:dataObject];
             
             
             completionHandler(resultToSend);
             
         }
         else
         {
             
             
             // [self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
}







@end
