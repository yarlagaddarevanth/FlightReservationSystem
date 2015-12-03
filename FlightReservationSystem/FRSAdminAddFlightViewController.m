//
//  FRSManageFlightViewController.m
//  FlightReservationSystem
//
//  Created by laksmikanth somavarapu on 25/11/2015.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAdminAddFlightViewController.h"
typedef enum : NSUInteger {
    FRSPickerModeFromDestinations,
    FRSPickerModeToDestinations,
} FRSPickerMode;
typedef enum : NSUInteger {
    FRSDatePickerModeDeparture,
    FRSDatePickerModeArrival,
} FRSDatePickerMode;

#define Default_Button_State_Text @"- select -"
#define Default_Incomplete_Details_Text @"Incomplete Details!"

@interface FRSAdminAddFlightViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectFromDestButton;
@property (weak, nonatomic) IBOutlet UIButton *selectToDestinationButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDepartureDateButton;
@property (weak, nonatomic) IBOutlet UIButton *selectArrivalDateButton;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalSeatsTextField;
@property (weak, nonatomic) IBOutlet UITextField *availableSeatsTextField;
@property (weak, nonatomic) IBOutlet UITextField *flightNameTextField;

@property (nonatomic) NSMutableArray *fromDestinationsArray;
@property (nonatomic) NSMutableArray *toDestinationsArray;

@property (nonatomic) FRSAirport *fromAirportSelected;
@property (nonatomic) FRSAirport *toAirportSelected;
@property (nonatomic) NSDate *departureDateSelected;
@property (nonatomic) NSDate *arrivalDateSelected;


@property (assign, nonatomic) FRSPickerMode pickerMode;
@property (assign, nonatomic) FRSDatePickerMode datePickerMode;

- (IBAction)doneTappedonToolBar:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
- (IBAction)addFlightClicked:(id)sender;

- (IBAction)selectFromDestinationButtonTapped:(id)sender;
- (IBAction)selectToDestinationButtonTapped:(id)sender;
- (IBAction)selectDepartureDateTapped:(id)sender;
- (IBAction)selectArrivalDateButtonTapped:(id)sender;

@end

@implementation FRSAdminAddFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    //Departure Date
    [_selectDepartureDateButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectDepartureDateButton.layer.borderWidth = 1.0;
    _selectDepartureDateButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectDepartureDateButton.layer.cornerRadius = 5.0;
    
    //Arrival Date
    [_selectArrivalDateButton setTitle:Default_Button_State_Text forState:UIControlStateNormal];
    _selectArrivalDateButton.layer.borderWidth = 1.0;
    _selectArrivalDateButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectArrivalDateButton.layer.cornerRadius = 5.0;
    
}

#pragma mark - Date Picker

- (IBAction)datePickerValueChanged:(id)sender {
    NSDate *selectedDate = _datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *formatedDate = [dateFormatter stringFromDate:selectedDate];
    
    UIButton * button = [self getButtonForCurrentDatePickerMode];
    [button setTitle:formatedDate forState:UIControlStateNormal];

    
    if (_datePickerMode == FRSDatePickerModeDeparture) {
        _departureDateSelected = selectedDate;
    }
    else {
        _arrivalDateSelected = selectedDate;
    }
    
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
    
    FRSAirport *airport = (FRSAirport *)sourceArray[row];
    title = airport.airportName;
    
    return title;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *title = @"";
    
    NSArray *sourceArray = [self getDataSourceArrayForCurrentPickerMode];
    UIButton *button = [self getButtonForCurrentPickerMode];
    
    
    FRSAirport *airport = (FRSAirport *)sourceArray[row];
    title = airport.airportName;
    
    if(_pickerMode == FRSPickerModeFromDestinations)
        _fromAirportSelected = airport;
    else _toAirportSelected = airport;
    

    [button setTitle:title forState:UIControlStateNormal];
}

