//
//  AFDropdownNotification.m
//  AFDropdownNotification-Demo
//
//  Created by Alvaro Franco on 21/08/14.
//  Copyright (c) 2014 AluanaLabs. All rights reserved.
//

#import "AFDropdownNotification.h"
#import "UIImageView+AFNetworking.h"

#define kDropdownImageSize 30
#define kDropdownPadding 10
#define kDropdownTitleFontSize 22
#define kDropdownSubtitleFontSize 16
#define kDropdownButtonWidth 75
#define kDropdownButtonHeight 30

@interface AFDropdownNotification ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGSize screenSize;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic) BOOL gravityAnimation;

@property (nonatomic, copy) blockDropdown internalBlock;

@end

@implementation AFDropdownNotification

-(id)init {
    
    self = [super init];
    
    if (self) {
        
        _notificationView = [UIView new];
        _notificationView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
        _titleLabel.textColor = [UIColor whiteColor];
        
        _subtitleLabel = [UILabel new];
        _subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.textColor = [UIColor whiteColor];
        
        _imageView = [UIImageView new];
        _imageView.image = nil;
        
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        [_topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _topButton.adjustsImageWhenHighlighted = YES;
        _topButton.backgroundColor = [UIColor clearColor];
        
        [_topButton.layer setCornerRadius:5];
        [_topButton.layer setBorderWidth:1];
        [_topButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [_topButton.layer setMasksToBounds:YES];
        
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomButton.layer setCornerRadius:10];
        [_bottomButton.layer setBorderWidth:1];
        [_bottomButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [_bottomButton.layer setMasksToBounds:YES];
        
        _screenSize = [[UIScreen mainScreen] bounds].size;
        _removeAfter = 4.0;
        _dismissOnTap = YES;
    }
    
    return self;
}

-(void)presentInView:(UIView *)view withGravityAnimation:(BOOL)animation {
    
    if (!_isBeingShown) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_removeAfter target:self selector:@selector(aTime) userInfo:nil repeats:YES];
        
        if(_imageURL != nil && ![_imageURL isEqualToString:@""]) {
            [_imageView setImageWithURL:[NSURL URLWithString:_imageURL]];
        } else {
            _imageView.image = _image;
        }
        
        _titleLabel.text = _titleText;
        _subtitleLabel.text = _subtitleText;
        [_topButton setTitle:_topButtonText forState:UIControlStateNormal];
        [_bottomButton setTitle:_bottomButtonText forState:UIControlStateNormal];
        
        NSInteger textWidth = ([[UIScreen mainScreen] bounds].size.width - kDropdownPadding - kDropdownImageSize - kDropdownPadding - kDropdownPadding);
        NSInteger titleHeight = [_titleLabel.text boundingRectWithSize:CGSizeMake(textWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:kDropdownTitleFontSize]} context:nil].size.height;
        NSInteger subtitleHeight = [_subtitleLabel.text boundingRectWithSize:CGSizeMake(textWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:kDropdownSubtitleFontSize]} context:nil].size.height;
        NSInteger notificationHeight = (20 + kDropdownPadding + titleHeight + (kDropdownPadding / 2) + subtitleHeight + kDropdownButtonHeight);
        
        if (notificationHeight < 100) {
            notificationHeight = 100;
        }

        _notificationView.frame = CGRectMake(0, -notificationHeight, [[UIScreen mainScreen] bounds].size.width, notificationHeight);
        _notificationView.backgroundColor = [UIColor redColor];
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:_notificationView];
        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:_notificationView];
        
        _imageView.frame = CGRectMake(kDropdownPadding,kDropdownPadding*2, kDropdownImageSize, kDropdownImageSize);
        
        if (_image || _imageURL) {
            [_notificationView addSubview:_imageView];
            self.imageView.clipsToBounds = YES;
            self.imageView.layer.cornerRadius = 5;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageView setBackgroundColor:[UIColor whiteColor]];
        }
        
        _titleLabel.frame = CGRectMake(kDropdownPadding + kDropdownImageSize + kDropdownPadding, kDropdownPadding*2, textWidth, titleHeight);
        
        if (_titleText) {
            [_notificationView addSubview:_titleLabel];
        }
        
        _subtitleLabel.frame = CGRectMake(kDropdownPadding + kDropdownImageSize + kDropdownPadding, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, textWidth, subtitleHeight);
        
        if (_subtitleText) {
            [_notificationView addSubview:_subtitleLabel];
        }
        
        _topButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - kDropdownButtonWidth - kDropdownPadding,notificationHeight - kDropdownPadding - kDropdownButtonHeight, kDropdownButtonWidth, kDropdownButtonHeight);
        [_topButton addTarget:self action:@selector(topButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        if (_topButtonText) {
            [_notificationView addSubview:_topButton];
        }
        
        _bottomButton.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + kDropdownPadding, _topButton.frame.origin.y + _topButton.frame.size.height + 6, kDropdownButtonWidth, kDropdownButtonHeight);
        [_bottomButton addTarget:self action:@selector(bottomButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        if (_bottomButtonText) {
            [_notificationView addSubview:_bottomButton];
        }
        
        if (_dismissOnTap) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
            tap.numberOfTapsRequired = 1;
            [_notificationView addGestureRecognizer:tap];
        }
        
        if (animation) {
            
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:[[UIApplication sharedApplication] keyWindow]];
            
            UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_notificationView]];
            [_animator addBehavior:gravity];
            
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_notificationView]];
            collision.translatesReferenceBoundsIntoBoundary = NO;
            [collision addBoundaryWithIdentifier:@"notificationEnd" fromPoint:CGPointMake(0, notificationHeight) toPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width, notificationHeight)];
            [_animator addBehavior:collision];
            
            UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_notificationView]];
            elasticityBehavior.elasticity = 0.3f;
            [_animator addBehavior:elasticityBehavior];
        } else {
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                _notificationView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, notificationHeight);
            } completion:nil];
        }
        
        _isBeingShown = YES;
        _gravityAnimation = animation;
    }
    
    _internalBlock = ^(AFDropdownNotificationEvent event) {
        
    };
}

