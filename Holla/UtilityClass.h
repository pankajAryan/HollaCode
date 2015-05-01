//
//  UtilityClass.h
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

//#define screenSizeWithoutHeader  self.view.frame.size.height-64
#define screenSize  self.view.frame.size.height

@class Encription;
@interface UtilityClass : NSObject
{

}

extern NSString *recharge_ContactNumber;
extern NSDictionary *dic_selectedPlan;

//flag for find number is Verified or not
//extern BOOL flag_IsNumberVerified;
//extern BOOL IsRegistered;
extern BOOL IsDataSavedSuccessfuly;

//string flag for registration
extern NSString *str_IsNumberVerified;
extern NSString *str_IsNumberRegistred;
extern NSString *str_isProfileFetched;

extern MBProgressHUD* HUD;

//extern for module type
extern NSString *str_moduleType;
extern NSString *str_moduleSubCategory;

//extern for module type
extern NSString *str_BillFetchNeeded;

//extern for module type
extern NSString *str_BillCaseId;

//extern for module type
extern NSString *str_moduleFlowIndex;


//extern for check Imps Enabled or not
extern NSString *str_checkImpsEnabled;

//Check Wether network is reachable or not
+(BOOL)isNetworkAvailable;
+(void)updateNetworkStatus:(BOOL)status;
+(BOOL)isNetworkConnected;

//Data from userdefaults
//For retrieving data from nsuserdefault
+(id)RetrieveDataFromUserDefault:(NSString*)key;

//Save data to nsuser default
+(void)SaveDatatoUserDefault:(id)Data :(NSString*)key;

//show alert to users
+(void)showAlertwithTitle:(NSString*)Title message:(NSString*)Message;

//get current screen size of the device.
+(CGSize)currentScreenBoundsSize;

//loading spinner messages
+ (void)hideSpinner;
+(void)showSpinnerWithMessage:(NSString*)message :(UIViewController*)viewController;

//getting user coordinate
+(CLLocationCoordinate2D )getUserCurrentCoordinate;

//get current balance
+(NSDictionary*)getCurrentBalance;

//get current balance
+(NSString*)getDeviceUDID;
/**
 *  This method will give you random number.
 *
 *  @param length number of digit you want.
 *
 *  @return random number
 */
+(NSString *)getRandomNumber:(NSInteger)length;
/**
 *  back Action
 *
 *  @param viewController controller which you want to be popped out.
 */

+(void) backAction:(UIViewController*)viewController;
/**
 *  This method will give you random number.
 *
 *  @param length number of digit you want.
 *
 *  @return random number
 */
+(NSString *) getRandomAlphanumeric: (int) len;

/**
 *  FUNCTION FOR GET FIRST CHARECTER OF STRING
 */

+(NSString *)getFirstCharacterOfString:(NSString *)str;
/**
 *
 *  @return Returning APNS TOKEN
 */
+(NSString*)getAPNSToken;

/**
 *  convert NSDictionary  to Json String
 */
+(NSString*)getJsonStringByDictionaryData:(NSDictionary *)dictionaryData;

/**
 *  convert Json String  to NSDictionary
 */
+(NSDictionary*)getDictionaryDataByJsonString:(NSString *)jsonStr;
+(NSString*)getCurrentTimeStamp;
+(NSString*)getUniqueIdentifier;
+(NSString*)createUniqueIdentifier;
/**
 *  Get Address book Contact and suooprted method
 */
+(NSMutableArray *)getAddressBookList;
+(NSMutableArray *)getAddressBookNameAndNumbersOnly;

+(void)getAddressBookPermission;
+(NSString*)convertAddressBookNumberToSimpleNumber:(NSString *)addressBookNumber;

// Get Local Date and Time
+(NSString*)getLocalDateWithFormat:(NSString*)dateformatString;
+(NSString*)getPreviousMonthDateFromNowWithFormat:(NSString*)dateFormatString;

+(BOOL) NSStringIsValidEmail:(NSString *)checkString;

//call Airtel Money Helpdesk
+(void)callToHelpCenterWithNumber:(NSString*)number;

+(BOOL)allowEmojiInput:(UITextField*)textfield;

@end
