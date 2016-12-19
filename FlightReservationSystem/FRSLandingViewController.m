//
//  ViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 10/20/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSLandingViewController.h"
#import "AppDelegate.h"

@interface FRSLandingViewController () <UITextFieldDelegate>

@end

@implementation FRSLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInTapped:(id)sender {
    if ([self signinFormValidation]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        [[FRSNetworkingManager sharedNetworkingManager] signInWithUsername:_emailTextField.text andPassword:_passwordTextField.text  completionBlock:^(id response, NSError *error) {
            [HUD hide:NO];
            
            if (error ||[response isKindOfClass:[FRSResponseModel class]]) {
                FRSResponseModel *result = (FRSResponseModel *)response;
                if (error || !result.success) {
                    //need to handle more effectively...
                    
                    return;
                }
                
            }
            //send FRSUser or FRSLoginResponse obj
            FRSLoginResponse *loggedInUser = (FRSLoginResponse *) response;
            if (loggedInUser) {
                
                //get User Details
                [[FRSNetworkingManager sharedNetworkingManager] getUserDetailsWithCompletionBlock:^(id response, NSError *error) {
                    if (!error) {
                        FRSUser *user = (FRSUser *)response;
                        [SHARED_APP_DELEGATE setLoggedInUser:user];
                        [[NSNotificationCenter defaultCenter] postNotificationName:USER_PROFILE_UPDATED_NOTIFICATION object:user];
                        
                        if ([user.role isEqualToString:USER_ROLE_ADMIN]) {
                            [self performSegueWithIdentifier:SegueShowAdminHome sender:nil];
                        }
                        else if ([user.role isEqualToString:USER_ROLE_USER]){
                            [self performSegueWithIdentifier:SeguePushHome sender:nil];
                        }
                        else {
                            //show guest
                            [self showGuestUser];
                        }

                    }

                }];
                

                
                [self removeKeyBoard];
//                [SHARED_APP_DELEGATE updateAccessTokenExpiry];
//                [USER_DEFAULTS setValue:loggedInUser.loginResponse.access_token forKey:USER_ACCESS_TOKEN];
                
//                [USER_DEFAULTS setValue:[(FRSUser *)response getUserDictionaryOfModel] forKey:USER_PROFILE];
                
                
            }
        }];
        
    }
}

- (IBAction)EnterAsGuestTapped:(id)sender {
    [self showGuestUser];
}

-(BOOL)signinFormValidation{
    BOOL isValid = YES;
    if (![_emailTextField.text isValidEmail]) {
        if (_emailTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Email"
                                        subtitle:@"Please fill the Email field."
                                            type:TSMessageNotificationTypeWarning];
        }else
            [TSMessage showNotificationWithTitle:@"Email"
                                        subtitle:@"Please enter a valid email id."
                                            type:TSMessageNotificationTypeWarning];

        isValid = NO;
    }else if (![_passwordTextField.text isValidPassword]){
        if (_passwordTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Password"
                                        subtitle:@"Please enter your password."
                                            type:TSMessageNotificationTypeWarning];

        }else
            [TSMessage showNotificationWithTitle:@"Password"
                                        subtitle:@"Please enter a valid password."
                                            type:TSMessageNotificationTypeWarning];

        isValid = NO;
    }
    return  isValid;
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SeguePushHome])
    {
        // Get reference to the destination view controller
//        FRSAvailableFlightsListViewController *vc = [segue destinationViewController];
        
        
    }
}

#pragma mark - Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self removeKeyBoard];
    return YES;
}

#pragma mark - Guest User
-(void)showGuestUser{
    FRSUser *user = [FRSUser new];
    user.firstName = @"Guest";
    user.lastName = @"";
    user.role = USER_ROLE_GUEST;
    [SHARED_APP_DELEGATE setLoggedInUser:user];
    [self performSegueWithIdentifier:SeguePushHome sender:nil];

}
@end
