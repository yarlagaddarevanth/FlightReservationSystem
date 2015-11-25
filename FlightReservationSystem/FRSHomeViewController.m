//
//  FRSHomeViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSHomeViewController.h"

@interface FRSHomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *selectFromDestButton;
@property (weak, nonatomic) IBOutlet UIButton *selectToDestinationButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;
@property (weak, nonatomic) IBOutlet UIButton *selectNumberofPassengersButton;

@end

@implementation FRSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    [self configureDropDownButtons];
}

-(void)configureDropDownButtons{
    _selectFromDestButton.layer.borderWidth = 1.0;
    _selectFromDestButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectFromDestButton.layer.cornerRadius = 5.0;
    
    _selectToDestinationButton.layer.borderWidth = 1.0;
    _selectToDestinationButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectToDestinationButton.layer.cornerRadius = 5.0;
    
    _selectDateButton.layer.borderWidth = 1.0;
    _selectDateButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectDateButton.layer.cornerRadius = 5.0;
    
    _selectNumberofPassengersButton.layer.borderWidth = 1.0;
    _selectNumberofPassengersButton.layer.borderColor = [UIColor grayColor].CGColor;
    _selectNumberofPassengersButton.layer.cornerRadius = 5.0;
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

@end