-(void)reloadPickerViewForCurrentMode{
    [self showToolBar:YES];
    [self showPickerView:YES];
    
    [self showDatePicker:NO];

    [_pickerView reloadAllComponents];
}
-(void)reloadDatePickerViewForCurrentMode{
    [self showToolBar:YES];
    [self showDatePicker:YES];
    
    [self showPickerView:NO];
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
            
        default:
            break;
    }
    
    return retButton;
}
-(UIButton *)getButtonForCurrentDatePickerMode{
    UIButton *retButton;
    
    switch (_datePickerMode) {
        case FRSDatePickerModeDeparture:
            retButton =  _selectDepartureDateButton;
            break;
        case FRSDatePickerModeArrival:
            retButton =  _selectArrivalDateButton;
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

#pragma mark - new actions


- (IBAction)selectFromDestinationButtonTapped:(id)sender {
    _pickerMode = FRSPickerModeFromDestinations;
    [self reloadPickerViewForCurrentMode];
}

- (IBAction)selectToDestinationButtonTapped:(id)sender {
    _pickerMode = FRSPickerModeToDestinations;
    [self reloadPickerViewForCurrentMode];
}

- (IBAction)selectDepartureDateTapped:(id)sender {
    _datePickerMode = FRSDatePickerModeDeparture;
    [self reloadDatePickerViewForCurrentMode];
}
- (IBAction)selectArrivalDateButtonTapped:(id)sender {
    _datePickerMode = FRSDatePickerModeArrival;
    [self reloadDatePickerViewForCurrentMode];
}


- (IBAction)addFlightClicked:(id)sender{
    if ([self addFlightsFormValidationSuccess]) {
        FRSProgressHUD *HUD = [[FRSProgressHUD alloc] initWithView:self.view showAnimated:YES];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringFromDepartureDate = [formatter stringFromDate:_departureDateSelected];
        
        NSString *stringFromArrivalDate = [formatter stringFromDate:_arrivalDateSelected];
        
        
//        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    @"BLR", @"source",
//                                    @"SNF", @"destination",
//                                    @"2014-01-01", @"dateOfJourney",
//                                    @"3", @"numberOfPassengers",
//                                    nil];
        /*
         "destinationCode": "SNF",
         "destination": "San Franscio USA",
         "sourceCode": "BLR",
         "source": "Bangalore India",
         "noOfSeats": 140,
         "noOfSeatsAvailable": 130,
         "departure": "2014-01-01T23:28:56.782Z",
         "arrival": "2014-01-01T23:28:56.782Z",
         "price": 136
         */

           NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                       _fromAirportSelected.airportName, @"source",
                                       _fromAirportSelected.airportCode, @"sourceCode",
                                       _toAirportSelected.airportName, @"destination",
                                       _toAirportSelected.airportCode, @"destinationCode",
                                       _totalSeatsTextField.text, @"noOfSeats",
                                       _availableSeatsTextField.text, @"noOfSeatsAvailable",
                                       stringFromDepartureDate, @"departure",
                                       stringFromArrivalDate, @"arrival",
                                       _priceTextField.text, @"price",
                                       _flightNameTextField.text, @"flightId",
                                       nil];
        
        [[FRSNetworkingManager sharedNetworkingManager] addFlightByAdminWithParameters:parameters completionBlock:^(id response, NSError *error) {
            
            [HUD hide:NO];
            
            if (!error) {
                FRSResponseModel *resultResponse = (FRSResponseModel *)response;
                [TSMessage showNotificationWithTitle:@"Success"
                                            subtitle:@"New Flight has been added."
                                                type:TSMessageNotificationTypeSuccess];

//                [self performSegueWithIdentifier:SeguePushAvailableFlightsList sender:self];
            }
            

        }];
        
    }
}

-(BOOL)addFlightsFormValidationSuccess{
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
    else if ([[_selectDepartureDateButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'Departure Date'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if ([[_selectArrivalDateButton titleForState:UIControlStateNormal] isEqualToString:Default_Button_State_Text]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please select 'Arrival Date'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_priceTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please enter 'Price'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_totalSeatsTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please enter 'Total Seats'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_availableSeatsTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please enter 'Available Seats'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (_availableSeatsTextField.text.integerValue > _totalSeatsTextField.text.integerValue) {
        [TSMessage showNotificationWithTitle:@"Incorrect"
                                    subtitle:@"'Available Seats' cannot be more than 'Total Seats'!"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else if (![_flightNameTextField.text isValid]) {
        [TSMessage showNotificationWithTitle:Default_Incomplete_Details_Text
                                    subtitle:@"Please enter 'Flight Name. Eg: UCM136'"
                                        type:TSMessageNotificationTypeWarning];
        isValid = NO;
    }
    else {
        
    }
    
    return isValid;
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
