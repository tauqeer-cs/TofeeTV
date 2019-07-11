//
//  User.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/15/16.
//  Copyright © 2016 Plego. All rights reserved.//

#import "User.h"
#import "RestCall.h"
#import "Config.h"
#import "AppDelegate.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"
#import "DateFormatter.h"


@implementation User






+(NSString *)myJid{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([[userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"id"];
    }
    return [[userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"id"];
    
}







+(User *)parseUserData:(id)currentUser
{
    
    User * resultUser = [User new];
    
    resultUser.email = [currentUser objectForKey:@"email"];
    resultUser.status = [currentUser objectForKey:@"friend_status"];
    resultUser.userId = [[currentUser objectForKey:@"id"] intValue];
    resultUser.name = [currentUser objectForKey:@"name"];
    resultUser.firstName = [currentUser objectForKey:@"first_name"];
    resultUser.lastName = [currentUser objectForKey:@"last_name"];
    resultUser.profileImageUrl = [currentUser objectForKey:@"profile_image_url"];
    
    return resultUser;
    
    
}






+ (void)Failure:(void (^)(id))failureHandler result:(id)result {
    NSDictionary * data = [result objectForKey:@"data"];
    if (data) {
        
        NSLog(@"%@",data);
        
        NSMutableArray * tmpAllMessages = [NSMutableArray new];
        
        
        if ([data isKindOfClass:[NSArray class]])
        {
            if ([data count] == 0) {
                
                failureHandler(@"");
                return;
                
                
            }
            
        }
        else if([data isKindOfClass:[NSString class]])
        {
            return      failureHandler(data);;
        }
        for (id currentKey in [data allKeys])
        {
            
            if ([[data objectForKey:currentKey] isKindOfClass:[NSArray class]]) {
                
                [tmpAllMessages addObject:[[data objectForKey:currentKey] firstObject]];
            }
            else
                [tmpAllMessages addObject:[data objectForKey:currentKey]];
            
        }
        
        NSLog(@"%@",tmpAllMessages);
        
        NSString *myString = [tmpAllMessages componentsJoinedByString:@","]; //instead of [myArray description];
        
        failureHandler(myString);
        
        
        
        return;
        
    }
    failureHandler([result objectForKey:@"msg"]);
}
//logout

+(void)callLogouWithComplitionHandler:(void(^)(id result))completionHandler
    withFailueHandler:(void(^)(id error))failureHandler
withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*
    if (!appDelegate.tokenToSend) {
        
            [currentDictionary setObject:@"" forKey:@"token"];
    }
    else
    {
            [currentDictionary setObject:appDelegate.tokenToSend forKey:@"token"];
    }*/
    

    [currentDictionary setObject:@"iOS" forKey:@"device_type"];
    
        NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"logout"]
                              isPostService:YES
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             
             
             
             id dataObject = [result objectForKey:@"data"];
             
             
             [defauls setObject:nil forKey:@"isFirstTimeSignUp"];
             
             [defauls setObject:nil forKey:@"access_token"];
             
             
             completionHandler(dataObject);
             
         }
         else
         {
             
             
             [self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}


+(void)callAddPushIds:(int)userId
           withComplitionHandler:(void(^)(id result))completionHandler
               withFailueHandler:(void(^)(id error))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [currentDictionary setObject:@"" forKey:@"token"];
        [currentDictionary setObject:@"iOS" forKey:@"device_type"];
        [currentDictionary setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"device_id"];
    
    

    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"storePushToken"]
                              isPostService:YES
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             
             NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
             [defauls setObject:@"1" forKey:@"pushTokenHasBeenSaved"];
             
             id dataObject = [result objectForKey:@"data"];
             
             

             completionHandler(dataObject);
             
         }
         else
         {
             
             
             [self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}

+(void)callEditUserWithEmail:(NSString *)emailAddress
                        withName:(NSString *)name
                withLastName:(NSString *)lastName
                       withImage:(UIImage *)profileImage
           withComplitionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    if (emailAddress)
    {
        [currentDictionary setObject:emailAddress forKey:@"email"];
    }
    
    if (name) {
        [currentDictionary setObject:name forKey:@"first_name"];
        
        
    }
    
    if (lastName)
    {
        [currentDictionary setObject:lastName forKey:@"last_name"];
    }
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    NSData *imageData;
    
    if (profileImage)
    {
        
        imageData = UIImageJPEGRepresentation(profileImage, 1.0);
        
    }
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[self makeURLCompleteFromString:@"updateProfile"] parameters:currentDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  if (imageData) {
                                                                                                      
                                                                                                      [formData appendPartWithFileData:imageData name:@"profile_image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                                                                                      
                                                                                                      
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
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          alreadyExistHandler(@"Already exists");
                          
                      }
                      else
                          if (error) {
                              NSLog(@"Error: %@", error);
                              
                              failureHandler();
                              
                          } else {
                              if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                                  id dataObject = [responseObject objectForKey:@"data"];
                                  dataObject = [dataObject dictionaryByReplacingNullsWithBlanks];
                                  [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                                  
                                  AppDelegate * currentDelegate = [[UIApplication sharedApplication] delegate];
                                  
                                  completionHandler(dataObject);
                                  
                                  
                                  
                                  
                                  //
                              }
                              else {
                                  
                                  
                              }
                              
                          }
                  }];
    
    [uploadTask resume];
    
}


