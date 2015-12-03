//
//  FRSAvailableFlightsListViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAvailableFlightsListViewController.h"
#import "FRSFlightInfoTableViewCell.h"
#import "FRSReservationStep2Viewcontroller.h"

static NSString *FRSFlightInfoTableViewCell_Identifier = @"FRSFlightInfoTableViewCell";

@interface FRSAvailableFlightsListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) FRSFlight *flightSelected;

@end

@implementation FRSAvailableFlightsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRSFlightInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:FRSFlightInfoTableViewCell_Identifier];
    
    [self.tap setCancelsTouchesInView:NO];

}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _flightsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    FRSFlightInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:FRSFlightInfoTableViewCell_Identifier forIndexPath:indexPath];
    
    FRSFlight *flight = [_flightsArray objectAtIndex:indexPath.row];

    [infoCell configureCellWithFlight:flight];
    
//    [singleLineCell configureCellWithVM:cellVM];
    cell = infoCell;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"aaaaaaaaa");
    
    _flightSelected = [_flightsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:SegueShowReservationStep2 sender:self];
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SegueShowReservationStep2])
    {
        // Get reference to the destination view controller
        FRSReservationStep2Viewcontroller *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        _reservation.flight = _flightSelected;
        vc.reservation = [_reservation copy];
        
    }
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
