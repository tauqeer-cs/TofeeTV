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
    tmpQuesrtion.answer = [question objectForKey:@"answer"];
    tmpQuesrtion.question = [question objectForKey:@"question"];
   tmpQuesrtion.questionId =  [[question objectForKey:@"id"] intValue];
   tmpQuesrtion.lessonId =  [[question objectForKey:@"lesson_id"] intValue];
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
@end