+(void)callRegisterUserWithEmail:(NSString *)emailAddress
                        withFirstName:(NSString *)firstName
                    withLastName:(NSString *)lastName
                    withPassword:(NSString *)password
                       withImage:(UIImage *)profileImage
           withComplitionHandler:(void(^)(id result))completionHandler
               withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:emailAddress forKey:@"email"];
    [currentDictionary setObject:firstName forKey:@"name"];
    [currentDictionary setObject:password forKey:@"password"];
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    
    
    

    

    NSData *imageData;
    
    if (profileImage)
    {
    
        imageData = UIImageJPEGRepresentation(profileImage, 1.0);
    
    }
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:[self makeURLCompleteFromString:@"register"] parameters:currentDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                                  
                                                                                                  if (imageData) {
                                                                                                      
                                                                                                      [formData appendPartWithFileData:imageData name:@"profile_image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                                                                                      
                                                                                                      
                                                                                                  }
                                                                                                  
                                                                                                  
                                                                                                  
                                                                                                  NSLog(@"");
                                                                                                  
                                                                                                  
                                                                                              } error:nil];
    
    
    
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
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
                      
                      if ([[responseObject objectForKey:@"code"] intValue] == 409) {
                          
                          alreadyExistHandler(@"Already exists");
                          
                      }
                      else
                          if (error) {
                              NSLog(@"Error: %@", error);
                              
                              if ([[responseObject allKeys]  containsObject:@"message"])
                              {
                                  id responseObjectTo =  [responseObject objectForKey:@"message"];
                                  
                                  if ([responseObjectTo isKindOfClass:[NSDictionary class]])
                                  {
                                      
                                      alreadyExistHandler([responseObjectTo objectForKey:[[responseObjectTo allKeys] firstObject]]);
                                      
                                      
                                      return;
                                      
                                  }
                                  else
                                  {
                                      failureHandler();
                                      return;
                                      
                                      
                                  }
                                  NSLog(@"");
                                  
                              }
                              else
                              {
                                  failureHandler();
                                  
                                  return;
                              }

                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                              
                              if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  id dataObject = [responseObject objectForKey:@"data"];
                                  
                                  
                                  dataObject = [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  //dataObject =  [dataObject dictionaryByReplacingNullsWithBlanks];
                                  
                                  //
                                  
                                  
                                  
                                  
                                  [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                                  [defauls setObject:[responseObject objectForKey:@"access_token"] forKey:@"access_token"];
                                  
                                  AppDelegate * currentDelegate = [[UIApplication sharedApplication] delegate];
                                  
                                  completionHandler(dataObject);
                                  
                                  
                                  return;
                                  
                                  
                                  
                                  //
                              }
                              else {
                                  
                                  failureHandler();
                                  
                                  
                              }
                              
                          }
                  }];
    
    [uploadTask resume];
    
}

