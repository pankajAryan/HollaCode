//
//  DJGalleryCell.h
//  Holla
//
//  Created by Ashish Singal on 18/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJGalleryCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

-(void)updateCell:(NSIndexPath*)indexPath  :(NSMutableArray*)backViewSelectedArray :(NSDictionary*)djDict;
-(UIView*)getFrontview;
-(UIView*)getBackview;

@end
