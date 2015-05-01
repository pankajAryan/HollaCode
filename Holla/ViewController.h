//
//  ViewController.h
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMNetworkClient.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController : UIViewController<APIInvokerDelegate>

{
    IBOutlet UIView* BackgroundAdView;
    IBOutlet UIButton* button_cross;

    
}
@property(nonatomic, retain) AVAudioPlayer *audioPlayer;

@end