+(void)callRegisterUserWithSocial:(NSString *)socialToken
           withComplitionHandler:(void(^)(id result))completionHandler
               withFailueHandler:(void(^)(id error))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:socialToken forKey:@"token"];
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"loginBySocialite"]
                              isPostService:YES
                      withComplitionHandler:^(id result)
     {
         
         
         
         if ([self isSuccessFullWithDictionary:result]) {
             
             
             
             
             id dataObject = [result objectForKey:@"data"];
             dataObject = [dataObject dictionaryByReplacingNullsWithBlanks];
             [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
             [defauls setObject:[result  objectForKey:@"access_token"] forKey:@"access_token"];
             [defauls setObject:@"1" forKey:@"isFbLogin"];
             
             
             
             completionHandler(dataObject);
             
         }
         else
         {
             
             
             [self Failure:failureHandler result:result];
             
             
         }
         
         
         
     }
                    failureComlitionHandler:^{
                        
                        failureHandler(ErrorWhileLoadingData);
                        
                    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}


+(void)callContactUs:(NSString *)subject
                         withMessage:(NSString *)message
                   withComplitionHandler:(void(^)(id result))completionHandler
                       withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:subject forKey:@"phone"];
    [currentDictionary setObject:message forKey:@"message"];
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"contactus"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  completionHandler(@"success");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(@"failed");
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}



+(void)callSearchFriends:(NSString *)searchName
withComplitionHandler:(void(^)(id result))completionHandler
   withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:searchName forKey:@"search_query"];
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"searchFriends"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                        id message = [result objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  
                                  
                              
                                  NSMutableArray * resultData = [NSMutableArray new];
                                  
                                  
                                  for (id currentData in [result objectForKey:@"data"]) {
                                      
                                      if ([[currentData objectForKey:@"friend_status"] isEqualToString:@"Pending"]) {
                                          
                                      }
                                      else if ([[currentData objectForKey:@"friend_status"] isEqualToString:@"Accepted"]) {
                                          
                                      }
                                      else
                                      [resultData addObject:[self parseUserData:currentData]];
                                      
                                  }
                                  
                                  
                                  
                                  completionHandler(resultData);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(@"failed");
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}



+(void)callChangePasswordWithOldPassword:(NSString *)oldPassword
                         withNewPassword:(NSString *)newPassword
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(id result))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:oldPassword forKey:@"current_password"];
    [currentDictionary setObject:newPassword forKey:@"password"];
    
    

    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
[self makeURLCompleteFromString:@"update/password"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  completionHandler(@"success");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"error"]){
                                  
                                  
                                  
                                  failureHandler([result objectForKey:@"message"]);
                                  
                              }
                              else{
                                  
                                  failureHandler(@"Error while procress request");
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler(@"Error while procress request");
                              
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler(@"Error while procress request");
                          
                          
                      }];
}

+(void)callForgetAccount:(NSString *)email
withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:email forKey:@"email"];
    
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:forgotPassword]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  
        
                                  completionHandler(@"yes");
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){


                                  completionHandler([result objectForKey:@"message"]);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}


+(void)callUnFriendWithFriendId:(int)friendId
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",friendId] forKey:@"user_id"];
    
    
    
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"deleteFriend"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  
                                  
                                  completionHandler([result objectForKey:@"msg"]);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler([result objectForKey:@"msg"]);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}





+(void)callGetGroupMembersWithGroupId:(int)groupId
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler
{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",groupId] forKey:@"group_id"];
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"getGroupMembers"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  
                                  
                                  if ([data isKindOfClass:[NSArray class]])
                                  {
                                      
                                      NSMutableArray * destinationArray = [NSMutableArray new];
                                      
                                      for (id currentItem in data)
                                      {
                                          
                                          [destinationArray addObject:[self parseUserData:currentItem]];
                                          
                                      }
                                      
                                      
                                      completionHandler(destinationArray);
                                  }
                                  else
                                      completionHandler(@[]);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler([result objectForKey:@"msg"]);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}



