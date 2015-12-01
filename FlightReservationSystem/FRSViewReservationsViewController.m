//
//  FRSViewReservations.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSViewReservationsViewController.h"
#import "FRSViewReservationsResponse.h"
#import "FRSViewReservationTableViewCell.h"

static NSString *FRSViewReservationTableViewCell_Identifier = @"FRSViewReservationTableViewCell";

@interface FRSViewReservationsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *reservations;
@end

@implementation FRSViewReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRSViewReservationTableViewCell class]) bundle:nil] forCellReuseIdentifier:FRSViewReservationTableViewCell_Identifier];

    //get reservations
    [self getReservations];

}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];
}

-(void)getReservations{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] getReservationsWithCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSViewReservationsResponse *reservationsResponse = (FRSViewReservationsResponse *)response;
            _reservations = reservationsResponse.reservations;

            [_tableView reloadData];
        }
    }];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _reservations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    FRSViewReservationTableViewCell *reservationsCell = [tableView dequeueReusableCellWithIdentifier:FRSViewReservationTableViewCell_Identifier forIndexPath:indexPath];
    
    FRSReservation *res = _reservations[indexPath.row];
    [reservationsCell configureCellWithReservation:res];
    cell = reservationsCell;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"reservation selected...");
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SegueShowPayment])
    {
        // Get reference to the destination view controller
//        FRSPaymentViewController *vc = [segue destinationViewController];
//        
//        NSString *passengersStr = [self getPassengersString];
//        NSLog(@"passengersStr: %@",passengersStr);
//        
//        _reservation.passengers = passengersStr;
//        _reservation.mobileNumber = _mobileTextField.text;
//        _reservation.address = _addressTextField.text;
//        
//        
//        vc.reservation = _reservation;
        
        // Pass any objects to the view controller here, like...
        //        [vc setMyObjectHere:object];
    }
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
