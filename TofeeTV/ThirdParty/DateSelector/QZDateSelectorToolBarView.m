//
//  QZDateSelectorToolBarView.m
//  QZBirthdaySelector
//
//  Created by wymany on 15/11/18.
//  Copyright © 2015年 booksky. All rights reserved.
//

#import "QZDateSelectorToolBarView.h"

static const CGFloat kHorizontalMargin = 5.f;
static const CGFloat kVerticaMargin = 5.f;


#define BBUScreen_bounds [UIScreen mainScreen].bounds
#define BBUScreen_width [UIScreen mainScreen].bounds.size.width
#define BBUScreen_height [UIScreen mainScreen].bounds.size.height

@interface QZDateSelectorToolBarView ()

@property (nonatomic,copy) QZCancelBlock cancelBlock;
@property (nonatomic,copy) QZConfirmBlock confirmBlock;

@end

@implementation QZDateSelectorToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupToolBar];
    }
    return self;
}

- (void)setupToolBar{
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton addTarget:self action:@selector(doClickCancel)  forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.frame = CGRectMake(kHorizontalMargin, kVerticaMargin, 100.f, 30.f);
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_cancelButton];
    

    CGFloat confirmButtonW = _cancelButton.frame.size.width;
    CGFloat confirmButtonH = _cancelButton.frame.size.height;
    CGFloat confirmButtonX = BBUScreen_width - confirmButtonW - kHorizontalMargin;
    CGFloat confirmButtonY = _cancelButton.frame.origin.y;
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton addTarget:self action:@selector(doClickCommit) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.frame = CGRectMake(confirmButtonX, confirmButtonY, confirmButtonW, confirmButtonH);
    [_confirmButton setTitle:@"Done" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_confirmButton];
    

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            150,
                                                            _cancelButton.frame.size.height)];
    _titleLabel.center = self.center;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.text = @"Select Date";
    
 [self addSubview:_titleLabel];
}

- (void)doClickCancel:(QZCancelBlock)cancelBlock confirm:(QZConfirmBlock)confirmBlock
{
    self.cancelBlock = cancelBlock;
    self.confirmBlock = confirmBlock;
}

- (void)doClickCancel
{
    if (self.cancelBlock)
    {
        self.cancelBlock();
    }
}

- (void)doClickCommit
{
    if (self.confirmBlock)
    {
        self.confirmBlock();
    }
}

@end
