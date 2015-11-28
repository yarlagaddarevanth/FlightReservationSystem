//
//  FRSSignUpViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSSignUpViewController.h"

@interface FRSSignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

- (IBAction)signUpTapped:(id)sender;

@end

@implementation FRSSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];
}

- (IBAction)signUpTapped:(id)sender {
    if ([self signinFormValidation]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    _emailTextField.text, @"email",
                                    _passwordTextField.text, @"password",
                                    _firstNameTextField.text, @"firstName",
                                    _lastNameTextField.text, @"lastName",
                                    nil];
        
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
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:USER_PROFILE_UPDATED_NOTIFICATION object:user];
                    }
                    
                }];
                
                
                
                [self removeKeyBoard];
                //                [SHARED_APP_DELEGATE updateAccessTokenExpiry];
                //                [USER_DEFAULTS setValue:loggedInUser.loginResponse.access_token forKey:USER_ACCESS_TOKEN];
                
                //                [USER_DEFAULTS setValue:[(FRSUser *)response getUserDictionaryOfModel] forKey:USER_PROFILE];
                [self performSegueWithIdentifier:SeguePushHome sender:nil];
            }
        }];
        
    }
}

-(BOOL)signinFormValidation{
    BOOL isValid = YES;
    if (![_emailTextField.text isValidEmail]) {
        if (_emailTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Email"
                                        subtitle:@"Please enter your email id."
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

#pragma mark - Text Field
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self removeKeyBoard];
    return YES;
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

@end
