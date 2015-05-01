//
//  MusicDetailViewController.m
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MusicMoreInfoViewController.h"
#import "ContainerViewController.h"
#import "MusicCollectionViewCell.h"
#import "DJGalleryCell.h"
#import "UtilityClass.h"
#import "UIImageView+AFNetworking.h"

@interface MusicDetailViewController ()
{

    UIView* DJfrontView ;//= [djcell getFrontview];
    UIView* DJBackView ;//= [djcell getBackview];
    UIButton* btnMOREINFO;
    
    NSMutableArray* backViewVisible;
    NSMutableArray* frontViewVisible;
    
    NSMutableArray* musicClubArray;
    
}
@end

@implementation MusicDetailViewController

@synthesize dict_selectedID;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [musicGrid registerClass:[MusicCollectionViewCell class] forCellWithReuseIdentifier:@"MusicGriddentifier"];
    
    backViewVisible = [[NSMutableArray alloc] init];
    frontViewVisible = [[NSMutableArray alloc] init];

    backSelectedArray = [[NSMutableArray alloc] init];
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        if (dict_selectedID != nil) {
            NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:
                                             [dict_selectedID objectForKey:@"catgId"],@"catgId",
                                             nil];
            
            [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
            [[AMNetworkClient instance] fetchMusicClubs:dict_HomeDetail];

        }
    }

    NSLog(@"Selected Music Category [%@]",dict_selectedID);
    musicClubArray = [[NSMutableArray alloc]init];

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
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return [musicClubArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Indexpath row [%ld]",(long)indexPath.row);
    
    /*
     
     errorCode = 0;
     errorMessage = Success;
     object =     (
     {
     clubId = 1;
     clubImgUrl = "http://128.199.99.127/hollaserver/clubimage/1/club.png";
     clubName = GABBAR;
     }
     );
     */
    // club description not there.
    
    static NSString *CellIdentifier = @"MusicGriddentifier";
    MusicCollectionViewCell *musicCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* clubInfoDict = [musicClubArray objectAtIndex:indexPath.row];
    
    [self fetchClubImage:[clubInfoDict objectForKey:@"clubImgUrl"] :musicCell.imageView :musicCell];
    
    [musicCell.lbl_clubDesc setText:[clubInfoDict objectForKey:@"aboutClub"]];
    
    [musicCell updateCell:indexPath :backSelectedArray];
    
    
    
    return musicCell;
}


-(void)fetchClubImage :(NSString*)ImageURL :(UIImageView*)imageViewForClub :(MusicCollectionViewCell*)cell
{
    [UtilityClass showSpinnerWithMessage:@"fetching data..." :self];
    NSURL *url = [NSURL URLWithString:ImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    DLog(@"Image URL [%@]",ImageURL);
    
    
    
    
    [imageViewForClub setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        imageViewForClub.image = image;
        
        [UtilityClass hideSpinner];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        UIImage* defaultImage = [UIImage imageNamed:@"default-music"];
        [UtilityClass hideSpinner];
        
    }];

}
#pragma mark - COllectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Tagiing %ld",(long)indexPath.row);

    DJfrontView=  [collectionView viewWithTag:indexPath.row+400];
    DJBackView=  [collectionView viewWithTag:indexPath.row+4000];
    
    
    btnMOREINFO=  (UIButton*)[collectionView viewWithTag:indexPath.row+13000];
    [btnMOREINFO addTarget:self action:@selector(moreInfoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"DJfrontView.accessibilityLabel %@",DJfrontView.accessibilityLabel);
    NSLog(@"DJBackView %@",DJBackView.accessibilityLabel);
    
    UIView* view_containerView = [collectionView viewWithTag:(indexPath.row+1000)];
    
    __block BOOL displayingFront = [DJfrontView.accessibilityLabel boolValue];
    
    [UIView transitionWithView:view_containerView
                      duration:1.0
                       options:(displayingFront ? UIViewAnimationOptionTransitionFlipFromRight :
                                UIViewAnimationOptionTransitionFlipFromLeft)
                    animations: ^{
                        if(displayingFront)
                        {
                            DJfrontView.hidden = true;
                            DJBackView.hidden = false;
                            
                            
                            NSString* tagOfCell =[NSString stringWithFormat:@"%ld",indexPath.row];
                            
                            if (![backSelectedArray containsObject:tagOfCell]) {
                                [backSelectedArray addObject:tagOfCell];
                                NSLog(@"Back Array [%@]",backSelectedArray);
                                
                            }

                            
                        }
                        else
                        {
                            DJfrontView.hidden = false;
                            DJBackView.hidden = true;
                            
                            [backSelectedArray removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
                            NSLog(@"Back Array [%@]",backSelectedArray);


                        }
                    }
     
                    completion:^(BOOL finished) {
                        if (finished) {
                            displayingFront = !displayingFront;
                            
                            DJfrontView.accessibilityLabel = [NSString stringWithFormat:@"%@",displayingFront? @"YES" : @"NO"];
                        }
                    }];

}
-(void)moreInfoButtonAction:(id)sender
{
    NSLog(@"%ld",(long)[sender tag]);
    MusicMoreInfoViewController* musicMoreInfo = (MusicMoreInfoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MusicmoreInfoId"];
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    ContainerViewController* ct_vc = (ContainerViewController*)self.parentViewController;
    
    [ct_vc swapFromViewController:[ct_vc.childViewControllers objectAtIndex:0] toViewController:musicMoreInfo];
}
-(void)GetMusciClubListRequestFinished:(id)JSON
{
    
    NSLog(@"GetMusciCategoriesRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0)
    {
        NSArray* clubList = [JSON objectForKey:@"object"];
        
        if ([clubList count]>0 && clubList != nil) {
            [musicClubArray addObjectsFromArray:clubList];
        }
        else
            [musicClubArray removeAllObjects];
        
        [musicGrid reloadData];
    }
}
-(void)GetMusciClubListFailed:(id)Errorresponses
{
    NSLog(@"GetMusciCategoriesFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
}

@end
