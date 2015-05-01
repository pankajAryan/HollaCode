//
//  UtilityClass.m
//  SelfCare
//
//  Created by Agile on 7/25/13.
//  Copyright (c) 2013 Bharti Airtel. All rights reserved.
//
#import "UtilityClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation UtilityClass

#pragma mark- Loading Indicator Methods 
static BOOL _isInternetConnected;
static NSUInteger counter = 1;


 MBProgressHUD* HUD;

NSString *recharge_ContactNumber;
NSDictionary *dic_selectedPlan;

//BOOL flag_IsNumberVerified;
//BOOL IsRegistered;
BOOL IsDataSavedSuccessfuly;

NSString *str_IsNumberVerified;
NSString *str_IsNumberRegistred;
NSString *str_isProfileFetched;
NSString *str_moduleType;
NSString *str_moduleSubCategory;

NSString *str_BillFetchNeeded;
NSString *str_checkImpsEnabled;
NSString *str_BillCaseId;
NSString *str_moduleFlowIndex;

//Chceck Network connection method
+(BOOL)isNetworkAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return false;
        DLog(@"There IS NO internet connection");
        
    } else {
        
        DLog(@"There IS internet connection available");
        return true;
    }
    return false;
}

+(void)updateNetworkStatus:(BOOL)status
{
	_isInternetConnected = status;
}

+(BOOL)isNetworkConnected
{
	return _isInternetConnected;
}

+(void)showAlertwithTitle:(NSString*)Title message:(NSString*)Message
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:Title
                                                      message:Message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

+(void)SaveDatatoUserDefault:(NSDictionary*)Data :(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    DLog(@"%@",Data);
    NSData *dataInArchiveFormat = [NSKeyedArchiver archivedDataWithRootObject:Data];
    [prefs setObject:dataInArchiveFormat forKey:key];
    [prefs synchronize];
    DLog(@"%@",[prefs dictionaryForKey:key]);
}
+(id)RetrieveDataFromUserDefault:(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    id data = [prefs objectForKey:key];
    id data1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    DLog(@"%@",data1);
    return data1;
}
#pragma mark- Screen Size
+ (CGSize)currentScreenBoundsSize {
    return [[UIScreen mainScreen] bounds].size;
}

#pragma mark- spinner methods
//MBProgreeHUD
+ (void)showSpinnerWithMessage:(NSString*)message :(UIViewController*)viewController {
    
     HUD = [[MBProgressHUD alloc] initWithView:viewController.view];
    [viewController.view bringSubviewToFront:HUD];
    HUD.labelText = message;
    HUD.detailsLabelText = @"Please wait...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.dimBackground = YES;
    [viewController.view addSubview:HUD];
    [HUD show:YES];
}
+(void)showHUD
{
    [HUD show:YES];
}

+ (void)hideSpinner {
    if(HUD)
    {
        [HUD hide:YES];
        [HUD removeFromSuperViewOnHide];
        HUD = nil;
    }
}
#pragma mark - Getting User location.
+(CLLocationCoordinate2D )getUserCurrentCoordinate
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    //Added for iOS 8 Support
    if(IS_OS_8_OR_LATER) {
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}
#pragma mark - Navigation Configuration
+(NSDictionary*)getCurrentBalance
{
    NSDictionary* profileStatusCode = [self RetrieveDataFromUserDefault:@"currentBalance"];
    DLog(@"currentBalance = %@",profileStatusCode);
    return profileStatusCode;
}
#pragma mark - Device Id
+(NSString*)getDeviceUDID
{
    NSString* strUDID;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) {
        // iOS 6+
        NSUUID *ide = [[UIDevice currentDevice] identifierForVendor];
        strUDID = [ide UUIDString];
    }// else
    //    strUDID = [[UIDevice currentDevice] uniqueIdentifier];
        // before iOS 6, so just generate an identifier and store it
    return strUDID;
}
+(NSString*)getAPNSToken
{
//    NSData* APNSDataToken = [self RetrieveDataFromUserDefault:@"APNSDeviceToken"];
    NSString* strAPNSToken = [self RetrieveDataFromUserDefault:@"APNSDeviceToken"];
    DLog(@"strAPNSToken = %@",strAPNSToken);
    return strAPNSToken;
}
+(NSString*)getCurrentTimeStamp
{
    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]); // returned as a double
    long digits = (long)time; // this is the first 10 digits
    int decimalDigits = (int)(fmod(time, 1) * 1000 * ++counter); // this will get the 3 missing digits
    //    counter ++;
    long timestamp = (digits ) + decimalDigits;
    NSString *timestampString = [NSString stringWithFormat:@"%ld",timestamp];
    return timestampString;
}
+(NSString*)createUniqueIdentifier
{
    NSString *UniqueIdentifier = [NSString stringWithFormat:@"%@%@",[self getDeviceUDID],[self getCurrentTimeStamp]];
    [UtilityClass SaveDatatoUserDefault:UniqueIdentifier :@"UniqueIdentifier"];
    return UniqueIdentifier;
}
+(NSString*)getUniqueIdentifier
{
    return [UtilityClass RetrieveDataFromUserDefault:@"UniqueIdentifier"];
}
#pragma mark- Random Number
+(NSString *)getRandomNumber:(NSInteger)length
{
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++)
    {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    return returnString;
}

