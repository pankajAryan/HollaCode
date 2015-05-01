//
//  MapControllerViewController.m
//  Holla
//
//  Created by Ashish Singal on 19/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "MapControllerViewController.h"
//#import<GoogleMaps/GoogleMaps.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapControllerViewController ()
{
    IBOutlet GMSMapView* mapView;
   // IBOutlet UIView* mapviewcontainer;

}

@end

@implementation MapControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMSCameraPosition * camera = [GMSCameraPosition cameraWithLatitude:22.59 longitude:88.2636 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
   // [mapviewcontainer addSubview:mapView];
    
    GMSMarker* marker = [[GMSMarker alloc] init];
    marker.position =CLLocationCoordinate2DMake(22.59, 88.2636);
    marker.title = @"New Delhi";
    marker.snippet = @"kolkatta";
    marker.map = mapView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)bakcAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
