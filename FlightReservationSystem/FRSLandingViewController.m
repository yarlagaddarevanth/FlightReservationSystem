//
//  ViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 10/20/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSLandingViewController.h"

@interface FRSLandingViewController ()

@end

@implementation FRSLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
