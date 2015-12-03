//
//  FRSReservationStep2Viewcontroller.m
//  FlightReservationSystem
//
//  Created by laksmikanth somavarapu on 28/11/2015.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSReservationStep2Viewcontroller.h"
#import "TRSingleLineTextFieldCellVM.h"
#import "TRSingleTextFieldTableViewCell.h"
#import "FRSPaymentViewController.h"
#import "FRSFlightInfoView.h"
#import "AppDelegate.h"

#define PROMO_CODE @"UCM"
#define ROOM_PRICE 50

static NSString *TRSingleTextFieldTableViewCell_Identifier = @"TRSingleTextFieldTableViewCell";

@interface FRSReservationStep2Viewcontroller () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FRSFlightInfoView *flightInfoView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *promoCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomsTextField;
@property (nonatomic) int originalPrice;
@property (nonatomic) BOOL applyPromoCodesPrice;
@property (nonatomic) BOOL applyRoomsPrice;
- (IBAction)applyPromoCodeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *passengersTableView;
@property (nonatomic) NSMutableArray *cellVMsArray;

- (IBAction)paymentButtonClicked:(id)sender;

@end

@implementation FRSReservationStep2Viewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_passengersTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TRSingleTextFieldTableViewCell class]) bundle:nil] forCellReuseIdentifier:TRSingleTextFieldTableViewCell_Identifier];
    
    _originalPrice = _reservation.flight.price.intValue;
    _applyPromoCodesPrice = NO;
    _applyRoomsPrice = NO;

    [self updateFlightInfoForPrice];
    [self configureTableCellVMs];
}

-(void)updateFlightInfoForPrice{
    [_flightInfoView configureViewWithFlight:_reservation.flight];
}
-(void)configureTableCellVMs{
    if (!_cellVMsArray) {
        _cellVMsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [_cellVMsArray removeAllObjects];
    
    for (int i=0; i<_reservation.noOfPassengers; i++) {
        TRSingleLineTextFieldCellVM *cellVMTop1 = [TRSingleLineTextFieldCellVM new];
        cellVMTop1.placeHolderText = [NSString stringWithFormat:@"%d. Passenger name", i+1];
        cellVMTop1.hideBottomSeparator = NO;
        cellVMTop1.leftPadding = 20.0;

        [_cellVMsArray addObject:cellVMTop1];
    }
    
    [_passengersTableView reloadData];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellVMsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    TRSingleLineTextFieldCellVM *cellVM = [_cellVMsArray objectAtIndex:indexPath.row];
    TRSingleTextFieldTableViewCell *singleLineCell = [tableView dequeueReusableCellWithIdentifier:TRSingleTextFieldTableViewCell_Identifier forIndexPath:indexPath];
    
    [singleLineCell configureCellWithVM:cellVM];
    cell = singleLineCell;
    return cell;
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SegueShowPayment])
    {
        // Get reference to the destination view controller
        FRSPaymentViewController *vc = [segue destinationViewController];
        
        NSString *passengersStr = [self getPassengersString];
        NSLog(@"passengersStr: %@",passengersStr);
        
        _reservation.passengers = passengersStr;
        _reservation.mobileNumber = _mobileTextField.text;
        _reservation.address = _addressTextField.text;

        
        vc.reservation = _reservation;

        // Pass any objects to the view controller here, like...
//        [vc setMyObjectHere:object];
    }
}


-(NSString *)getPassengersString{
    NSMutableArray *passengers = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<_reservation.noOfPassengers; i++) {
        TRSingleTextFieldTableViewCell *cell = [_passengersTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [passengers addObject:cell.textField.text];

    }
    return [passengers componentsJoinedByString:@","];
}
-(BOOL)validatePassengersForm{
    BOOL didFillAllFields = YES;
    
    if (![_mobileTextField.text isValid]) {
        if (_mobileTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Mobile number"
                                        subtitle:@"Please enter your Mobile number."
                                            type:TSMessageNotificationTypeWarning];
        }else
            [TSMessage showNotificationWithTitle:@"Mobile number"
                                        subtitle:@"Please enter a valid email id."
                                            type:TSMessageNotificationTypeWarning];
        
        didFillAllFields = NO;
    }else if (![_addressTextField.text isValid]){
        if (_addressTextField.text.length == 0) {
            [TSMessage showNotificationWithTitle:@"Address"
                                        subtitle:@"Please enter your address."
                                            type:TSMessageNotificationTypeWarning];
            
        }
        
        didFillAllFields = NO;
    }
    else {
        for (int i = 0; i<_reservation.noOfPassengers; i++) {
            TRSingleTextFieldTableViewCell *cell = [_passengersTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

            if (cell.textField.text.length == 0) {
                didFillAllFields = NO;
                [TSMessage showNotificationWithTitle:@"Passengers" subtitle:@"Please fill all passenger fields." type:TSMessageNotificationTypeWarning];
                break;
            }

        }

    }

    
    
    return didFillAllFields;
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

- (IBAction)paymentButtonClicked:(id)sender {
    if ([self validatePassengersForm]) {
        if ([[[SHARED_APP_DELEGATE loggedInUser] role] isEqualToString:USER_ROLE_GUEST]) {
            [TSMessage showNotificationWithTitle:@"Hello!" subtitle:@"You need to be Signed In as a registered user to reserve your ticket." type:TSMessageNotificationTypeWarning];
        }
        else {
            [self performSegueWithIdentifier:SegueShowPayment sender:self];
        }

    }
}
- (IBAction)applyPromoCodeClicked:(id)sender {
    
    if (_promoCodeTextField.text.isValid) {
        if ([_promoCodeTextField.text isEqualToString:PROMO_CODE]) {
            [TSMessage showNotificationWithTitle:@"Success!" subtitle:@"You got 50% off from the original price." type:TSMessageNotificationTypeSuccess];
            
            _applyPromoCodesPrice = YES;
        }
        else{
            [TSMessage showNotificationWithTitle:@"Invalid Promo Code!" subtitle:@"This is not a valid Promo Code." type:TSMessageNotificationTypeWarning];
        }
        
    }
    
    //Rooms
    if (_roomsTextField.text.isValid) {
        _applyRoomsPrice = YES;
    }
    
    [self computeNetPrice];
    [self updateFlightInfoForPrice];
    
    //reset
    _applyPromoCodesPrice = NO;
    _applyRoomsPrice = NO;
    
}

-(void)computeNetPrice{
    int netPrice = _originalPrice;
    if (_applyPromoCodesPrice) {
        
        netPrice = _originalPrice/2;
    }
    
    if (_applyRoomsPrice) {
        netPrice = netPrice + _roomsTextField.text.intValue*ROOM_PRICE;
    }
    _reservation.flight.price = [NSString stringWithFormat:@"%d",netPrice];

}
@end
