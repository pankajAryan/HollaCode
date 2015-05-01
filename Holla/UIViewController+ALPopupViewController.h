//
//  UIViewController+ALPopupViewController.h
//  AirtelMoney-Universal
//
//  Created by Airtel on 23/09/14.
//  Copyright (c) 2014 Bharti Airtel Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALPopupBackgroundView;

typedef enum {
    ALPopupViewAnimationFade = 0,
    ALPopupViewAnimationSlideBottomTop = 1,
    ALPopupViewAnimationSlideBottomBottom,
    ALPopupViewAnimationSlideTopTop,
    ALPopupViewAnimationSlideTopBottom,
    ALPopupViewAnimationSlideLeftLeft,
    ALPopupViewAnimationSlideLeftRight,
    ALPopupViewAnimationSlideRightLeft,
    ALPopupViewAnimationSlideRightRight,
} ALPopupViewAnimation;

@interface UIViewController (ALPopupViewController)

@property (nonatomic, retain) UIViewController *al_popupViewController;
@property (nonatomic, retain) ALPopupBackgroundView *al_popupBackgroundView;

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(ALPopupViewAnimation)animationType;
- (void)dismissPopupViewControllerWithanimationType:(ALPopupViewAnimation)animationType;

@end
