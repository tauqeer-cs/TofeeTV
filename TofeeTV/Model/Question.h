//
//  Question.h
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 7/3/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//


#import "ModelBase.h"

@interface Question : ModelBase


@property (nonatomic,strong) NSString * answer;
@property (nonatomic) int  questionId;
@property (nonatomic) int lessonId;
@property (nonatomic,strong) NSString * question;
@property (nonatomic,strong) NSString * subQuestion;

@property (nonatomic,strong) NSString * hintImage;

+(NSMutableArray *)listQuestionsWithArray:(NSArray*)questionList;


@property (nonatomic,strong) NSMutableArray * optionsArray;

@property (nonatomic,strong) NSString * questionType;

@property (nonatomic,strong) NSString * currentGivenAnswer;


+(void)callQuiztionsListingWithComiltionHandler:(void(^)(id result))completionHandler
                              withFailueHandler:(void(^)(id error))failureHandler;


@end
