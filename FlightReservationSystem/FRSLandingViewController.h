//
//  ViewController.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 10/20/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRSBaseViewController.h"

@interface FRSLandingViewController : FRSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

- (IBAction)signInTapped:(id)sender;
- (IBAction)EnterAsGuestTapped:(id)sender;

@end

