//
//  Setting.m
//  Rohi Hayot
//
//  Created by Shehzad Bilal on 6/28/18.
//  Copyright © 2018 Grappetite. All rights reserved.
//

#import "Setting.h"
#import "Lessons.h"


@implementation Setting



+(Setting *)makeObjectFromDictionary:(NSDictionary *)dicationary
{
    
    
    Setting * currentSetting = [Setting new];
    
    currentSetting.descriptionText = [dicationary objectForKey:@"description"];
    currentSetting.getStarted = [dicationary objectForKey:@"get started"];
    
    currentSetting.benefits = [dicationary objectForKey:@"benefits"];
    currentSetting.story = [dicationary objectForKey:@"story"];
    
    
    
    Lessons  * currentLesson = [Lessons new];
    currentLesson.title = [currentSetting.story objectForKey:@"title"];
    currentLesson.imageUrl = [currentSetting.story objectForKey:@"mobile_image"];
    currentLesson.name = [currentSetting.story objectForKey:@"name"];

    currentLesson.thumbnail = [currentSetting.story objectForKey:@"thumbnail"];
    currentLesson.audioUrl = [currentSetting.story objectForKey:@"audio"];
    currentLesson.descriptionText = [currentSetting.story objectForKey:@"description"];
   
    currentSetting.currentLesson = currentLesson;
    
    
    

    return currentSetting;
    
    
}
+(void)getSettingsWithcomplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(id error))failureHandler
{
    
    
   //                  [[NSUserDefaults standardUserDefaults] setObject:checking forKey:@"Setting"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Setting"]) {
   
            completionHandler([Setting makeObjectFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Setting"]]);
    }
    
    [RestCall
     callWebServiceWithTheseParams:nil
     withSignatureSequence:nil
     urlCalling:[self makeURLCompleteFromString:@"settings"]
     isPostService:NO
     withComplitionHandler:^(id result) {
        
         NSLog(@"%@",result);
         

         

         
         


         if([[result allKeys] containsObject:@"status"] )
         {
             

             if ([[result objectForKey:@"status"] isEqualToString:@"success"])
             {
                

                 
                 id checking  = [result objectForKey:@"data"];
                 
                 Setting * objectSending =   [Setting makeObjectFromDictionary:checking];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:checking forKey:@"Setting"];
                 
                 
                 completionHandler(objectSending);
                 
                 
             }
             else
             {
                failureHandler([result objectForKey:@"msg"]);
                 
             }
             
            
             
             
         }
         else{
             
             failureHandler([result objectForKey:@"msg"]);
             
         }
         
         
         
    } failureComlitionHandler:^{
        
    }];
    
}
@end
