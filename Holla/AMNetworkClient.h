//
//  AMNetworkClient.h
//
//  Created by Agile on 6/17/14.
//

#import <Foundation/Foundation.h>

@class AFHTTPClient;
@class AFJSONRequestOperation;

@protocol APIInvokerDelegate <NSObject>

@optional
//===============================================================================
//	 Get Updated Data
//===============================================================================
-(void)GetLaunchAdsRequestFinished:(id)JSON;
-(void)GetLaunchAdsFailed:(id)Errorresponses;

-(void)GetHomeRequestFinished:(id)JSON;
-(void)GetHomeFailed:(id)Errorresponses;

-(void)GetClubRequestFinished:(id)JSON;
-(void)GetClubFailed:(id)Errorresponses;

-(void)GetClubDetailRequestFinished:(id)JSON;
-(void)GetClubDetailFailed:(id)Errorresponses;

-(void)GetMusciCategoriesRequestFinished:(id)JSON;
-(void)GetMusciCategoriesFailed:(id)Errorresponses;

-(void)GetMusciClubListRequestFinished:(id)JSON;
-(void)GetMusciClubListFailed:(id)Errorresponses;

-(void)GetEventListRequestFinished:(id)JSON;
-(void)GetEventListFailed:(id)Errorresponses;

-(void)GetOffersListRequestFinished:(id)JSON;
-(void)GetOffersListFailed:(id)Errorresponses;

-(void)GetSmallAdRequestFinished:(id)JSON;
-(void)GetSmallAdFailed:(id)Errorresponses;

-(void)likeCategoriesRequestFinished:(id)JSON;
-(void)likeCategoriesFailed:(id)Errorresponses;

@end

@interface AMNetworkClient : NSObject
{
    @private
    id <APIInvokerDelegate> __unsafe_unretained  delegate;
}
@property(nonatomic, weak) id<APIInvokerDelegate> delegate;
+ (AMNetworkClient*)instance;
//===============================================================================
-(void)fetchLaunchAds:(NSDictionary *)params;
//===============================================================================
-(void)fetchHomeDetail:(NSDictionary *)params;
//===============================================================================
-(void)fetchClubList:(NSDictionary *)params;
//===============================================================================
-(void)fetchClubDetail:(NSDictionary *)params;
//===============================================================================
-(void)fetchMusicCategories:(NSDictionary *)params;
//===============================================================================
-(void)fetchMusicClubs:(NSDictionary *)params;
//===============================================================================
-(void)fetchEvents:(NSDictionary *)params;
//===============================================================================
-(void)fetchOffers:(NSDictionary *)params;
//===============================================================================
-(void)fetchSmallAds:(NSDictionary *)params;

//===============================================================================
-(void)likeCategory:(NSDictionary *)params;

@end
