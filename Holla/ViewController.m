//
//  ViewController.m
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "ViewController.h"

#import "AMNetworkClient.h"

#import "UIImageView+AFNetworking.h"
#import "UtilityClass.h"


@interface ViewController ()
{
}
@property (weak, nonatomic) IBOutlet UIImageView *LaunchAd;

@end

@implementation ViewController

@synthesize LaunchAd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.LaunchAd setImage:[UIImage imageNamed:@"SampleAd"]];
    
    /*
     URL- POST http://128.199.99.127:8080/Holla/rest/service/getPopup
     Content-Type: application/json
     POST data form parameters:
     curr_lat=
     curr_Long=
     */
    NSNotificationCenter *note = [NSNotificationCenter defaultCenter];
    [note addObserver:self selector:@selector(networkNotAvailableNotification:) name:@"noNetworkAvailable" object:nil];

    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"HollaAnthem" ofType:@"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [self.audioPlayer setDelegate:self];
    [self.audioPlayer prepareToPlay];
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
    

    
    NSDictionary* dict_launchAds = [[NSDictionary alloc] initWithObjectsAndKeys:@"70.2",@"curr_lat",
                                    @"70.2",@"curr_Long",
                                    nil];
    
    [UtilityClass showSpinnerWithMessage:@"Loading.." :self];
    [AMNetworkClient instance].delegate = self;
    [[AMNetworkClient instance] fetchLaunchAds:dict_launchAds];
    
    

    
}
-(void)viewWillAppear:(BOOL)animated
{

}

-(IBAction)closeButtonClicked:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)GetLaunchAdsRequestFinished:(id)JSON
{

    NSLog(@"Finish Response %@",JSON);

    NSString* ImageURL = [[[[JSON objectForKey:@"object"] objectForKey:@"images"] objectAtIndex:0] objectForKey:@"imageUrl"];
    
    NSURL *url = [NSURL URLWithString:ImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    DLog(@"Image URL [%@]",ImageURL);
    
    
    [self.LaunchAd setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [UtilityClass hideSpinner];
        
        self.LaunchAd.image = image;
        [button_cross setHidden:NO];


    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {

        [UtilityClass hideSpinner];
        UIImage* defaultImage = [UIImage imageNamed:@"default-launchad"];
        self.LaunchAd.image = defaultImage;
        [button_cross setHidden:NO];

    }];

}
-(void)GetLaunchAdsFailed:(id)Errorresponses
{
    [button_cross setHidden:NO];

    NSLog(@"GetLaunchAdsFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
    UIImage* defaultImage = [UIImage imageNamed:@"default-launchad"];
    self.LaunchAd.image = defaultImage;

}

#pragma mark- NOTIFICATION HANDLER
- (void)networkNotAvailableNotification:(NSNotification *)note
{
    [button_cross setHidden:NO];

    NSLog(@"Network not available");
    UIImage* defaultImage = [UIImage imageNamed:@"default-launchad"];
    self.LaunchAd.image = defaultImage;


}

@end
