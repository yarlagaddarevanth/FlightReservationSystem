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
    if ([self signUpFormValidation]) {
        
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    _emailTextField.text, @"email",
                                    _emailTextField.text, @"userName",
                                    USER_ROLE_USER, @"role",
                                    _passwordTextField.text, @"password",
                                    _firstNameTextField.text, @"firstName",
                                    _lastNameTextField.text, @"lastName",
                                    nil];
        
        
        [[FRSNetworkingManager sharedNetworkingManager] signUpUserWithParameters:parameters completionBlock:^(id response, NSError *error) {
            
            [HUD hide:NO];
            
            [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You're now signed up. Please Sign in now." type:TSMessageNotificationTypeSuccess];
            
            [self performSelector:@selector(goBackToSignInScreen) withObject:nil afterDelay:1.0];
            
        }];
        
    }
}

-(void)goBackToSignInScreen{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)signUpFormValidation{
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
    }
    else if (![_passwordTextField.text isValidPassword]){
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
    else if (![_confirmPasswordTextField.text isValidPassword]){
        if (_confirmPasswordTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Confirm Password"
                                        subtitle:@"Please enter a valid password."
                                            type:TSMessageNotificationTypeWarning];
            
        }else if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]){
            [TSMessage showNotificationWithTitle:@"Passwords not Matching"
                                        subtitle:@"Password and Confirm Password do not match."
                                            type:TSMessageNotificationTypeWarning];

        }
        else [TSMessage showNotificationWithTitle:@"Confirm Password"
                                        subtitle:@"Please re-enter your password in the Confirm Password field."
                                            type:TSMessageNotificationTypeWarning];
        
        isValid = NO;
    }
    else if (![_firstNameTextField.text isValid]){
        [TSMessage showNotificationWithTitle:@"First Name"
                                    subtitle:@"Please enter your First Name."
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_lastNameTextField.text isValid]){
        [TSMessage showNotificationWithTitle:@"Last Name"
                                    subtitle:@"Please enter your Last Name."
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
