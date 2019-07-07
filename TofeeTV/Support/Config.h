//
//  Config.h
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import <Foundation/Foundation.h>
//http:///pingem/api/vendor/create-vendor-from-user

///dashboard/login

#define baseServiceUrl isLive ? @"http://142.93.217.242/api/v1/" : @"http://142.93.217.242/api/v1/"
#define baseImageLink isLive ? @"http://142.93.217.242/api/v1/" : @"http://142.93.217.242/api/v1/"
#define startingLink isLive ? @"http://142.93.217.242" : @"http://142.93.217.242"


#define appUrl @"https://itunes.apple.com/us/app/gift-list-a-gift-sharing-app/id1440596904?ls=1&mt=8"

/*
#define baseServiceUrl isLive ? @"http://192.168.100.6:7272/giftlist/public/api/v1/" : @"http://192.168.100.6:7272/giftlist/public/api/v1/"
#define baseImageLink isLive ? @"http://192.168.100.6:7272/giftlist/public/api/v1/" : @"http://192.168.100.6:7272/giftlist/public/api/v1/"
*/

//
//http://www.hashtaggospelapp.nl

#define isLive YES

#define WriteAText @"Type a message"
#define create @"create_user"
#define editProfile @"update_user"
#define loginUser @"login_user"
#define logOutS @"Баромадан"
#define logOutURL @"logout"

#define forgotPassword @"reset/password"
#define getExperts @"get_experts"
#define changePassword @"change_password"
#define NewsListing @"get_newsfeeds"
#define RemediesListing @"get_remedies"
#define GetPlacesTypes @"get_places_types"
#define GetDoctorsList @"get_doctors"
#define GetConditions @"get_conditions"
#define GetSymptoms @"get_symptoms"

#define ConfirmPassword @"Рамзро тасдиқ намоед"
#define FillResetPassword @"Ин формаро пур кунед, то рамзатон бознишонда шавад"
#define ResetPassword @"Рамзро бознишонӣ кунед"

#define WeEmailedLink @"We have e-mailed your password reset link"



#define Error @"Error"
#define ValidEmailError @"Please enter valid email."
#define PleaseFullname @"Please enter your full name."
#define PleasePassword @"Please enter password."
#define InvalidPassword @"Invalid email or password entered."
#define ErrorWhileLoadingData @"Error while loading data."
#define ErrorWhileUpdating @"Error while updating information."
#define UserAlreadyExists @"User already exists with this email."
#define AreSureLogout @"Are you sure you want to logout."
#define SearchForByNameOrEmail @"Search for your friend by Name or Email."
#define CurrentlyNoFriends @"Currently no friends added."
#define ErrorWhileLoggingFacebook @"Error while logging in to Facebook."
#define ErrorAcceptingRequest @"Error while accepting request."
#define ErrorRejectingRequest @"Error while declining friend request."
#define Warning @"Warning"
#define AreYouSureYouWantToUnfriend @"Are you sure you want to unfriend."
#define Cancel @"Cancel"
#define ErrorDeletingFriend @"Error while deleting friend."
#define Update @"Update"
#define Delete @"Delete"
#define Notes @"Notes"
#define SelectListType @"Select Gift List Type."
#define PleaseSelectDate @"Please select a past date."
#define ListNoNameError @"Please give your list a name."
#define ErrorUdated @"Error while updated data."
#define ErrorCreatingList @"Error while creating list."
#define UnableToAdd @"Unable to add data"
#define ProductAddedSuccessfully @"Product added successfully"
#define GiftListSuccessfully @"GiftList added successfully"
#define UnableToAddGift @"Unable to add Gift"
#define AreYouSureYouWantToDeleteList @"Are you sure you want to delete this list"
#define ErrorDeletingList @"Error while deleting list"
#define ForfotPasswordMainText @"Enter your email and we will send you a temporary password.\n\nYou can log in and reset it later."
#define ResetLinkSentText @"A password reset link has been sent to your email."
#define ChangePassword @"Change Password"
#define PleaseFillfields @"Please fill all fields."
#define NewPassword @"Should match with confirm password."
#define NewPasswordShouldMatch @"New Password should match with confirm password."
#define Updated @"Updated"
#define PasswordUpdated @"Password updated successfully"
#define ErrorWhileUpdatingPassword @"Error while updating password"
#define WarningDeletingList @"Are you sure you want to delete this from list?"
#define ErrorWhileDeletingItem @"Error while deleting product"
#define PleaseProductName @"Please enter product name."
#define ProductUpdatedMessage @"Product updated successfully"
#define ErrorWhileUpdatedProduct @"Error while updating product"
#define ErrorCreatingProduct @"Error while creating product."
#define SelectOption @"Select Option"
#define SelectPhoto @"Select Photo"
#define Available @"Available"
#define Reserved @"Reserved"
#define Bought @"Bought"
#define ErrorWhileReservingGift @"Error while reserving gift."
#define ErrorWhileCreatingUser @"Error while creating user."
#define PleaseReadTerms @"Please read and agree to terms and conditions."
#define PasswordAndConfirmPasswordDoesNotMatch @"Password and confirm password does not match."
#define PasswordCntBeLessThan6 @"Password can not be less than 6 characters."
#define IAgreeToTerms @"I agree to the Terms and Conditions"

