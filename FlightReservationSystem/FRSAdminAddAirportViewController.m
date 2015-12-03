//
//  FRSManageDestinationViewController.m
//  FlightReservationSystem
//
//  Created by laksmikanth somavarapu on 25/11/2015.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAdminAddAirportViewController.h"

@interface FRSAdminAddAirportViewController ()
@property (weak, nonatomic) IBOutlet UITextField *airportCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *airportNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;

- (IBAction)addAirportClicked:(id)sender;
@end

@implementation FRSAdminAddAirportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
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

- (IBAction)addAirportClicked:(id)sender {
    if ([self addAirportFormValidationSuccess]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    _airportCodeTextField.text,@"airportCode",
                                    _airportNameTextField.text,@"airportName",
                                    _countryTextField.text,@"country",
                                    nil];
        [[FRSNetworkingManager sharedNetworkingManager] addAirportByAdminWithParameters:parameters completionBlock:^(id response, NSError *error) {
            
            [HUD hide:NO];
            
            if (!error) {
//                FRSResponseModel *responseModel = (FRSResponseModel *)response;
                [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have successfully added an Airport. You can add more!" type:TSMessageNotificationTypeSuccess];
                
                _airportCodeTextField.text = @"";
                _airportNameTextField.text = @"";
                _countryTextField.text = @"";
            }
        }];

    }
}

-(BOOL)addAirportFormValidationSuccess{
    BOOL isValid = YES;
    if (![_airportCodeTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:@"Airport Code"
                                    subtitle:@"Please enter Airport Code."
                                        type:TSMessageNotificationTypeWarning];
        
        isValid = NO;
    
    }else if (![_airportNameTextField.text isValid]){
        [TSMessage showNotificationWithTitle:@"Airport Name"
                                    subtitle:@"Please enter Airport Name."
                                        type:TSMessageNotificationTypeWarning];

        isValid = NO;
    }else if (![_countryTextField.text isValid]){
        [TSMessage showNotificationWithTitle:@"Country"
                                    subtitle:@"Please enter Country Name."
                                        type:TSMessageNotificationTypeWarning];
        
        isValid = NO;
    }
    return  isValid;
}

@end