+(void)callGetGroupMembersWithGroupId:(int)groupId
                           withUserId:(int)userId
                           withReason:(NSString *)reason
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler
{
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",groupId] forKey:@"group_id"];
    [currentDictionary setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"user_id"];
    [currentDictionary setObject:reason forKey:@"reason"];
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"reportUser"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  
                                  
                                  if ([data isKindOfClass:[NSArray class]])
                                  {
                                      
                                      NSMutableArray * destinationArray = [NSMutableArray new];
                                      
                                      for (id currentItem in data)
                                      {
                                          
                                          [destinationArray addObject:[self parseUserData:currentItem]];
                                          
                                      }
                                      
                                      
                                      completionHandler(destinationArray);
                                  }
                                  else
                                      completionHandler(@[]);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler([result objectForKey:@"msg"]);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}


//forgotPassword

+(void)callLogOut:(NSString *)email
        withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    
    NSUserDefaults *currentUserDefault = [NSUserDefaults standardUserDefaults];
    
    
    AppDelegate * currentApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:logOutURL]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result
                                            objectForKey:@"status"];
                              
                              if ([message isEqualToString:@"success"]) {
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp"];
                                  [currentUserDefault setObject:nil forKey:@"isFirstTimeSignUp2"];
                                  
                                  AppDelegate * currentDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                  //currentDelegate.usingIsNotSignedIn = NO;
                                  
                                  
                                  completionHandler(data);
                                  
                                  
                              }
                              else if ([message isEqualToString:@"failed"]){
                                  
                                  completionHandler(nil);
                                  
                                  
                                  
                              }
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
}

+(void)callLoginUserWithEmail:(NSString *)email
                 withPassword:(NSString *)password
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(id message))failureHandler
        withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler

{
    
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:email forKey:@"email"];
    [currentDictionary setObject:password forKey:@"password"];
    
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:nil
                                 urlCalling:[self makeURLCompleteFromString:@"login"]
     isPostService:YES
                      withComplitionHandler:^(id result) {
                          

                          
                          if ([self isSuccessFullWithDictionary:result]) {
                              
                              
                              id dataObject = [result objectForKey:@"data"];
                              dataObject = [dataObject dictionaryByReplacingNullsWithBlanks];
                              
                              [defauls setObject:dataObject forKey:@"isFirstTimeSignUp"];
                              
                              [defauls setObject:[result objectForKey:@"access_token"] forKey:@"access_token"];
                              
                              
                              
                              
                              completionHandler(dataObject);
                              
                          }
                          else
                          {
                              
                              
                              NSDictionary * data = [result objectForKey:@"data"];
                              
                              if ([data isKindOfClass:[NSString class]]) {
                                  
                                  failureHandler([result objectForKey:@"msg"]);
                              }
                              else if([data isKindOfClass:[NSArray class]])
                              {
                                    failureHandler(@"Invalid login credentials entered.");
                              }
                              else
                            
                              if ([data allKeys] > 0) {
                                  
                                  NSLog(@"%@",data);
                                  
                                  NSMutableArray * tmpAllMessages = [NSMutableArray new];
                                  
                                  
                                  for (id currentKey in [data allKeys])
                                  {
                                      
                                      if ([[data objectForKey:currentKey] isKindOfClass:[NSArray class]]) {
                                          
                                          [tmpAllMessages addObject:[[data objectForKey:currentKey] firstObject]];
                                      }
                                      else
                                          [tmpAllMessages addObject:[data objectForKey:currentKey]];
                                      
                                  }
                                  
                                  
                                  NSString *myString = [tmpAllMessages componentsJoinedByString:@","]; //instead of [myArray description];
                                  
                                  failureHandler(myString);
                                  
                                  
                                  
                                  return;
                                  
                              }
                              failureHandler([result objectForKey:@"msg"]);
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          
                                            failureHandler(ErrorWhileLoadingData);
                          
                          
                      }
     ];
}




