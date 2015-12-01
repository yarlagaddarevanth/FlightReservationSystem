//
//  FRSReservationDetailViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSReservationDetailViewController.h"
#import "FRSFlightInfoView.h"

@interface FRSReservationDetailViewController ()
@property (weak, nonatomic) IBOutlet FRSFlightInfoView *flightInfoView;
@property (weak, nonatomic) IBOutlet UILabel *userid;
@property (weak, nonatomic) IBOutlet UILabel *numberofPassengers;
@property (weak, nonatomic) IBOutlet UILabel *passengers;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *dateofJourney;

- (IBAction)cancelReservationClicked:(id)sender;

@end

@implementation FRSReservationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [_flightInfoView configureViewWithFlight:<#(FRSFlight *)#>];
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
    
}

@end