#define FancyFont @"KGWhattheTeacherWants"
#define FontRegular FancyFont
#define FontSemiBold @"Raleway-SemiBold"
#define FontExtraBold @"Raleway-ExtraBold"
#define FontMedium @"Raleway-Medium"
#define DigitFont @"OpenSans"
#define DigitFontBold @"OpenSans-Semibold"

/*
 2019-02-06 19:28:58.183486+0500 TofeeTV[1262:58706] Family name: Raleway
 2019-02-06 19:28:58.184315+0500 TofeeTV[1262:58706]     Font name: Raleway-Regular
 2019-02-06 19:28:58.184884+0500 TofeeTV[1262:58706]     Font name: Raleway-Bold
 2019-02-06 19:28:58.185295+0500 TofeeTV[1262:58706]     Font name: Raleway-ExtraLight
 2019-02-06 19:28:58.185581+0500 TofeeTV[1262:58706]     Font name: Raleway-SemiBold
 2019-02-06 19:28:58.185993+0500 TofeeTV[1262:58706]     Font name: Raleway-SemiBoldItalic
 2019-02-06 19:28:58.186355+0500 TofeeTV[1262:58706]     Font name: Raleway-Italic
 2019-02-06 19:28:58.186640+0500 TofeeTV[1262:58706]     Font name: Raleway-Light
 2019-02-06 19:28:58.186880+0500 TofeeTV[1262:58706]     Font name: Raleway-ExtraBold
 2019-02-06 19:28:58.187104+0500 TofeeTV[1262:58706]     Font name: Raleway-LightItalic
 2019-02-06 19:28:58.187378+0500 TofeeTV[1262:58706]     Font name: Raleway-ExtraLightItalic
 2019-02-06 19:28:58.187857+0500 TofeeTV[1262:58706]     Font name: Raleway-Medium
 2019-02-06 19:28:58.188240+0500 TofeeTV[1262:58706]     Font name: Raleway-ThinItalic
 2019-02-06 19:28:58.188537+0500 TofeeTV[1262:58706]     Font name: Raleway-MediumItalic
 2019-02-06 19:28:58.188935+0500 TofeeTV[1262:58706]     Font name: Raleway-ExtraBoldItalic
 2019-02-06 19:28:58.189113+0500 TofeeTV[1262:58706]     Font name: Raleway-Black
 2019-02-06 19:28:58.189408+0500 TofeeTV[1262:58706]     Font name: Raleway-Thin
 2019-02-06 19:28:58.189693+0500 TofeeTV[1262:58706]     Font name: Raleway-BoldItalic
 2019-02-06 19:28:58.189953+0500 TofeeTV[1262:58706]     Font name: Raleway-BlackItalic
 */
#define TitleBarFont [UIFont fontWithName:FontToSemiBold size:22]
#define TitleBarFontColor [UIColor colorWithRed:1.0 green:252.0/255.0 blue:234.0/255.0 alpha:1.0]


#define DefaultYellowColor2 [UIColor colorWithRed:251.0/255.0 green:176.0/255.0 blue:59.0/255.0 alpha:1.0]
//// 251  176  59
#define TopBarTitleColor [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0]

