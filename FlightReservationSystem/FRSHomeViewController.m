//
//  FRSHomeViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSHomeViewController.h"
#import "FRSSearchFlightsResponse.h"
#import "FRSAvailableFlightsListViewController.h"
#import "AppDelegate.h"

#define Default_Button_State_Text @"- select -"
#define Default_Incomplete_Details_Text @"Incomplete Details!"

typedef enum : NSUInteger {
    FRSPickerModeFromDestinations,
    FRSPickerModeToDestinations,
    FRSPickerModeNumberOfPassengers,
} FRSPickerMode;

@interface FRSHomeViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) FRSUser *loggedInUser;

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectFromDestButton;
@property (weak, nonatomic) IBOutlet UIButton *selectToDestinationButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;
@property (weak, nonatomic) IBOutlet UIButton *selectNumberofPassengersButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic) NSMutableArray *fromDestinationsArray;
@property (nonatomic) NSMutableArray *toDestinationsArray;
@property (nonatomic) NSArray *numberOfPassengersArray;

@property (nonatomic) FRSAirport *fromAirportSelected;
@property (nonatomic) FRSAirport *toAirportSelected;
@property (nonatomic) NSDate *dateOfJourneySelected;
@property (nonatomic) NSInteger numberOfPassengersSelected;

@property (nonatomic) NSArray *flightResultsArray;

@property (assign, nonatomic) FRSPickerMode pickerMode;

- (IBAction)doneTappedonToolBar:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
- (IBAction)searchFlightsClicked:(id)sender;

- (IBAction)selectFromDestinationButtonTapped:(id)sender;
- (IBAction)selectToDestinationButtonTapped:(id)sender;
- (IBAction)selectDateOfJourneyTapped:(id)sender;
- (IBAction)selectNumberOfPassengersButtonTapped:(id)sender;
- (IBAction)signOutClicked:(id)sender;


@end