+(void)callSerchUserWithKeyword:(NSString *)keyword completionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler
{
    
    NSMutableDictionary *currentDictionary = [NSMutableDictionary new];
    [currentDictionary setObject:keyword forKey:@"keyword"];
    
    
   
    [RestCall callWebServiceWithTheseParams:currentDictionary
                      withSignatureSequence:
     nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"FlpUsers/search.json"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              
                              id message = [result objectForKey:@"message"];
                              
                           
                              if ([[message objectForKey:@"status"] isEqualToString:@"success"]) {
                                  
                                  completionHandler([message objectForKey:@"data"]);
                                  
                                  return;
                                  
                              }
                              else{
                                                                failureHandler();
                              }
                              NSLog(@"");
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
}









+(void)callRespondToRequestWithResponse:(NSString *)responseString
                        withUserId:(int)userId
                  complitionHandler:(void(^)(id result))completionHandler
                  withFailueHandler:(void(^)(void))failureHandler
{
    //userid , requestid
    
    [RestCall callWebServiceWithTheseParams:@{@"user_id":[NSString stringWithFormat:@"%d",userId],@"response_type":responseString}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"responseFriendRequest"]
                              isPostService:YES
                      withComplitionHandler:^(id result)
    {
                          
                          @try {
                              
                              id status = [result objectForKey:@"status"];
                              
                              if ([status isEqualToString:@"success"])
                              {
                                    completionHandler(@"");

                                  
                              }
                              else{
                                  
                              failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callAddFrienWithFriendId:(int)friendId
                      complitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler
{

    [RestCall callWebServiceWithTheseParams:@{@"user_id":[NSString stringWithFormat:@"%d",friendId]}
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"addFriend"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result objectForKey:@"status"];
                              if ([message isEqualToString:@"success"])
                              {
                                  completionHandler([result objectForKey:@"message"]);
                              }
                              else{
                              
                                  failureHandler();
                                  
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callGetMyFriendWithComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
{
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"getFriends"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result objectForKey:@"status"];
                              if ([message isEqualToString:@"success"])
                              {

                                  
                                  NSMutableArray * accepted = [NSMutableArray new];
                                  
                                  for (id currentResult in [[result objectForKey:@"data"] objectForKey:@"accepted"])
                                  {
                                      [accepted addObject:[self parseUserData:currentResult]];
                                      
                                  }
                                  
                                  
                                  NSMutableArray * pending = [NSMutableArray new];
                                  
                                  for (id currentResult in [[result objectForKey:@"data"] objectForKey:@"pending"])
                                  {
                                      [pending addObject:[self parseUserData:currentResult]];
                                      
                                  }
                                  
                                  NSMutableArray * sent = [NSMutableArray new];
                                  
                                  for (id currentResult in [[result objectForKey:@"data"] objectForKey:@"sent"])
                                  {
                                      [sent addObject:[self parseUserData:currentResult]];
                                  }
                                  
                                  completionHandler(@[pending,accepted,sent]);
                                  
                                  
                                  
                              }
                              else if ([message isKindOfClass:[NSArray class]]) {
                                  
                                  if ([message count] == 0 ) {
                                      
                                      failureHandler();
                                      
                                      
                                      
                                  }
                              }
                              else{
                                  
                                  id data = [message objectForKey:@"message"];
                                  
                                  if ([data isEqualToString:@"Password Updated"]) {
                                      completionHandler(@"Password Updated");
                                      
                                  }
                                  else
                                      completionHandler(@"Invalid Password");
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


+(void)callSaveAnswerWithChapterId:(int)chapterId
                    withArryQuestion:(NSArray *)questions
                    withArrayAnswers:(NSArray *)answers
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler
{

    NSMutableDictionary * paramDictionary = [NSMutableDictionary new];
    [paramDictionary setObject:questions forKey:@"question_ids[]"];
    [paramDictionary setObject:answers forKey:@"answers[]"];
    [paramDictionary setObject:[NSString stringWithFormat:@"%d",chapterId] forKey:@"chapter_id"];
    
    [RestCall callWebServiceWithTheseParams:paramDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"save_answers"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              id message = [result objectForKey:@"message"];
                              if ([message isKindOfClass:[NSArray class]]) {
                                  
                                  if ([message count] == 0 ) {
                                      
                                      failureHandler();
                                      
                                  }
                              }
                              else{
                                  
                                  id data = [result objectForKey:@"data"];
                                  
                                  
                                  
                                  
                                  NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                                  
                                  for (id currentItem in data) {
                                      
                                      
                                      if (![currentItem isKindOfClass:[NSDictionary class]]) {
                                          
                                          break;
                                          
                                          
                                      }
                                     NSString * answerText = [currentItem objectForKey:@"answer"];
                                      
                                      
                                      
                                      
                                      NSString * questionIdString = [NSString stringWithFormat:@"%d",[[currentItem objectForKey:@"question_id"] intValue]];


                                      [userDefaults setObject:answerText forKey:questionIdString];
                                      
                                      
                                      
                                      
                                  }

                                  [userDefaults synchronize];
                                  
                                  

                                  
                                  
                            
                                      completionHandler(@"Invalid Password");
                                  
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}

+(void)callGetLastTweetWithComplitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler
{
    
    NSMutableDictionary * paramDictionary = [NSMutableDictionary new];
    
    [RestCall callWebServiceWithTheseParams:paramDictionary
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"get_last_tweet"]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              
                              
                              int code = [[result objectForKey:@"code"] intValue];
                              
                              if (code == 200) {
                                  
                                  id data = [[result objectForKey:@"data"] firstObject];
                                  
                                  NSMutableDictionary * paramDictionary =  [NSMutableDictionary new];
                                  NSString * textOfTweet = [data objectForKey:@"text"];
                                  [paramDictionary setObject:textOfTweet forKey:@"text"];
                                  NSString * createdAt = [data objectForKey:@"created_at"];
                                  [paramDictionary setObject:createdAt forKey:@"createdAt"];
                                  id entities = [data objectForKey:@"entities"];
                                  
                                  [paramDictionary setObject:entities forKey:@"entities"];
                                  
                                  NSString * userImageUrl = [[data objectForKey:@"user"] objectForKey:@"profile_image_url"];
                                  [paramDictionary setObject:userImageUrl forKey:@"userImageUrl"];
                                  NSString * userName = [[data objectForKey:@"user"] objectForKey:@"name"];
                                  [paramDictionary setObject:userName forKey:@"name"];
                                  
                                  

                                  
                                  
                                  completionHandler(paramDictionary);
                                   

                                  
                              }
                              


                                  
                              
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}



+(void)callActiveUserWithcomplition
{
    //userid , requestid
    
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    NSString *token = [defauls objectForKey:@"lastRecode"];;
    
    NSDate * today =  [NSDate new];
    
    
    __block  NSString * tmpString =  [DateFormatter showDate:today inStringFormate:@"dd/MM/yy"];
    
    
    
    if (!token) {
   
        NSLog(@"token not exist");
    }
    else{
        
        

        if ([token isEqualToString:tmpString]) {
            
            return;
        }
        
        
        
    }
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"record_active_user"]
                              isPostService:YES
                      withComplitionHandler:^(id result) {
                          
                              id message = [result objectForKey:@"message"];
                              
                          
                          [defauls setObject:tmpString forKey:@"lastRecode"];
                          
                          NSString *token2 = [defauls objectForKey:@"lastRecode"];;
                          
                          
                              
                              
                          NSLog(@"");
                          
                         
                          
                      } failureComlitionHandler:^{
                          
                          
                      }];
    
    
}











@end
