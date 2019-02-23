//
//  Quiz.m
//  TofeeTV
//
//  Created by Tauqeer Ahmed on 17/02/2019.
//  Copyright © 2019 Tauqeer. All rights reserved.
//

#import "Quiz.h"

@interface Quiz()

@end

@implementation Quiz

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

+(NSMutableArray *)parseItemFromResult:(id)items
{
    
    
    NSMutableArray * answerArray = [NSMutableArray new];
    
    Quiz * tmpCurrentQuiz;
    
    
    for (id currentItemShowing in items) {
        
        tmpCurrentQuiz = [Quiz new];
        
        NSLog(@"%@",currentItemShowing);
        
        tmpCurrentQuiz.itemId = [[currentItemShowing objectForKey:@"id"] intValue];
        tmpCurrentQuiz.isLocked = [[currentItemShowing objectForKey:@"is_locked"] boolValue];
        tmpCurrentQuiz.fileOwned = [[currentItemShowing objectForKey:@"is_owned"] boolValue];
        tmpCurrentQuiz.name = [currentItemShowing objectForKey:@"title"];
        
        tmpCurrentQuiz.itemColor = [self colors][tmpCurrentQuiz.itemId % [self colors].count ];
        
        
        [answerArray addObject:tmpCurrentQuiz];
        
        
        
        
        
        
    }
    
    return answerArray;
    
}

+(void)callQuiztionsListingWithComiltionHandler:(void(^)(id result))completionHandler
                              withFailueHandler:(void(^)(id error))failureHandler
{
    
    
    NSMutableArray * resultAnswer = [NSMutableArray new];
    
    /*
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
     */
    
    
    
    NSMutableDictionary * currentDictionary = [NSMutableDictionary new];
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"quizzes"]
                              isPostService:NO
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             id dataObject = [result objectForKey:@"data"];
             //NSMutableArray * resultToSend = [self parseTheSongsService:dataObject];
             
             NSMutableArray * resultToSend = [self parseItemFromResult:dataObject];
             [resultToSend addObjectsFromArray:resultToSend];
             [resultToSend addObjectsFromArray:resultToSend];
             [resultToSend addObjectsFromArray:resultToSend];
             
             
             completionHandler(resultToSend);
             
         }
         else
         {
             
             
             //[self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
}


+(void)callSubmitQuestionsWithQuestionId:(int)questionId
                      withAnswerSelected:(NSString *)answerSlected
                              withSongId:(int)songId
                        withComiltionHandler:(void(^)(id result))completionHandler
                              withFailueHandler:(void(^)(id error))failureHandler
{
    
    

    
    
    NSMutableDictionary * currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",songId] forKey:@"song_id"];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",questionId] forKey:@"question_id"];
    [currentDictionary setObject:answerSlected forKey:@"answer"];
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"quiz/insertAnswer"]
                              isPostService:YES
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             id dataObject = [result objectForKey:@"data"];
             //NSMutableArray * resultToSend = [self parseTheSongsService:dataObject];
             completionHandler(dataObject);
             
         }
         else
         {
             
             failureHandler(ErrorWhileLoadingData);
             
             
             //[self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
}



@end
