//
//  RootViewController.h
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"

@interface RootViewController : UIViewController<UITextFieldDelegate,IQActionSheetPickerViewDelegate>
{
    IBOutlet UIImageView* arrowView;
    
    IBOutlet UIView* containerView;
    
    IBOutlet UIView* searchView;
    IBOutlet UILabel* lbl_searchedText;
    IBOutlet UITextField* txt_searchTextfield;

    IBOutlet UIButton* btn_search;
    IBOutlet UIButton* btn_menu;
   __weak IBOutlet UIView* view_evenDetailMenu;
    __weak IBOutlet UIView* filerView;
    
    IBOutlet UILabel* lbl_mostpopular;
    IBOutlet UILabel* lbl_highestbookmark;
    IBOutlet UILabel* lbl_freeEntry;
    IBOutlet UILabel* lbl_specialOffers;

    IBOutlet UIButton* button_2km;
    IBOutlet UIButton* button_5km;
    IBOutlet UIButton* button_10km;
    IBOutlet UIButton* button_20km;
    IBOutlet UIButton* button_50km;
    IBOutlet UIScrollView* scroll_filter;
    IBOutlet UIButton* button_myBookmarks;
    IBOutlet UIButton* button_aboutUs;
    IBOutlet UIButton* button_TermsCondition;

    IBOutlet UIButton* button_StateSelection;

    
    
}
@property (weak, nonatomic) IBOutlet UIView *view_forEventClubDetail;
@property (weak, nonatomic) IBOutlet UIButton *button_home;


@property (nonatomic,weak)   UIView* view_evenDetailMenu;

@end
