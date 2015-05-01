//
// IQActionSheetPickerView.h
// Created by Pankaj Yadav on 22/6/14.
// Copyright (c) 2014 AgileLab. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum IQActionSheetPickerStyle
{
    IQActionSheetPickerStyleTextPicker,
    IQActionSheetPickerStyleDatePicker
}IQActionSheetPickerStyle;

@class IQActionSheetPickerView;

@protocol IQActionSheetPickerViewDelegate <UIActionSheetDelegate>

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;

@end

@interface IQActionSheetPickerView : UIActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>
{
@private
    UIPickerView    *_pickerView;
    UIDatePicker    *_datePicker;
    UIToolbar       *_actionToolbar;
}

//- (id)initWithTitle:(NSString *)title delegate:(id<IQActionSheetPickerViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,assign) id<IQActionSheetPickerViewDelegate> delegate; // weak reference
@property(nonatomic, assign) IQActionSheetPickerStyle actionSheetPickerStyle;   //Default is IQActionSheetPickerStyleTextPicker;

/*for IQActionSheetPickerStyleTextPicker*/
@property(nonatomic, assign) BOOL isRangePickerView;
@property(nonatomic, strong) NSArray *titlesForComponenets;
@property(nonatomic, strong) NSArray *widthsForComponents;
@property(nonatomic, strong) NSArray *selectedTitles;
-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated;
/*for IQActionSheetPickerStyleDatePicker*/
@property(nonatomic, assign) NSDateFormatterStyle dateStyle;    //returning date string style.
@property(nonatomic, assign) NSDate *date; //get/set date.
-(void)setDate:(NSDate *)date animated:(BOOL)animated;

/*for Both picker styles*/
-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated;

@end