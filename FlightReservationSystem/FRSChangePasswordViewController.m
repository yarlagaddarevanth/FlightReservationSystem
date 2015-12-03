//
//  FRSChangePasswordViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSChangePasswordViewController.h"

@interface FRSChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tempPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *newwPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)changePasswordButtonClicked:(id)sender;

@end

@implementation FRSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePasswordButtonClicked:(id)sender {
    if ([self validateFormSuccess]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        [[FRSNetworkingManager sharedNetworkingManager] resetPassword:_newwPasswordTextField.text withCode:_tempPasswordTextField.text completionBlock:^(id response, NSError *error) {
            [HUD hide:NO];
            
            if (!error) {
                [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have successfully changed you password. You can now Sign In using your new password." type:TSMessageNotificationTypeSuccess];
                [self performSelector:@selector(goBackToPreviousVC) withObject:nil afterDelay:1.5];
            }

        }];
        
    }
}

-(void)goBackToPreviousVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(BOOL)validateFormSuccess{
    BOOL isValid = YES;
    if (![_tempPasswordTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:@"Temporary Password" subtitle:@"Please enter your temporary password." type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_newwPasswordTextField.text isValidPassword]) {
        [TSMessage showNotificationWithTitle:@"New Password" subtitle:@"Please enter a valid password." type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_confirmPasswordTextField.text isValidPassword]) {
        [TSMessage showNotificationWithTitle:@"Confirm Password" subtitle:@"Please re-enter new password in the Confirm Password field." type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_confirmPasswordTextField.text isEqualToString:_newwPasswordTextField.text]) {
        [TSMessage showNotificationWithTitle:@"Passwords not Matching"
                                    subtitle:@"Password and Confirm Password do not match."
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    return isValid;
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
