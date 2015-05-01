//
//  UIViewController+ALPopupViewController.m
//  AirtelMoney-Universal
//
//  Created by Airtel on 23/09/14.
//  Copyright (c) 2014 Bharti Airtel Limited. All rights reserved.
//

#import "UIViewController+ALPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ALPopupBackgroundView.h"
#import <objc/runtime.h>

#define kPopupModalAnimationDuration 0.35
#define kALPopupViewController @"kALPopupViewController"
#define kALPopupBackgroundView @"kALPopupBackgroundView"
#define kALSourceViewTag 23941
#define kALPopupViewTag 23942
#define kALOverlayViewTag 23945

@interface UIViewController (ALPopupViewControllerPrivate)
- (UIView*)topView;
- (void)presentPopupView:(UIView*)popupView;
@end

@implementation UIViewController (ALPopupViewController)

static void * const keypath = (void*)&keypath;

- (UIViewController*)al_popupViewController {
    return objc_getAssociatedObject(self, kALPopupViewController);
}

- (void)setAl_popupViewController:(UIViewController *)al_popupViewController {
    objc_setAssociatedObject(self, kALPopupViewController, al_popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (ALPopupBackgroundView*)al_popupBackgroundView {
    return objc_getAssociatedObject(self, kALPopupBackgroundView);
}

- (void)setAl_popupBackgroundView:(ALPopupBackgroundView *)al_popupBackgroundView {
    objc_setAssociatedObject(self, kALPopupBackgroundView, al_popupBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(ALPopupViewAnimation)animationType
{
    self.al_popupViewController = popupViewController;
    
    [self presentPopupView:popupViewController.view animationType:animationType];
}

- (void)dismissPopupViewControllerWithanimationType:(ALPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kALPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kALOverlayViewTag];
    
    switch (animationType) {
        case ALPopupViewAnimationSlideBottomTop:
        case ALPopupViewAnimationSlideBottomBottom:
        case ALPopupViewAnimationSlideTopTop:
        case ALPopupViewAnimationSlideTopBottom:
        case ALPopupViewAnimationSlideLeftLeft:
        case ALPopupViewAnimationSlideLeftRight:
        case ALPopupViewAnimationSlideRightLeft:
        case ALPopupViewAnimationSlideRightRight:
            [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
            
        default:
            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
    self.al_popupViewController = nil;
}



////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(ALPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    sourceView.tag = kALSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kALPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kALOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    self.al_popupBackgroundView = [[ALPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    self.al_popupBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.al_popupBackgroundView.backgroundColor = [UIColor clearColor];
    self.al_popupBackgroundView.alpha = 0.0f;
    [overlayView addSubview:self.al_popupBackgroundView];
    
    // Make the Background Clickable
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimation:) forControlEvents:UIControlEventTouchUpInside];
    switch (animationType) {
        case ALPopupViewAnimationSlideBottomTop:
        case ALPopupViewAnimationSlideBottomBottom:
        case ALPopupViewAnimationSlideTopTop:
        case ALPopupViewAnimationSlideTopBottom:
        case ALPopupViewAnimationSlideLeftLeft:
        case ALPopupViewAnimationSlideLeftRight:
        case ALPopupViewAnimationSlideRightLeft:
        case ALPopupViewAnimationSlideRightRight:
            dismissButton.tag = animationType;
            [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
        default:
            dismissButton.tag = ALPopupViewAnimationFade;
            [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
}

-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

- (void)dismissPopupViewControllerWithanimation:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* dismissButton = sender;
        switch (dismissButton.tag) {
            case ALPopupViewAnimationSlideBottomTop:
            case ALPopupViewAnimationSlideBottomBottom:
            case ALPopupViewAnimationSlideTopTop:
            case ALPopupViewAnimationSlideTopBottom:
            case ALPopupViewAnimationSlideLeftLeft:
            case ALPopupViewAnimationSlideLeftRight:
            case ALPopupViewAnimationSlideRightLeft:
            case ALPopupViewAnimationSlideRightRight:
                [self dismissPopupViewControllerWithanimationType:dismissButton.tag];
                break;
            default:
                [self dismissPopupViewControllerWithanimationType:ALPopupViewAnimationFade];
                break;
        }
    } else {
        [self dismissPopupViewControllerWithanimationType:ALPopupViewAnimationFade];
    }
}

//////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Animations

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(ALPopupViewAnimation)animationType
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    switch (animationType) {
        case ALPopupViewAnimationSlideBottomTop:
        case ALPopupViewAnimationSlideBottomBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            
            break;
        case ALPopupViewAnimationSlideLeftLeft:
        case ALPopupViewAnimationSlideLeftRight:
            popupStartRect = CGRectMake(-sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case ALPopupViewAnimationSlideTopTop:
        case ALPopupViewAnimationSlideTopBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        -popupSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        default:
            popupStartRect = CGRectMake(sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.al_popupViewController viewWillAppear:NO];
        self.al_popupBackgroundView.alpha = 1.0f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
        [self.al_popupViewController viewDidAppear:NO];
    }];
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(ALPopupViewAnimation)animationType
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    switch (animationType) {
        case ALPopupViewAnimationSlideBottomTop:
        case ALPopupViewAnimationSlideTopTop:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      -popupSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case ALPopupViewAnimationSlideBottomBottom:
        case ALPopupViewAnimationSlideTopBottom:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case ALPopupViewAnimationSlideLeftRight:
        case ALPopupViewAnimationSlideRightRight:
            popupEndRect = CGRectMake(sourceSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
        default:
            popupEndRect = CGRectMake(-popupSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.al_popupViewController viewWillDisappear:NO];
        popupView.frame = popupEndRect;
        self.al_popupBackgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.al_popupViewController viewDidDisappear:NO];
        self.al_popupViewController = nil;
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.al_popupViewController viewWillAppear:NO];
        self.al_popupBackgroundView.alpha = 1.0f;//0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.al_popupViewController viewDidAppear:NO];
    }];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.al_popupViewController viewWillDisappear:NO];
        self.al_popupBackgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.al_popupViewController viewDidDisappear:NO];
        self.al_popupViewController = nil;
    }];
}


@end
