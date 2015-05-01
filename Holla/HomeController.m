//
//  HomeController.m
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "HomeController.h"
#import "CMFGalleryCell.h"
#import "DJGalleryCell.h"
#import "MapControllerViewController.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import <QuartzCore/QuartzCore.h>
#import "DJDetailViewController.h"
#import "ContainerViewController.h"
#import "RootViewController.h"
#import "ViewController.h"
#import "UtilityClass.h"

#import "UIImageView+AFNetworking.h"



@interface HomeController ()
{
    //CGSize dj_size;
    
    CALayer *topLayer, *bottomLayer;
    
    BOOL isFlipped;
    BOOL isTransitioning;
    
    UIView* DJfrontView ;//= [djcell getFrontview];
    UIView* DJBackView ;//= [djcell getBackview];
    UIButton* btnMOREINFO;
    
    IBOutlet UIImageView* musicanimation;
    
    NSMutableArray* backSelectedArray;
    
    NSArray* djArray;
    NSArray* eventArray;

}
-(CALayer *)visibleLayer;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *DjcollectionView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) int currentIndex;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view, typically from a nib.
    [self loadImages];
    [self setupCollectionView];
    
    isFlipped = NO;
    
    topLayer.doubleSided = NO;
    topLayer.name = @"1";
    
    bottomLayer.doubleSided = NO;
    bottomLayer.name = @"2";
    
    // Timer for updating time
    [NSTimer scheduledTimerWithTimeInterval:30.0f
                                     target:self
                                   selector:@selector(moveEventBanner:)
                                   userInfo:nil
                                    repeats:YES];
    

    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSInteger animationImageCount = 4;
    for (int i = 1; i <= animationImageCount; i++) {
        NSString* imageName = [NSString stringWithFormat:@"ic-audio-0%d", i];
        [images addObject:[UIImage imageNamed:imageName]];
    }
    musicanimation.animationImages = images;
    musicanimation.animationDuration = 0.5;
    musicanimation.animationRepeatCount = 10000;
    [musicanimation startAnimating];

    
    backSelectedArray = [[NSMutableArray alloc] init];
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:@"70.2",@"curr_lat",
                                         @"70.2",@"curr_Long",
                                         @"2",@"cityId",
                                         [UtilityClass getDeviceUDID],@"deviceId",

                                         nil];
        
        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchHomeDetail:dict_HomeDetail];
    }
    
    
    djArray = [[NSArray alloc]init];
    eventArray = [[NSArray alloc]init];
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
#pragma mark UICollectionView methods

- (NSMutableArray *) generateSampleUIViews:(NSUInteger) number width:(CGFloat) wd {
 
    NSMutableArray *views_list = [[NSMutableArray alloc] init];
    
    for (NSUInteger k = 0; k < number; k++) {
        
        UIImageView *back_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, wd, self.collectionView.frame.size.height)];
        back_view.contentMode = UIViewContentModeScaleAspectFit;
        
        switch (k%2) {
            case 0:
                back_view.image = [UIImage imageNamed:@"banner1"];
                break;
                
            case 1:
                back_view.image = [UIImage imageNamed:@"banner2"];
                break;
                
            default:
                break;
        }
        
        [views_list addObject: back_view];
        
    }
    
    return views_list;
}

