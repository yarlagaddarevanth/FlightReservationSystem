//
//  FRSPaymentViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSPaymentViewController.h"

@interface FRSPaymentViewController ()
- (IBAction)continueClicked:(id)sender;

@end

@implementation FRSPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];

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

- (IBAction)continueClicked:(id)sender {
    
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];

    /*
     "flightId": 27,
     "flightCode": "UCM1436",
     "noOfPassengers": 3,
     "passengers": "seenu,siva,revanth,dinesh",
     "address": "oak street",
     "mobileNumber": "+181623456789"

     */
    NSDictionary *parameters =[NSDictionary dictionaryWithObjectsAndKeys:
                               _reservation.flight.id,@"flightId",
                               _reservation.flight.flightId,@"flightCode",
                               [NSString stringWithFormat:@"%ld",_reservation.noOfPassengers],@"noOfPassengers",
                               _reservation.passengers,@"passengers",
                               _reservation.address,@"address",
                               _reservation.mobileNumber,@"mobileNumber",
                               nil];
    [[FRSNetworkingManager sharedNetworkingManager] reserveTicketWithParameters:parameters completionBlock:^(id response, NSError *error) {
        [HUD hide:NO];
        
        if (error) {
            [TSMessage showNotificationWithTitle:@"Failed" subtitle:@"Unable to complete reservation. Try again later." type:TSMessageNotificationTypeError];
        }
        else {
            [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have succcessfully reserved the ticket" type:TSMessageNotificationTypeSuccess];
            
            [self performSelector:@selector(goBackToRoot) withObject:nil afterDelay:1.0];
        }
    }];
}

-(void)goBackToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
