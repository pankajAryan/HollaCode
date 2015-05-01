//
//  MusicDetailViewController.h
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMNetworkClient.h"

@interface MusicDetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,APIInvokerDelegate>
{
   IBOutlet UICollectionView* musicGrid;
    NSMutableArray* backSelectedArray;

}
@property (nonatomic,retain) NSDictionary* dict_selectedID;

@end
