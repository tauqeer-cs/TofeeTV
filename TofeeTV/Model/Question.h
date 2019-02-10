//
//  Question.h
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 7/3/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "BaseModel.h"

@interface Question : BaseModel


@property (nonatomic,strong) NSString * answer;
@property (nonatomic) int  questionId;
@property (nonatomic) int lessonId;
@property (nonatomic,strong) NSString * question;
+(NSMutableArray *)listQuestionsWithArray:(NSArray*)questionList;




@end
