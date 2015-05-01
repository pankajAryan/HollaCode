//
//  TermsAndConditionViewController.m
//  Holla
//
//  Created by Development on 5/2/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "TermsAndConditionViewController.h"

@interface TermsAndConditionViewController ()

@end

@implementation TermsAndConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backAction :(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
