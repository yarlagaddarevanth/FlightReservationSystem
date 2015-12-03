//
//  FRSAdminAirportsViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAdminAirportsViewController.h"

static NSString *cellIdentifier = @"FRSAdminAirportsViewControllerCell";

@interface FRSAdminAirportsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *airports;

@end

@implementation FRSAdminAirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tap setCancelsTouchesInView:NO];
    
    _airports = [[NSMutableArray alloc] initWithCapacity:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [self getAirports];    
}

-(void)getAirports{
    
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] getAirportsWithCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSAirportsResponse *airportsResponse = (FRSAirportsResponse *)response;
            
            [_airports removeAllObjects];
            [_airports  addObjectsFromArray:airportsResponse.airports];

            [_tableView reloadData];
        }
        
    }];
}

-(void)deleteAirport:(FRSAirport *)airport{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] deleteAirportForAirportID:airport.airportId withCompletionBlock:^(id response, NSError *error) {
        [HUD hide:NO];
        
        if (!error) {
            NSInteger indexxxx = [_airports indexOfObject:airport];
            [_airports removeObject:airport];
            
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexxxx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
            [TSMessage showNotificationWithTitle:@"Success" subtitle:@"You have deleted an airport." type:TSMessageNotificationTypeSuccess];
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _airports.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    FRSAirport *airport = _airports[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@) - %@",airport.airportName,airport.airportCode,airport.country];
    cell.detailTextLabel.text = @"Detail";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteAirport:[_airports objectAtIndex:indexPath.row]];
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
