//
//  FRSReservationDetailViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSReservationDetailViewController.h"
#import "FRSFlightInfoView.h"

@interface FRSReservationDetailViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet FRSFlightInfoView *flightInfoView;

- (IBAction)cancelReservationClicked:(id)sender;

@end

@implementation FRSReservationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateUIDataForReservation];
    [self getFlightInfoFromServer];
    
}
-(void)updateUIDataForReservation{
    
}

-(void)getFlightInfoFromServer{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] getFlightInfoForFlightID:_reservation.flightId withCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSFlight *flight = (FRSFlight *)response;
            [_flightInfoView configureViewWithFlight:flight];
        }
        
    }];

 
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

- (IBAction)cancelReservationClicked:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Cancel Reservation" message:@"Are you sure you wish to cancel this reservation?" delegate:self cancelButtonTitle:@"NO " otherButtonTitles:@"YES", nil] show];
    
}

-(void)proceedToCancel{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] cancelReservationForID:_reservation.reservationId withCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have cancelled your reservation. You will be refunded the amount shortly." type:TSMessageNotificationTypeSuccess];
            
            [self performSelector:@selector(goBackToPreviousView) withObject:nil afterDelay:2];
            
        }
        
    }];
}

-(void)goBackToPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Alert View
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        
    }
    else{
        //Yes.. so proceed to cancel
        [self proceedToCancel];
    }
}
@end
