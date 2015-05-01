//
//  CMFGalleryCell.h
//  UICollectionGallery
//
//  Created by Tim on 09/04/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMFGalleryCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *clubImagevIew;

-(void)updateCell  :(NSDictionary*)eventDict;

@end
