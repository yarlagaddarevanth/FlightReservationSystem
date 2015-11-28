//
//  FRSBaseViewController.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TSMessages/TSMessage.h>
#import "FRSProgressHUD.h"
#import "FRSNetworkingManager.h"
#import "FRSResponseModel.h"

@interface FRSBaseViewController : UIViewController

-(void)removeKeyBoard;

@end
