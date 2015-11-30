//
//  Constants.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/26/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SHARED_APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define USER_ACCESS_TOKEN @"access_token"
#define USER_PROFILE @"user_profile"

//Notifications
#define USER_PROFILE_UPDATED_NOTIFICATION @"USER_PROFILE_UPDATED_NOTIFICATION"

//Segues
#define SeguePushHome @"SeguePushHome"
#define SeguePushAvailableFlightsList @"SeguePushAvailableFlightsList"
#define SegueShowReservationStep2 @"SegueShowReservationStep2"
#define SegueShowPayment @"SegueShowPayment"

#define JSESSIONID_KEY @"JSESSIONID"
#define JSESSIONID [USER_DEFAULTS valueForKey:JSESSIONID_KEY]

#endif /* Constants_h */
