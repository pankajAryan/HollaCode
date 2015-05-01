//
//  AMNetworkClient.m
//  AirtelMoney-Universal
//
//  Created by Agile on 6/17/14.
//  Copyright (c) 2014 Bharti Airtel Limited. All rights reserved.
//
#import "AMNetworkClient.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "UtilityClass.h"

#define BASE_URL @"http://178.62.15.82:8080/Holla/rest/service/"


@implementation AMNetworkClient

@synthesize delegate = _delegate;

#pragma mark - static
+ (AMNetworkClient*)instance {
	static AMNetworkClient* instance = nil;
	
	@synchronized(self) {
		if(instance == nil) {
			instance = [[self alloc] init];
		}
	}
	return(instance);
}

#pragma mark - get updated data
-(void)fetchLaunchAds:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getPopup" :@selector(GetLaunchAdsRequestFinished:) :@selector(GetLaunchAdsFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}
-(void)fetchHomeDetail:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getHome" :@selector(GetHomeRequestFinished:) :@selector(GetHomeFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }
    
}
-(void)fetchClubList:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getClubs" :@selector(GetClubRequestFinished:) :@selector(GetClubFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }
    
}
-(void)fetchMusicCategories:(NSDictionary *)params{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"musicCategory" :@selector(GetMusciCategoriesRequestFinished:) :@selector(GetMusciCategoriesFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }
    
}
-(void)fetchClubDetail:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"clubDetails" :@selector(GetClubDetailRequestFinished:) :@selector(GetClubDetailFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}
-(void)fetchMusicClubs:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getCatgMusic" :@selector(GetMusciClubListRequestFinished:) :@selector(GetMusciClubListFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}
-(void)fetchSmallAds:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getAdImages" :@selector(GetSmallAdRequestFinished:) :@selector(GetSmallAdFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}
-(void)likeCategory:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"fabLike" :@selector(likeCategoriesRequestFinished:) :@selector(likeCategoriesFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}
-(void)fetchEvents:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"eventInCity" :@selector(GetEventListRequestFinished:) :@selector(GetEventListFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }
    
}
-(void)fetchOffers:(NSDictionary *)params
{
    @try {
        //------------------------------------------------------------------------------------------
        [self CreateOperationRequest:@"getOffer" :@selector(GetOffersListRequestFinished:) :@selector(GetOffersListFailed:) :params];
        //------------------------------------------------------------------------------------------
    }
    @catch (NSException *exception)
    {
        [exception raise];
        @throw [NSException exceptionWithName:@"Something is not right exception"
                                       reason:@"Can't perform GetCurrentVersionFailed  operation because of this or that"
                                     userInfo:nil];
    }

}

#pragma mark - Supporting functions
-(void)CreateOperationRequest:(NSString*)requestPath :(SEL)finishDelegateMethod :(SEL)failedDelegateMethod :(NSDictionary*)paramDictionary
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    
    NSMutableURLRequest *request;
    
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];


    request = [httpClient requestWithMethod:@"POST" path:requestPath parameters:paramDictionary];
    
    
    request.timeoutInterval = 60.0;
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSLog(@"DATA: %@", JSON);
        if([_delegate respondsToSelector:finishDelegateMethod])
            [_delegate performSelector:finishDelegateMethod withObject:JSON];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failure Because %@",[error userInfo]);
        
        NSDictionary* errorDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[error code]],@"code",[error localizedDescription],@"messageText", nil];
        
        if([_delegate respondsToSelector:failedDelegateMethod])
            [_delegate performSelector:failedDelegateMethod withObject:errorDictionary];
    }];
    
    
    //----------------------------Starting  Operation--------------------------------------------
    [self startOperation:operation];
    //------------------------------------------------------------------------------------------
}

-(void)startOperation:(AFJSONRequestOperation*)operation
{
    
    if ([UtilityClass isNetworkAvailable])
    {
        [operation start];
    }
    else
    {
        [UtilityClass hideSpinner];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noNetworkAvailable" object:nil];
    }
}
//------------------------------------------------------------------------------------------
//                                         END
//------------------------------------------------------------------------------------------
@end