-(void)aTime
{
    NSLog(@"....Timer Function Called....");
    [self dismissWithGravityAnimation:YES];
}

-(void)topButtonTapped {
    
    [self.notificationDelegate dropdownNotificationTopButtonTapped];
    
    if (_internalBlock) {
        
        _internalBlock(AFDropdownNotificationEventTopButton);
    }
}

-(void)bottomButtonTapped {
    
    [self.notificationDelegate dropdownNotificationBottomButtonTapped];
    
    //    if (_internalBlock) {
    
    _internalBlock(AFDropdownNotificationEventBottomButton);
    //    }
}

-(void)dismiss:(id)sender {
    [self topButtonTapped];
    /*
    [self dismissWithGravityAnimation:_gravityAnimation];
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        
        if (_internalBlock) {
            
            _internalBlock(AFDropdownNotificationEventTap);
        }
    }
     */
}

-(void)dismissWithGravityAnimation:(BOOL)animation {
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (animation) {
        
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_notificationView]];
        gravity.gravityDirection = CGVectorMake(0, -1.5);
        [_animator addBehavior:gravity];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [_animator removeAllBehaviors];
            [self removeSubviews];
            [_notificationView removeFromSuperview];
            
            _isBeingShown = NO;
        });
    } else {
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            [_animator removeAllBehaviors];
            
            _notificationView.frame = CGRectMake(0, -_notificationView.frame.size.height, [[UIScreen mainScreen] bounds].size.width, _notificationView.frame.size.height);
        } completion:^(BOOL finished) {
            
            [self removeSubviews];
            [_notificationView removeFromSuperview];
            
            _isBeingShown = NO;
        }];
    }
}

-(void)removeSubviews {
    
    for (UIView *subiew in _notificationView.subviews) {
        
        [subiew removeFromSuperview];
    }
}

-(void)listenEventsWithBlock:(blockDropdown)block {
    
    _internalBlock = ^(AFDropdownNotificationEvent event) {
        
        if (block) {
            
            block(event);
        }
    };
}

@end