-(void)setupCollectionView
{
    
    // Temporary **********
    
    CGRect frame = self.collectionView.frame;
    frame.origin.x = 10;
    frame.origin.y -= 40;
    frame.size.width -= 20;
    frame.size.height -= 20;
    
    // Short 3-page Scrollview
    threePageScrollView = [[DMCircularScrollView alloc] initWithFrame:frame];
    threePageScrollView.pageWidth = frame.size.width;
    threePageScroller_Views = [self generateSampleUIViews:3 width:frame.size.width];
    pageControl.numberOfPages = threePageScroller_Views.count;
    
    [threePageScrollView setPageCount:[threePageScroller_Views count]
                       withDataSource:^UIView *(NSUInteger pageIndex) {
                           pageControl.currentPage = pageIndex;

                           return [threePageScroller_Views objectAtIndex:pageIndex];
                       }];
    
    // How to handle page events change
    /*scrollView.handlePageChange =  ^(NSUInteger currentPageIndex,NSUInteger previousPageIndex) {
     NSLog(@"PAGE HAS CHANGED. CURRENT PAGE IS %d (prev=%d)",currentPageIndex,previousPageIndex);
     };*/
    
//   [threePageScrollView addSubview:pageControl];
    [self.view addSubview:threePageScrollView];
    [self.view bringSubviewToFront:pageControl];

    
    // *********************
    
    
    [self.collectionView registerClass:[CMFGalleryCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    [self.DjcollectionView registerClass:[DJGalleryCell class] forCellWithReuseIdentifier:@"DJCellIdentifier"];
    
    UICollectionViewFlowLayout *DjflowLayout = [[UICollectionViewFlowLayout alloc] init];
    [DjflowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [DjflowLayout setMinimumInteritemSpacing:10.0f];
    [DjflowLayout setMinimumLineSpacing:10.0f];
    [self.DjcollectionView setPagingEnabled:YES];
    [self.DjcollectionView setCollectionViewLayout:DjflowLayout];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView.tag == 100)
        return [eventArray count];
    else
        return [djArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 100)
    {
        CMFGalleryCell *cell = (CMFGalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        
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
        NSDictionary* eventDictionary = [eventArray objectAtIndex:indexPath.row];
/*
        NSString* evenId = [eventDictionary objectForKey:@"evenId"];
        NSString* clubName = [eventDictionary objectForKey:@"clubName"];
        NSString* clubLocation = [eventDictionary objectForKey:@"clubLocation"];
        NSString* clubLogoUrl = [eventDictionary objectForKey:@"clubLogoUrl"];
        NSString* eventName = [eventDictionary objectForKey:@"eventName"];
        NSString* eventDay = [eventDictionary objectForKey:@"eventDay"];
        NSString* eventStartDate = [eventDictionary objectForKey:@"eventStartDate"];
        NSString* eventStartTime = [eventDictionary objectForKey:@"eventStartTime"];
        NSString* likeCount = [eventDictionary objectForKey:@"likeCount"];
        NSString* fabCount = [eventDictionary objectForKey:@"fabCount"];
        NSString* userFabFlag = [eventDictionary objectForKey:@"userFabFlag"];
 
 //event image url is not given in the response
 //event startdate is not in correct format in UI its only 15 mar
 //likecount and fabcount should be in string
*/
        NSString *imageName = [self.dataArray objectAtIndex:indexPath.row];
        [cell setImageName:imageName];
        [cell updateCell :eventDictionary];
        
      //  [self fetchClubImage:[eventDictionary objectForKey:@"clubLogoUrl"] :cell.imageView];
        NSString* image_eventUrl = [eventDictionary objectForKey:@"clubLogoUrl"];
        
        if (![image_eventUrl isEqual:[NSNull null]])
            [self fetchClubImage:image_eventUrl :cell.clubImagevIew];
        else
            cell.clubImagevIew.image = [UIImage imageNamed:@"default-dj"];
        
        
        
        return cell;
    }
    else
    {
        /*
         "djId":1,
         "djName":"XYZ",
         "djImgUrl":"img_url",
         "aboutDj":"Good musician , play gutar,drum etc",
         "likeCount":1,
         "fabCount":1,
         "userFabFlag":"N",
         "djCatg":"music masti and dj"

         */
        
        NSLog(@"DJ TAG ROW [%ld] Section [%ld]",indexPath.row,indexPath.section);
        
        DJGalleryCell *djcell = (DJGalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DJCellIdentifier" forIndexPath:indexPath];
        
        NSDictionary* djDictionary = [djArray objectAtIndex:indexPath.row];
/*
        NSString* djId = [djDictionary objectForKey:@"djId"];
        NSString* djName = [djDictionary objectForKey:@"djName"];
        NSString* djImgUrl = [djDictionary objectForKey:@"djImgUrl"];
        NSString* aboutDj = [djDictionary objectForKey:@"aboutDj"];
        NSString* likeCount = [djDictionary objectForKey:@"likeCount"];
        NSString* fabCount = [djDictionary objectForKey:@"fabCount"];
        NSString* userFabFlag = [djDictionary objectForKey:@"userFabFlag"];
        NSString* djCatg = [djDictionary objectForKey:@"djCatg"];
*/
        [djcell updateCell:indexPath :backSelectedArray :djDictionary];
        
        NSString* image_ofDJUrl = [djDictionary objectForKey:@"djImgUrl"];
        
        if (![image_ofDJUrl isEqual:[NSNull null]])
            [self fetchClubImage:image_ofDJUrl :djcell.imageView];
        else
            djcell.imageView.image = [UIImage imageNamed:@"default-dj"];

        
        return djcell;
    }
}

-(void)fetchClubImage :(NSString*)ImageURL :(UIImageView*)imageViewForClub
{
   // [UtilityClass showSpinnerWithMessage:@"fetching data..." :self];
    NSURL *url = [NSURL URLWithString:ImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DLog(@"Image URL [%@]",ImageURL);
    
    [imageViewForClub setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"default-club"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        imageViewForClub.image = image;
        
        [UtilityClass hideSpinner];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        UIImage* defaultImage = [UIImage imageNamed:@"default-club"];
        [UtilityClass hideSpinner];
        
    }];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CGSize dj_size = CGSizeMake(148, 148);

    if (collectionView.tag == 100) {
        return self.collectionView.frame.size;
    }
    else 
        return dj_size;

}
#pragma mark - Collectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath  row %ld section %ld",(long)indexPath.row,(long)indexPath.section);
    
    
    if (collectionView.tag == 100)
    {
        NSArray* viewControllers = [self.navigationController viewControllers];
        DLog(@"viewControllers [%@]",viewControllers);
        DLog(@"parentViewController [%@]",self.parentViewController);
        
        RootViewController* rootVc = (RootViewController*)[viewControllers objectAtIndex:1];
        [rootVc.view bringSubviewToFront:rootVc.view_forEventClubDetail];
        
        [UIView animateWithDuration:0.6 animations:^{
            [rootVc.view_forEventClubDetail setHidden:NO];
        }];
    }

    
    if (collectionView.tag == 101)
    {

        DJfrontView=  [collectionView viewWithTag:indexPath.row+400];
        DJBackView=  [collectionView viewWithTag:indexPath.row+4000];
        
        
        btnMOREINFO=  (UIButton*)[collectionView viewWithTag:indexPath.row+13000];
        [btnMOREINFO addTarget:self action:@selector(moreInfoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        

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
    
}

#pragma mark Data methods
-(void)loadImages {
    
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets"];
    self.dataArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error:NULL];
    
}
#pragma mark - Button Actions
-(IBAction)gotoMapButtonAction:(id)sender
{
    //take instance of next uiviewcontroller with storu board view
    MapControllerViewController *vc_map = (MapControllerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MapControllerViewControllerId"];
    
    [self.navigationController pushViewController:vc_map animated:YES];
}
-(IBAction)playAppSongAction:(id)sender
{
   
    
    
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    
    ViewController* baseVC = [viewControllers objectAtIndex:0];
    
    if (baseVC.audioPlayer != nil) {
        if ([baseVC.audioPlayer isPlaying])
        {
            [baseVC.audioPlayer stop];
            [musicanimation stopAnimating];
            [musicanimation setImage:[UIImage imageNamed:@"ic-audio-01"]];
        }
        else
        {
            [baseVC.audioPlayer play];
            [musicanimation startAnimating];
            
        }
    }
}

-(void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    isFlipped = !isFlipped;
    isTransitioning = NO;
}
-(CALayer *)visibleLayer
{
    return (isFlipped ? bottomLayer : topLayer);
}

-(void)moveEventBanner: (NSTimer *) timer {
    
   NSDate* currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTimeString = [dateFormatter stringFromDate:currentTime];
    NSLog(@"Current Time %@",currentTimeString);
    NSArray* arraycurrentIDPath = [self.collectionView indexPathsForVisibleItems];
    NSLog(@"idPath %@",arraycurrentIDPath);
    
    if ([arraycurrentIDPath count] != 0) {
        NSIndexPath* currentIdPath = [arraycurrentIDPath objectAtIndex:0];
        if (currentIdPath.row == ([self.dataArray count]-1)) {
            NSIndexPath* idPath = [NSIndexPath indexPathForItem:0 inSection:0];
            
            [self.collectionView scrollToItemAtIndexPath:idPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        else
        {
            
            NSIndexPath* idPath = [NSIndexPath indexPathForItem:currentIdPath.row+1 inSection:0];
            
            [self.collectionView scrollToItemAtIndexPath:idPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }

    }
    
}

-(void)moreInfoButtonAction:(id)sender
{
    NSLog(@"%ld",(long)[sender tag]);
    DJDetailViewController* djdetail = (DJDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"DJDetailViewControllerid"];
    
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    ContainerViewController* ct_vc = (ContainerViewController*)self.parentViewController;
    
    [ct_vc swapFromViewController:[ct_vc.childViewControllers objectAtIndex:0] toViewController:djdetail];
}

-(void)GetHomeRequestFinished:(id)JSON
{
    
    NSLog(@"GetHomeRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        djArray = [[JSON objectForKey:@"object"] objectForKey:@"djs"];
        
        eventArray = [[JSON objectForKey:@"object"] objectForKey:@"events"];
        
        [self.DjcollectionView reloadData];
        [self.collectionView reloadData];
    }
}

-(void)GetHomeFailed:(id)Errorresponses
{
    
    NSLog(@"GetHomeFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
    
    
}

@end
