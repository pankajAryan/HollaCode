//
//  MusicCollectionViewCell.m
//  Holla
//
//  Created by Ashish Singal on 31/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "MusicCollectionViewCell.h"
@interface MusicCollectionViewCell()
{
    
}
@property (nonatomic, strong) IBOutlet UIView *containerview;

@property (nonatomic, strong) IBOutlet UIView *frontView;
@property (nonatomic, strong) IBOutlet UIView *backView;

@property (nonatomic, strong) IBOutlet UIButton *btn_moreInfo;

@end

@implementation MusicCollectionViewCell
@synthesize frontView,backView,containerview,btn_moreInfo,imageView,lbl_clubDesc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MusicCollectionViewCell" owner:self options:nil];
        
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

-(void)updateCell:(NSIndexPath*)indexPath  :(NSMutableArray*)backViewSelectedArray{
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    NSLog(@"Tagiing %ld",(long)indexPath.row);
    
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
