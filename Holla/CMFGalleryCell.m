//
//  CMFGalleryCell.m
//  UICollectionGallery
//
//  Created by Tim on 09/04/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMFGalleryCell.h"

@interface CMFGalleryCell()

@property (strong, nonatomic) IBOutlet UILabel *lbl_eventName_clubname;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_time;
@property (strong, nonatomic) IBOutlet UILabel *lbl_address;

@end

@implementation CMFGalleryCell

@synthesize lbl_address,lbl_Date,lbl_eventName_clubname,lbl_time,imageView,clubImagevIew;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CMFGalleryCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}

-(void)updateCell:(NSDictionary*)eventDict
{
    
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets"];
    NSString *filename = [NSString stringWithFormat:@"%@/%@", sourcePath, self.imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filename];
    
    [self.imageView setImage:image];
    //[self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    /*
     
     "evenId":1,
     "clubName":"GABBAR",
     "clubLocation":"Gabbar , Gurgaon",
     "clubLogoUrl":"http://128.199.99.127/hollaserver/clubimage/1/00.jpg",
     "eventName":"Party nights",
     "eventDay":"Monday",
     "eventStartDate":"2015-03-24 00:00:00.0",
     "eventStartTime":"9:00 PM",
     "likeCount":0,
     "fabCount":1,
     "userFabFlag":"N"
     */

    [lbl_eventName_clubname setText:[NSString stringWithFormat:@"%@ @ %@",[eventDict objectForKey:@"eventName"],[eventDict objectForKey:@"clubName"]]];
    [lbl_Date setText:[eventDict objectForKey:@"eventStartDate"]];
    [lbl_time setText:[eventDict objectForKey:@"eventStartTime"]];
    [lbl_address setText:[NSString stringWithFormat:@"at %@",[eventDict objectForKey:@"clubLocation"]]];
    
}

@end