@implementation FRSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loggedInUser = [SHARED_APP_DELEGATE loggedInUser];
    
    _welcomeLabel.text = [NSString stringWithFormat:@"Welcome %@,",[_loggedInUser fullName]];
    
    //Minumum Date
    [_datePicker setMinimumDate:[NSDate date]];
    [self configureDropDownButtons];
    
    _fromDestinationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    _toDestinationsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    //get airports
    [self getAirports];
    
    
}
-(void)getAirports{
    
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    [[FRSNetworkingManager sharedNetworkingManager] getAirportsWithCompletionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSAirportsResponse *airportsResponse = (FRSAirportsResponse *)response;
            [_fromDestinationsArray removeAllObjects];
            [_fromDestinationsArray addObjectsFromArray:airportsResponse.airports];
            
            [_toDestinationsArray removeAllObjects];
            [_toDestinationsArray addObjectsFromArray:airportsResponse.airports];
            
        }
        
        [_pickerView reloadAllComponents];
    }];
}
-(void)configureDropDownButtons{
    //From
    [_selectFromDestButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectFromDestButton.layer.borderWidth = 1.0;
    _selectFromDestButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectFromDestButton.layer.cornerRadius = 5.0;
    
//    _fromDestinationsArray = [[NSArray alloc] initWithObjects:@"Chicago", @"Kansas City", @"New York", @"Los Angeles", @"Boston", @"Washington", @"San Fransico", @"Houston", @"Texas", @"Philadelphia", nil];
    
    //To
    [_selectToDestinationButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectToDestinationButton.layer.borderWidth = 1.0;
    _selectToDestinationButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectToDestinationButton.layer.cornerRadius = 5.0;
    
//    _toDestinationsArray = [[NSArray alloc] initWithArray:_fromDestinationsArray];

    //Date
    [_selectDateButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectDateButton.layer.borderWidth = 1.0;
    _selectDateButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectDateButton.layer.cornerRadius = 5.0;
    
    //Number of Passengers
    [_selectNumberofPassengersButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectNumberofPassengersButton.layer.borderWidth = 1.0;
    _selectNumberofPassengersButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectNumberofPassengersButton.layer.cornerRadius = 5.0;
    
    _numberOfPassengersArray = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
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

#pragma mark - Date Picker

- (IBAction)datePickerValueChanged:(id)sender {
    _dateOfJourneySelected = _datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:_dateOfJourneySelected];
    
    [_selectDateButton setTitle:formatedDate forState:UIControlStateNormal];
    
}

#pragma mark - Picker View

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rows = 0;
    
    NSArray *array = [self getDataSourceArrayForCurrentPickerMode];
    rows = array.count;
    
    return rows;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = @"";
    
    NSArray *sourceArray = [self getDataSourceArrayForCurrentPickerMode];
    
    if (_pickerMode == FRSPickerModeNumberOfPassengers) {
        title = sourceArray[row];
    }
    else{
        FRSAirport *airport = (FRSAirport *)sourceArray[row];
        title = airport.airportName;
    }
    
    return title;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *title = @"";

    NSArray *sourceArray = [self getDataSourceArrayForCurrentPickerMode];
    UIButton *button = [self getButtonForCurrentPickerMode];
    
    
    if (_pickerMode == FRSPickerModeNumberOfPassengers) {
        title = sourceArray[row];
        _numberOfPassengersSelected = title.integerValue;
    }
    else{
        FRSAirport *airport = (FRSAirport *)sourceArray[row];
        title = airport.airportName;
        if(_pickerMode == FRSPickerModeFromDestinations)
            _fromAirportSelected = airport;
        else _toAirportSelected = airport;
            
    }


    [button setTitle:title forState:UIControlStateNormal];
    
}

-(void)reloadPickerViewForCurrentMode{
    [self showToolBar:YES];
    [self showPickerView:YES];
    
    [_pickerView reloadAllComponents];
}

-(UIButton *)getButtonForCurrentPickerMode{
    UIButton *retButton;
    
    switch (_pickerMode) {
        case FRSPickerModeFromDestinations:
            retButton =  _selectFromDestButton;
            break;
        case FRSPickerModeToDestinations:
            retButton =  _selectToDestinationButton;
            break;
        case FRSPickerModeNumberOfPassengers:
            retButton =  _selectNumberofPassengersButton;
            break;
            
        default:
            break;
    }
    
    return retButton;
}

-(NSArray *)getDataSourceArrayForCurrentPickerMode{
    NSArray *retArray;
    
    switch (_pickerMode) {
        case FRSPickerModeFromDestinations:
            retArray =  _fromDestinationsArray;
            break;
        case FRSPickerModeToDestinations:
            retArray =  _toDestinationsArray;
            break;
        case FRSPickerModeNumberOfPassengers:
            retArray =  _numberOfPassengersArray;
            break;
            
        default:
            break;
    }
    
    return retArray;
}

#pragma mark -

- (IBAction)doneTappedonToolBar:(id)sender {
    if (_toolBar.alpha == 1) {
        [self showToolBar:NO];
    }
    if (_datePicker.alpha == 1) {
        [self showDatePicker:NO];
    }
    if (_pickerView.alpha == 1) {
        [self showPickerView:NO];
    }
}

#pragma mark Show/Hide Picker Views
-(void)showToolBar:(BOOL)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        if (show) {
            _toolBar.alpha = 1.0;
        }
        else{
            _toolBar.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showDatePicker:(BOOL)show{
    [UIView animateWithDuration:0.3 animations:^{
        if (show) {
            _datePicker.alpha = 1.0;
        }
        else{
            _datePicker.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showPickerView:(BOOL)show{
    [UIView animateWithDuration:0.3 animations:^{
        if (show) {
            _pickerView.alpha = 1.0;
        }
        else{
            _pickerView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Button Actions
- (IBAction)selectDateOfJourneyTapped:(id)sender {
    [self showToolBar:YES];
    [self showDatePicker:YES];
}

- (IBAction)selectFromDestinationButtonTapped:(id)sender {
    _pickerMode = FRSPickerModeFromDestinations;
    [self reloadPickerViewForCurrentMode];
}

- (IBAction)selectToDestinationButtonTapped:(id)sender {
    _pickerMode = FRSPickerModeToDestinations;
    [self reloadPickerViewForCurrentMode];
}

- (IBAction)selectNumberOfPassengersButtonTapped:(id)sender {
    _pickerMode = FRSPickerModeNumberOfPassengers;
    [self reloadPickerViewForCurrentMode];
}

- (IBAction)signOutClicked:(id)sender {
    [(UINavigationController *)[[SHARED_APP_DELEGATE window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)searchFlightsClicked:(id)sender {
    
//    if ([self searchFlightsFormValidation]) {
        [self getSearchResults];
//    }
    
}

-(BOOL)searchFlightsFormValidation{
    BOOL isValid = YES;
    
    if ([[_selectFromDestButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'FROM' Destination!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if ([[_selectToDestinationButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'TO' Destination!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if ([[_selectDateButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'Date of Journey'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if ([[_selectNumberofPassengersButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'Number of Passengers'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else {
    
    }

    return isValid;
}

#pragma mark - Search Flights API
-(void)getSearchResults{
    FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:_dateOfJourneySelected];
    

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"BLR", @"source",
                                @"SNF", @"destination",
                                @"2014-01-01", @"dateOfJourney",
                                @"3", @"numberOfPassengers",
                                nil];
//    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
//                                _fromAirportSelected.airportCode, @"source",
//                                _toAirportSelected.airportCode, @"destination",
//                                stringFromDate, @"dateOfJourney",
//                                [NSString stringWithFormat:@"%li",(long)_numberOfPassengersSelected], @"numberOfPassengers",
//                                nil];
    [[FRSNetworkingManager sharedNetworkingManager] searchFlightsWithParameters:parameters completionBlock:^(id response, NSError *error) {
        
        [HUD hide:NO];
        
        if (!error) {
            FRSSearchFlightsResponse *flightResultResponse = (FRSSearchFlightsResponse *)response;
            _flightResultsArray = flightResultResponse.flights;

            [self performSegueWithIdentifier:SeguePushAvailableFlightsList sender:self];
        }
        
        [_pickerView reloadAllComponents];
    }];

}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SeguePushAvailableFlightsList])
    {
        // Get reference to the destination view controller
        FRSAvailableFlightsListViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        FRSReservation *reservation = [FRSReservation new];
        reservation.fromAirport = _fromAirportSelected;
        reservation.toAirport = _toAirportSelected;
        reservation.dateOfJourney = _dateOfJourneySelected;
        reservation.noOfPassengers = _numberOfPassengersSelected;
        
        vc.reservation = reservation;
        
        vc.flightsArray = _flightResultsArray;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:SegueShowViewReservations]) {
        if ([[_loggedInUser role] isEqualToString:USER_ROLE_GUEST]) {
            [TSMessage showNotificationWithTitle:@"Hello!" subtitle:@"You need to be Signed In as a registered user to view your reservations." type:TSMessageNotificationTypeWarning];
            return NO;
        }
        else return YES;
    }
    else
        return YES;
}

@end