+(NSString *) getRandomAlphanumeric: (int) len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++)
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    
    
    return randomString;
}

#pragma mark- Calling To Help Center
+(void)callToHelpCenterWithNumber:(NSString*)number{
    
    number = @"9971106607";
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:number];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
    } else {
        
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Can't Call using this device. Calling facility not available on this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }
}

#pragma mark- Back to RootViewController
+(void) backAction:(UIViewController*)viewController {
	// Some anything you need to do before leaving
	[viewController.navigationController popViewControllerAnimated:YES];
}
#pragma mark- GET STRING FIRST CHARACTER

+(NSString *)getFirstCharacterOfString:(NSString *)str
{
    NSString *str_FirstChar;
    if([str length]>0)
   {
    str_FirstChar = [str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    str_FirstChar=[[str_FirstChar substringToIndex:1] uppercaseString];
   }
   else
   {
   str_FirstChar=@"";
   }
    return str_FirstChar;
}

#pragma mark-convert NSDictionary  to Json String

+(NSString*)getJsonStringByDictionaryData:(NSDictionary *)dictionaryData
{
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryData options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    NSLog(@"jsonStringjsonString  %@",jsonString);

    return jsonString;
}

#pragma mark-convert Json String  to NSDictionary

+(NSDictionary*)getDictionaryDataByJsonString:(NSString *)jsonStr
{
    //parse ref data and find label
    NSData *Ref1_JsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *Ref1_e;
    NSDictionary *dicByJsonStr = [NSJSONSerialization JSONObjectWithData:Ref1_JsonData options:NSJSONReadingMutableContainers error:&Ref1_e];
    return dicByJsonStr;

}
#pragma mark-GET CONTACT LIST Permission

+(void)getAddressBookPermission
{

ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"Access granted!");
        } else {
            NSLog(@"Access denied!");
        }
    });
}
}


#pragma mark-GET CONTACT LIST NUMBERS
+(NSMutableArray *)getAddressBookList
{
  NSMutableArray  *array_AllContactRecords=[[NSMutableArray alloc]init];

    //1
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook != nil) {
        NSLog(@"Succesful.");
        //2
        NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        //3
        NSUInteger i = 0; for (i = 0; i < [allContacts count]; i++)
        {
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            //4
            NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson,kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            // find all conact number for a person with label
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSString *phoneNumber;
            
            NSMutableDictionary *dic_availableNumbers=[[NSMutableDictionary alloc]init];
            
            //loop for fetching numbers
            for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
                NSString *phone_numer = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                
                if ([phone_numer hasPrefix:@"0"] && [phone_numer length] > 1) {
                    phone_numer = [phone_numer substringFromIndex:1];
                }
                phoneNumber=[NSString stringWithFormat:@"%@",phone_numer];
                
                
                CFStringRef phone_type = ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
                //check label for a number as this is mobile number ,office or work number
                if (phone_type)
                {
                    NSLog(@"phone are :%@", phoneNumber);
                    
                    if (CFEqual(phone_type, kABWorkLabel))
                    /* it's the user's work phone */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"work"];
                    else if (CFEqual(phone_type, kABHomeLabel))
                    /* it's the user's home phone */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"home"];
                    else if (CFEqual(phone_type, kABPersonPhoneMobileLabel))
                    /* other specific cases of your choosing... */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"mobile"];
                    else if (CFEqual(phone_type, kABPersonPhoneIPhoneLabel))
                        [dic_availableNumbers setObject:phoneNumber forKey:@"iPhone"];
                    else
                    /* it's some other label, such as a custom label */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"other"];
                    CFRelease(phone_type);
                }
            }
            
            NSDictionary *dic_ContactAPerson;
            if (lastName != NULL || lastName != nil || lastName != Nil) {
                 dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",lastName,@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            }
            else
            {
                 dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",@"",@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            }
            
        //    NSDictionary *dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",(lastName?@"":@""),@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            
            
          
            [array_AllContactRecords addObject:dic_ContactAPerson];
            
        }
        //8
        CFRelease(addressBook);
    }
    else {
        //9
        NSLog(@"Error reading Address Book");
    }
    
    NSLog(@"array_AllContactRecordsarray_AllContactRecords   %@",array_AllContactRecords);
    return array_AllContactRecords;
}



