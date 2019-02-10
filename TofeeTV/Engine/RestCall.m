 

//
//  RestCall.m
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "RestCall.h"
#import "JSONKit.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"
#import "DateFormatter.h"
#import "XMLDictionary.h"
#import "AppDelegate.h"
#import "Config.h"


@implementation RestCall


+(NSDictionary *)makeObjectFromJSON:(NSString *)extra{
    
    NSDictionary *JSON;
    JSON = [NSJSONSerialization JSONObjectWithData: [extra dataUsingEncoding:NSUTF8StringEncoding]
                                           options: NSJSONReadingMutableContainers
                                             error: nil];
    
    
    
    return JSON;
}
+(NSString *)encodeToJSONStringFromArray:(NSArray *)array{
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

+(NSString *)encodeToJSONStringFromString:(NSString *)array{
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)encodeToJSONStringFromDictionary:(NSDictionary *)dictionary{
    

    NSError *error;
    
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    
    

    
    return [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
}

+(NSString *)makeSignatureWithGivenFullString:(NSString *)fullString
{

    return @"";
}

+(NSString *)makeSignatureWithGivenDictionary:(NSDictionary *)params withKeyArray:(NSArray *)keys
{
    return @"";
}



-(NSString *)convertArrayToString:(NSArray *)array{
    
    NSString *fullString = @"";
    
    if([array count] == 0)
        return @"";
    
    for (NSString *currentString in array) {
        fullString = [fullString stringByAppendingString:currentString];
        fullString = [fullString stringByAppendingString:@","];
        
    }
    fullString = [fullString substringToIndex:fullString.length - 1];
    
    return fullString;
    
}













+(NSString *)authToken{
    
    NSUserDefaults * myDefault =  [NSUserDefaults standardUserDefaults];
   id c =  [myDefault objectForKey:@"access_token"];
    
    if ([c isKindOfClass:[NSString class]]) {
        
        NSString * accessToken = c ;
        
        
        
        
        return [NSString stringWithFormat:@"%@",accessToken];
        
    }
    return @"";
}


+(void)serviceCallWithParams:(NSDictionary *)params withImage:(UIImage *)image withUrl:(NSString *)url isPost:(BOOL)post withImageParamName:(NSString *)imageParam
       withComplitionHandler:(void(^)(id result))completionHandler
     failureComlitionHandler:(void(^)(void))failureCompletionHandler
{
    
 
    

    
    NSData *imageData;
    
    if (image)
    {
        
        imageData = UIImageJPEGRepresentation(image, 1.0);
        
    }
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:url
                                                                                             parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  if (imageData) {
                                                                                                      
                                                                                                      [formData appendPartWithFileData:imageData name:imageParam fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                                                                                      
                                                                                                      
                                                                                                  }
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  NSLog(@"");
                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[RestCall authToken] forHTTPHeaderField:@"Authorization"];
    
    
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //[progressView setProgress:uploadProgress.fractionCompleted];
                          
                          //  NSLog(@"%@",uploadProgress.fractionCompleted);
                          
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                                                                                      completionHandler(responseObject);
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          
                       //   completionHandler(nil);
                          
                          
                      }

                  }];
    
    [uploadTask resume];

    
    
    
    
}


