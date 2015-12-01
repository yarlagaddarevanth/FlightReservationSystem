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
#import "FRSReservationDetailViewController.h"

static NSString *FRSViewReservationTableViewCell_Identifier = @"FRSViewReservationTableViewCell";

@interface FRSViewReservationsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) FRSReservation *reservationSelected;
@property (nonatomic) NSArray *reservations;
@end

@implementation FRSViewReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRSViewReservationTableViewCell class]) bundle:nil] forCellReuseIdentifier:FRSViewReservationTableViewCell_Identifier];

    //get reservations
    [self getReservations];

    [self.tap setCancelsTouchesInView:NO];

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
    
    FRSReservation *reservation = _reservations[indexPath.row];
    
    [reservationsCell configureCellWithReservation:reservation];
    cell = reservationsCell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"reservation selected...");
    FRSReservation *reservation = _reservations[indexPath.row];
    _reservationSelected = reservation;
    
    [self performSegueWithIdentifier:SegueShowViewReservations sender:self];
    //Show Reservation Detail.
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SegueShowViewReservations])
    {
        // Get reference to the destination view controller
        FRSReservationDetailViewController *vc = [segue destinationViewController];
        
        vc.reservation = _reservationSelected;
        
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
