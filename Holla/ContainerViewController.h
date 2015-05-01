//
//  ContainerViewController.h
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HConstants.h"

@interface ContainerViewController : UIViewController
{

}
@property (strong, nonatomic) NSString *currentSegueIdentifier;

- (void)showViewControllerWitdId:(NSString*)tosegueIdentifer containerView:(UIView*)container_view;
- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

@end