+(void)callWebServiceWithTheseParams:(NSDictionary *)params
               withSignatureSequence:(NSArray *)paramSeguence
                          urlCalling:(NSString *)url isPostService:(BOOL)isPost
               withComplitionHandler:(void(^)(id result))completionHandler failureComlitionHandler:(void(^)(void))failureCompletionHandler
{
    

    
    NSMutableArray *paramSet = [NSMutableArray new];
    [paramSet setArray:paramSeguence];
    

    
    NSString *tmpPostString = @"";
    
    for (id currentItem in params) {
        
        
        if ([[params objectForKey:currentItem] isKindOfClass:[NSArray class]]) {
        
            
            
            int i = 0;
            
            for (NSString * tmp22 in [params objectForKey:currentItem]) {

                NSLog(@"");
                tmpPostString = [tmpPostString stringByAppendingString:currentItem];
                tmpPostString = [tmpPostString stringByAppendingString:@"="];
                
                
                tmpPostString = [tmpPostString stringByAppendingString:tmp22];
                tmpPostString = [tmpPostString stringByAppendingString:@"&"];
                
                
                
                i++;
                
            }
        }
        else {
         
            tmpPostString = [tmpPostString stringByAppendingString:currentItem];
            tmpPostString = [tmpPostString stringByAppendingString:@"="];
            
            tmpPostString = [tmpPostString stringByAppendingString:[params objectForKey:currentItem]];
            tmpPostString = [tmpPostString stringByAppendingString:@"&"];
            
            
        }
    }
    
    if (tmpPostString.length > 0) {
        
        tmpPostString = [tmpPostString substringToIndex:[tmpPostString length] - 1];
    
        
    }

    NSString *postString = tmpPostString;
    

    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //request2.timeoutInterval = 30;
    
    if ([url containsString:@"getMerchantProducts"])
    {
        request2.timeoutInterval = 10;
    }
    else if ([url containsString:@"getMerchantProductsBySearch"])
    {
        request2.timeoutInterval = 10;
    }
    
    
    if (isPost) {
        [request2 setHTTPMethod:@"POST"];
        
    }
    else{
        [request2 setHTTPMethod:@"GET"];
        id stringToSend = [[url stringByAppendingString:@"?"] stringByAppendingString:tmpPostString];
        if ([stringToSend containsString:@" "]) {
            stringToSend =[stringToSend stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        }
        request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringToSend]];
    }

    
    NSString *headerString = [RestCall authToken];
    
    if (headerString) {
        
        postString = [postString stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        
        [request2 setValue:headerString forHTTPHeaderField:@"Authorization"];

        
        
    }
    
            [request2 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
 
    if (isPost) {
        
        [request2 setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

    }

    
    

    
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
        if (!data) {
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            failureCompletionHandler();
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",newStr);
            return;
        }
                               
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
                                   
                                   
                                   if ([[dictionary allKeys] containsObject:@"msg"]) {
                                       NSString * currentString = [dictionary objectForKey:@"msg"];
                                       
                                       if ([currentString isEqualToString:@"invalid token"])
                                       {
                                           
                                           
                                           AppDelegate * currentApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                          
                                           //[currentApp takeUserToLoginScreen];
                                           
                                           
                                           
                                           
                                           return;
                                       }
                                   }
        }
                               
        
        if (!dictionary) {
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            failureCompletionHandler();
            NSLog(@"%@",newStr);
            return;
        }
                               
        completionHandler([dictionary dictionaryByReplacingNullsWithBlanks]);
        
        
    }];
    
    
    
}

-(void)callWebServiceWithTheseParams:(NSMutableDictionary *)params withSignatureSequence:(NSArray *)paramSeguence urlCalling:(NSString *)url withComplitionHandler:(void(^)(id result))completionHandler
{
    
    [params setValue:[RestCall makeSignatureWithGivenDictionary:params withKeyArray:paramSeguence]
              forKey:@"signature"];
    
    NSDictionary *jsonDictionary = params;
    
    
    NSError *error;
    NSData *httpBody = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
    NSAssert(httpBody, @"dataWithJSONObject error: %@", error);
    
    
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request2 setHTTPMethod:@"POST"];
    [request2 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request2 setHTTPBody:httpBody];
    
    NSString *sending = [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",sending);
    
    
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            
            NSLog(@"sendAsynchronousRequest error: %@", connectionError);
            [self.delegate connectionErrorDelegate];
            return;
        }
        
        
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        completionHandler([dictionary dictionaryByReplacingNullsWithBlanks]);
        
    }];
    
    
    
}






- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"timed out");
    
}









-(void)processParsedObject:(id)object{

    [self processParsedObject:object depth:0 parent:nil];

}

-(void)processParsedObject:(id)object depth:(int)depth parent:(id)parent{
    
    if([object isKindOfClass:[NSDictionary class]]){
        
        for(NSString * key in [object allKeys]){
            id child = [object objectForKey:key];
            [self processParsedObject:child depth:depth+1 parent:object];
        }
        
        
    }else if([object isKindOfClass:[NSArray class]]){
        
        for(id child in object){
            [self processParsedObject:child depth:depth+1 parent:object];
        }
        
    }
    else{
        //This object is not a container you might be interested in it's value
        
    
        if ([object isKindOfClass:[NSNull class]]) {
            
            
            object = nil;
            
        }
        
    
    }
    
    
}










@end
