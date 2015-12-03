//
//  FRSForgotPasswordViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSForgotPasswordViewController.h"

@interface FRSForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)sendPasswordButtonClicked:(id)sender;
@end

@implementation FRSForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];
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

- (IBAction)sendPasswordButtonClicked:(id)sender {
    if ([self validateFormSuccess]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        [[FRSNetworkingManager sharedNetworkingManager] forgotPasswordWithEmailID:_emailTextField.text completionBlock:^(id response, NSError *error) {
            
            [HUD hide:NO];
            
            if (!error) {
                [TSMessage showNotificationWithTitle:@"Success" subtitle:@"We have sent you a temporary password. Please check you email." type:TSMessageNotificationTypeWarning];
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
    if (![_emailTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:@"Email" subtitle:@"Please enter your email id." type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_emailTextField.text isValidEmail]) {
        [TSMessage showNotificationWithTitle:@"Email" subtitle:@"Please enter a valid email id." type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    return isValid;
}
@end
