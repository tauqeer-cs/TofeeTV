//
//  User.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 3/15/16.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelBase.h"


@interface User : ModelBase

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * status;
@property (nonatomic) int userId;
@property (nonatomic,strong) NSString * firstName;
@property (nonatomic,strong) NSString * lastName;

@property (nonatomic,strong) NSString * friendStatus;


@property (nonatomic,strong) NSString * profileImageUrl;

+(void)callRegisterUserWithEmail:(NSString *)emailAddress
                   withFirstName:(NSString *)firstName
                    withLastName:(NSString *)lastName
                    withPassword:(NSString *)password
                       withImage:(UIImage *)profileImage
           withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
        withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callRegisterUserWithSocial:(NSString *)socialToken withName:(NSString *)fullName
                        withEmail:(NSString *)email
                         withFbID:(NSString *)fbId
            withComplitionHandler:(void(^)(id result))completionHandler
                withFailueHandler:(void(^)(id error))failureHandler
         withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callLoginUserWithEmail:(NSString *)email withPassword:(NSString *)password
        withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(id message))failureHandler
   withNoAccountExistsHandler:(void(^)(id result))noAccountExistsHandler;





+(void)callSerchUserWithKeyword:(NSString *)keyword completionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;

+(void)uploadUserProfileImageWithUserId:(int)userId
                          withUserImage:(UIImage *)imageToUpload
                               withName:(NSString *)name
                              withEmail:(NSString *)email
                        withPhoneNumber:(NSString *)phoneNumber
                  withComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;

+(void)updateProfileWithOutImage:(int)userId WithName:(NSString *)name withEmail:(NSString *)email
                       withPhone:(NSString *)phoneNumber
           withComplitionHandler:(void(^)(id result))completionHandler
               withFailueHandler:(void(^)(void))failureHandler;




+(void)callAddFacebookFriendsWithUser:(NSString *)userId
                        withFriendIds:(NSString *)friends
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler;
+(void)callRemoveFriendsWith:(NSString *)userId
               withFriendIds:(NSString *)friendId
           ComplitionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler;

+(void)callForgetPasswordWithEmail:(NSString *)email
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler;

+(void)callCheckUserExistsWithEmail:(NSString *)email
                  complitionHandler:(void(^)(id result))completionHandler
                  withFailueHandler:(void(^)(void))failureHandler;
+(void)callChangeUserPasswordWithUserId:(NSString *)userId
                        withOldPassword:(NSString *)oldPassword
                        withNewPassword:(NSString *)newPassword
                      complitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;
//

+(void)callLogOut:(NSString *)email
withComplitionHandler:(void(^)(id result))completionHandler
withFailueHandler:(void(^)(void))failureHandler;



+(void)callForgetAccount:(NSString *)email
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler;


+(void)callChangePasswordWithOldPassword:(NSString *)oldPassword
                         withNewPassword:(NSString *)newPassword
                   withComplitionHandler:(void(^)(id result))completionHandler
                       withFailueHandler:(void(^)(id result))failureHandler;

+(void)callEditPeriodInfo:(NSString *)dateString
       withNoOfPeriodDays:(int)noOfPeriodDay
   WithmenstrualCycleDays:(int)menstrualCycleDays
    withComplitionHandler:(void(^)(id result))completionHandler
        withFailueHandler:(void(^)(void))failureHandler;

+(void)callContactUs:(NSString *)subject
         withMessage:(NSString *)message
withComplitionHandler:(void(^)(id result))completionHandler
   withFailueHandler:(void(^)(void))failureHandler;



+(void)callActiveUserWithcomplition;

+(void)callUploadProfileWithId:(NSString *)imageId
                 withImageName:(UIImage *)imageName
         withComplitionHandler:(void(^)(id result))completionHandler
             withFailueHandler:(void(^)(void))failureHandler;

+(void)callSaveAnswerWithChapterId:(int)chapterId
                    withQuestionId:(int)questionId
                    withAnswerText:(NSString *)answerText
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler;

+(void)callSaveAnswerWithChapterId:(int)chapterId
                  withArryQuestion:(NSArray *)questions
                  withArrayAnswers:(NSArray *)answers
                 complitionHandler:(void(^)(id result))completionHandler
                 withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetLastTweetWithComplitionHandler:(void(^)(id result))completionHandler
                           withFailueHandler:(void(^)(void))failureHandler;


+(void)callGetAllMyAnswers;

//Get my chpater answers

+(void)callAddPushIds:(int)userId
withComplitionHandler:(void(^)(id result))completionHandler
    withFailueHandler:(void(^)(id error))failureHandler
withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;

+(void)callEditUserWithEmail:(NSString *)emailAddress
                    withName:(NSString *)name
                withLastName:(NSString *)lastName
                   withImage:(UIImage *)profileImage
       withComplitionHandler:(void(^)(id result))completionHandler
           withFailueHandler:(void(^)(void))failureHandler
    withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callLogouWithComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(id error))failureHandler
             withAlreadyExistsHandler:(void(^)(id result))alreadyExistHandler;


+(void)callSearchFriends:(NSString *)searchName
   withComplitionHandler:(void(^)(id result))completionHandler
       withFailueHandler:(void(^)(void))failureHandler;


+(void)callAddFrienWithFriendId:(int)friendId
              complitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetMyFriendWithComplitionHandler:(void(^)(id result))completionHandler
                          withFailueHandler:(void(^)(void))failureHandler;

+(void)callRespondToRequestWithResponse:(NSString *)responseString
                             withUserId:(int)userId
                      complitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetGroupMembersWithGroupId:(int)groupId
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler;

+(void)callGetGroupMembersWithGroupId:(int)groupId
                           withUserId:(int)userId
                           withReason:(NSString *)reason
                withComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler;
+(void)callUnFriendWithFriendId:(int)friendId
          withComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;

@end
