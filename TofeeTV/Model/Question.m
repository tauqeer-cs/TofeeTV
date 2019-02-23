//
//  Question.m
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 7/3/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "Question.h"

@implementation Question


+(Question *)makeQuestionFromDictionary:(NSDictionary *)question{
    
    Question * tmpQuesrtion = [Question new];
   
    
    tmpQuesrtion.answer = [question objectForKey:@"correct_answer"];
    tmpQuesrtion.question = [question objectForKey:@"title"];
   tmpQuesrtion.questionId =  [[question objectForKey:@"id"] intValue];
   tmpQuesrtion.lessonId =  [[question objectForKey:@"song_id"] intValue];
    
    tmpQuesrtion.optionsArray  = [NSMutableArray new];
    

    [tmpQuesrtion.optionsArray addObject:[question objectForKey:@"option1"]];
    [tmpQuesrtion.optionsArray addObject:[question objectForKey:@"option2"]];
    [tmpQuesrtion.optionsArray addObject:[question objectForKey:@"option3"]];
    [tmpQuesrtion.optionsArray addObject:[question objectForKey:@"option4"]];
    tmpQuesrtion.questionType = [question objectForKey:@"question_type"];
    
    tmpQuesrtion.subQuestion = @"What color are the bottles";
    tmpQuesrtion.currentGivenAnswer = [question objectForKey:@"answer"];
    
    
    return tmpQuesrtion;
    
}
+(NSMutableArray *)listQuestionsWithArray:(NSArray*)questionList
{
    
    NSMutableArray * tmpArray = [NSMutableArray new];
    
    for (id current in questionList)
    {
        [tmpArray addObject:[self makeQuestionFromDictionary:current]];
        
        
    }
    return tmpArray;
    
}

+(NSMutableArray *)parseItemFromResult:(id)items
{
    
    
    NSMutableArray * answerArray = [NSMutableArray new];
    
    
    for (id currentItem in items) {
        
        
        NSLog(@"%@",currentItem);
        
        
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
             
             
             
             
             completionHandler(dataObject);
             
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



@end