+(NSMutableArray *)getAddressBookNameAndNumbersOnly{

    NSMutableArray  *array_AllNameAndNumbers = [[NSMutableArray alloc]init];

    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook != nil) {
        NSLog(@"Succesful.");
        //2
        NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        //3
        NSUInteger i = 0; for (i = 0; i < [allContacts count]; i++)
        {
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            //4
            NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson,kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            // find all conact number for a person with label
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSString *phoneNumber;
            
            NSMutableDictionary *dic_availableNumbers=[[NSMutableDictionary alloc]init];
            
            //loop for fetching numbers
            for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
                NSString *phone_numer = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                
                if ([phone_numer hasPrefix:@"0"] && [phone_numer length] > 1) {
                    phone_numer = [phone_numer substringFromIndex:1];
                }
                phoneNumber=[NSString stringWithFormat:@"%@",phone_numer];
                
                
                CFStringRef phone_type = ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
                //check label for a number as this is mobile number ,office or work number
                if (phone_type)
                {
                    NSLog(@"phone are :%@", phoneNumber);
                    
                    if (CFEqual(phone_type, kABWorkLabel))
                    /* it's the user's work phone */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"work"];
                    else if (CFEqual(phone_type, kABHomeLabel))
                    /* it's the user's home phone */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"home"];
                    else if (CFEqual(phone_type, kABPersonPhoneMobileLabel))
                    /* other specific cases of your choosing... */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"mobile"];
                    else if (CFEqual(phone_type, kABPersonPhoneIPhoneLabel))
                        [dic_availableNumbers setObject:phoneNumber forKey:@"iPhone"];
                    else
                    /* it's some other label, such as a custom label */
                        [dic_availableNumbers setObject:phoneNumber forKey:@"other"];
                    CFRelease(phone_type);
                }
            }
            
            NSDictionary *dic_ContactAPerson;
            if (lastName != NULL || lastName != nil || lastName != Nil) {
                dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",lastName,@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            }
            else
            {
                dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",@"",@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            }
            
            //    NSDictionary *dic_ContactAPerson=[NSDictionary dictionaryWithObjectsAndKeys:firstName,@"firstName", fullName,@"fullName",(lastName?@"":@""),@"lastName",fullName,@"fullName",dic_availableNumbers,@"dic_availableNumbers", nil];
            
            for (NSString *key in dic_ContactAPerson.allKeys) {
                
                if ([key isEqualToString:@"dic_availableNumbers"]) {
                    NSDictionary *dictAvailNumbers = [dic_ContactAPerson objectForKey:@"dic_availableNumbers"];
                    
                    for (NSString *numberKey in dictAvailNumbers.allKeys) {
                        NSString *simpleNumber = [self convertAddressBookNumberToSimpleNumber:[dictAvailNumbers objectForKey:numberKey]];
                        
                        NSDictionary *dictNameAndNumber = [NSDictionary dictionaryWithObjectsAndKeys:simpleNumber,@"number",[NSString stringWithFormat:@"%@ %@",[dic_ContactAPerson objectForKey:@"firstName"],[dic_ContactAPerson objectForKey:@"lastName"]],@"name", nil];
                        
                        [array_AllNameAndNumbers addObject:dictNameAndNumber];
                    }
                    
                }
            }
            
         
        }
        //8
        CFRelease(addressBook);
    }
    else {
        //9
        NSLog(@"Error reading Address Book");
    }

    return array_AllNameAndNumbers;
}


//  convert AddressBook Number To Simple Number
+(NSString*)convertAddressBookNumberToSimpleNumber:(NSString *)addressBookNumber
{
   
    addressBookNumber=[addressBookNumber stringByReplacingOccurrencesOfString:@"+91" withString:@""];
    NSString *simpleNumber = [[addressBookNumber componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    DLog(@"simpleNumber   %@",simpleNumber);

    return simpleNumber;
}

#pragma Local Date & Time

+(NSString*)getLocalDateWithFormat:(NSString*)dateformatString{
   
    NSDate* sourceDate = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateformatString];
    
    NSString *date = [dateFormat stringFromDate:sourceDate];
    
    return date;
}

+(NSString*)getPreviousMonthDateFromNowWithFormat:(NSString*)dateFormatString{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setMonth:([components month] - 1)];
    
    NSDate *lastMonthDate = [cal dateFromComponents:components];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormatString];
    
    NSString *date = [dateFormat stringFromDate:lastMonthDate];
    
    return date;
}


+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


+(BOOL)allowEmojiInput:(UITextField*)textfield{
    /*
    BOOL allowEmoji = YES;
    
    if (IS_IOS7_AND_UP) {
        if ([textfield isFirstResponder]) {
            if ([[[textfield textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textfield textInputMode] primaryLanguage]) { // In fact, in iOS7, '[[textField textInputMode] primaryLanguage]' is nil
                allowEmoji = NO;
            }
        }
    } else {
        if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"] ) {
                allowEmoji = NO;
        }
    }
    */
    return YES;
}

@end