#define DefaultRed [UIColor colorWithRed:214.0/255.0 green:4.0/255.0 blue:3.0/255.0 alpha:1.0]
#define DefaultGreen [UIColor colorWithRed:3.0/255.0 green:134.0/255.0 blue:0.0/255.0 alpha:1.0]
#define ShadedLightGray [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246/255.0 alpha:1.0]
#define DefaultPink [UIColor colorWithRed:253.0/255.0 green:40.0/255.0 blue:252/255.0 alpha:1.0]
#define DefaultPink2 [UIColor colorWithRed:253.0/255.0 green:40.0/255.0 blue:252/255.0 alpha:0.8]

#define BlueBorderColor [UIColor colorWithRed:63.0/255.0 green:168.0/255.0 blue:186.0/255.0 alpha:1.0]

#define TagsFont [UIFont fontWithName:FontToSemiBold size:12]

#define HomeCellButtonFont [UIFont fontWithName:FontToSemiBold size:15]
#define HomeCellTitleFont [UIFont fontWithName:FontToUseRegular size:17]

#define FontBigRegular [UIFont fontWithName:FontToUseRegular size:22]

#define HomeButtonFont [UIFont fontWithName:FontToSemiBold size:18]


#define FormSmallSize [UIFont fontWithName:FontToSemiBold size:14]

#define FormTextColor [UIColor colorWithRed:83.0/255.0 green:175.0/255.0 blue:188.0/255 alpha:1.0]
#define DetailTextColor [UIColor colorWithRed:82.0/255.0 green:82.0/255.0 blue:82.0/255 alpha:1.0]


#define FormPinkColor [UIColor colorWithRed:1.0 green:0.3843137255 blue:0.5882352941 alpha:1.0]






//


#define IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]  || [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])
#define IS_IPad ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]  || [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"])
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f
#define IS_HEIGHT_GTE_4 [[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height == 667.0f
#define IS_HEIGHT_GTE_736 [[UIScreen mainScreen ] bounds].size.height == 736.0f
#define IS_HEIGHT_GTE_812 [[UIScreen mainScreen ] bounds].size.height == 812.0f

#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
#define IS_IPHONE_6 ( IS_IPHONE && IS_HEIGHT_GTE_667 )
#define IS_IPHONE_6P ( IS_IPHONE && IS_HEIGHT_GTE_736 )
#define IS_IPHONE_4S ( IS_IPHONE && IS_HEIGHT_GTE_4 )
#define IS_IPHONE_10 ( IS_IPHONE && IS_HEIGHT_GTE_812 )


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS10     ([[UIDevice currentDevice].systemVersion compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)

#define IPHONE4S_RATIO 1.252
#define IPHONE5_RATIO 1.038
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE4S @"iphone4s"
#define IPHONE5 @"iphone5"
#define IPAD @"ipad"
#define IPAD_RETINA @"ipadretina"
#define HeadingFontName @"HelveticaNeue-CondensedBold"
#define YouAlreadyMember @"You have already joined this group"


#define InnAppPurchaseId @"com.hashtaggospel.unlockAll"
#define PleaseSignInFirstToAnswerQuestion @"Sign in to access this app feature."
#define DoYouWantToRegister @"Would you like to sign in?"

#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)
#define INTERNET_INAVAILABLE_MSG @"Internet has not been detected on your device. Please check your internet settings again to proceed!"
#define SOMETHING_WENT_WRONG_MSG @"Something went wrong while fetching your request. Please try again later!"
#define FEATURE_FEED_ERROR_MSG @"Something went wrong while fetching the Kurfuffls. Please try again later"
#define FEED_CELL_CUSTOM_MSG @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
#define LOCATION_OFF_QIBLA @"Turn on your Location Service for getting corrent direction."
#define LOCATION_OFF_PLAYER @"Turn on your Location Service for getting accurate Player Timings."
//IS_IPHONE_4S ? @"FriendsRadarWizard4" : @"FriendsRadarWizard"
// Text View Sizes
#define FEEDCELL_TEXT_VIEW_SIZE CGSizeMake(205, 12)

// Color From Hex
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
#define REGEX_WEB_URL @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"

#define TIMER_INTERVAL 0.05
#define VIDEO_FOLDER @"videoFolder"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Config : NSObject

@end
