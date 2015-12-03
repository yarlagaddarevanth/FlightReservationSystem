//
//  FRSAdminFlightsViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAdminFlightsViewController.h"
#import "FRSFlightInfoTableViewCell.h"
#import "FRSFlightsResponse.h"

static NSString *FRSFlightInfoTableViewCell_Identifier = @"FRSFlightInfoTableViewCell";

@interface FRSAdminFlightsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *flightsArray;


@end

@implementation FRSAdminFlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _flightsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRSFlightInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:FRSFlightInfoTableViewCell_Identifier];

    [self.tap setCancelsTouchesInView:NO];

}

-(void)viewWillAppear:(BOOL)animated{
    [self getFlights];
}
-(void)getFlights{
    
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] getFlightsForAdminWithCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSFlightsResponse *flightsResponse = (FRSFlightsResponse *)response;
            
            [_flightsArray removeAllObjects];
            [_flightsArray  addObjectsFromArray:flightsResponse.flights];
            [_tableView reloadData];

        }
        
    }];
}

-(void)deleteFlight:(FRSFlight *)flight{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] deleteFlightForFlightID:flight.flightDbId withCompletionBlock:^(id response, NSError *error) {
        [HUD hide:NO];
        
        if (!error) {
            NSInteger indexxxx = [_flightsArray indexOfObject:flight];
            [_flightsArray removeObject:flight];

            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexxxx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

            [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have deleted a flight." type:TSMessageNotificationTypeSuccess];
        }

    }];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteFlight:[_flightsArray objectAtIndex:indexPath.row]];
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
