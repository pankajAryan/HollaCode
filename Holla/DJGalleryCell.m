//
//  DJGalleryCell.m
//  Holla
//
//  Created by Ashish Singal on 18/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "DJGalleryCell.h"

@interface DJGalleryCell()
{

}
@property (nonatomic, strong) IBOutlet UIView *containerview;

@property (nonatomic, strong) IBOutlet UIView *frontView;
@property (nonatomic, strong) IBOutlet UIView *backView;

@property (nonatomic, strong) IBOutlet UIButton *btn_moreInfo;


@property (nonatomic, strong) IBOutlet UILabel *lbl_djname;
@property (nonatomic, strong) IBOutlet UILabel *lbl_djnameFront;
@property (nonatomic, strong) IBOutlet UILabel *lbl_About;

@end


@implementation DJGalleryCell

@synthesize frontView,backView,containerview,btn_moreInfo,lbl_About,lbl_djname,lbl_djnameFront;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DJGalleryCell" owner:self options:nil];
        
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

-(void)updateCell:(NSIndexPath*)indexPath  :(NSMutableArray*)backViewSelectedArray :(NSDictionary*)djDict
{
    /*
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets"];
    NSString *filename = [NSString stringWithFormat:@"%@/%@", sourcePath, self.imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filename];
     */
    
    [self.imageView setImage:[UIImage imageNamed:@"default-dj"]];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    frontView.tag = indexPath.row+400;
    backView.tag = indexPath.row+4000;
    containerview.tag = indexPath.row+1000;
    
    
    btn_moreInfo.tag = indexPath.row + 13000;
    
    frontView.accessibilityLabel = @"YES";
    backView.accessibilityLabel = @"NO";
    
    if (backViewSelectedArray != nil && [backViewSelectedArray count]>0) {
        
        if ([backViewSelectedArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            [backView setHidden:NO];
            [frontView setHidden:YES];
            
            frontView.accessibilityLabel = @"NO";
            backView.accessibilityLabel = @"YES";

        }
        else
        {
            [frontView setHidden:NO];
            [backView setHidden:YES];
            
            frontView.accessibilityLabel = @"YES";
            backView.accessibilityLabel = @"NO";

        }
    }
    
    
    [lbl_djname setText:[djDict objectForKey:@"djName"]];
    [lbl_djnameFront setText:[djDict objectForKey:@"djName"]];
    [lbl_About setText:[djDict objectForKey:@"aboutDj"]];
}
-(UIView*)getFrontview
{
    return frontView;
}

-(UIView*)getBackview
{
    return backView;
}

@end
