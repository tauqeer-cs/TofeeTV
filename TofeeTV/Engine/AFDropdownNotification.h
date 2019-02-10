//
//  AFDropdownNotification.h
//  AFDropdownNotification-Demo
//
//  Created by Alvaro Franco on 21/08/14.
//  Copyright (c) 2014 AluanaLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol AFDropdownNotificationDelegate <NSObject>

-(void)dropdownNotificationTopButtonTapped;
-(void)dropdownNotificationBottomButtonTapped;

@end

@interface AFDropdownNotification : NSObject

typedef NS_ENUM(NSInteger, AFDropdownNotificationEvent) {
    
    AFDropdownNotificationEventTopButton,
    AFDropdownNotificationEventBottomButton,
    AFDropdownNotificationEventTap
};

typedef void (^blockDropdown)(AFDropdownNotificationEvent event);

@property (nonatomic, strong) id<AFDropdownNotificationDelegate> notificationDelegate;

@property (nonatomic, strong) UIView *notificationView;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *subtitleText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *topButtonText;
@property (nonatomic, strong) NSString *bottomButtonText;

@property (nonatomic) BOOL isBeingShown;
@property (nonatomic) BOOL isImageRounded;
@property (nonatomic) int Tag;
@property (nonatomic) float removeAfter;
@property (nonatomic) NSTimer *timer;
-(void)listenEventsWithBlock:(blockDropdown)block;

-(void)presentInView:(UIView *)view withGravityAnimation:(BOOL)animation;
-(void)dismissWithGravityAnimation:(BOOL)animation;

@property (nonatomic) BOOL dismissOnTap;

@end
