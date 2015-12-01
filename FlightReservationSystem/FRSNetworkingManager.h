//
//  FRSNetworkingManager.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/26/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FRSParsingCompletionBlock)(id response, NSError *error);

@interface FRSNetworkingManager : NSObject<UIAlertViewDelegate>{
    UIAlertView *alert;
}

+(instancetype)sharedNetworkingManager;

#pragma mark - User SignIn, SignUp and Reset Password
//SignIn
-(void)signInWithUsername:(NSString *)username andPassword:(NSString *)password completionBlock:(FRSParsingCompletionBlock)parsingCompletion;

//SignUp
-(void)signUpUserWithParameters:(NSDictionary *)parameters completionBlock:(FRSParsingCompletionBlock)parsingCompletion;

//Forgot Password
-(void)forgotPasswordWithEmailID:(NSString *)email completionBlock:(FRSParsingCompletionBlock)parsingCompletion;

//Reset Password
-(void)resetPassword:(NSString *)newPassword withCode:(NSString *)code completionBlock:(FRSParsingCompletionBlock)parsingCompletion;

//Get User Details
-(void)getUserDetailsWithCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion;

#pragma mark Airports
-(void)getAirportsWithCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion;

#pragma mark - Reservations
-(void)reserveTicketWithParameters:(NSDictionary *)parameters completionBlock:(FRSParsingCompletionBlock)parsingCompletion;
-(void)getReservationsWithCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion;
-(void)cancelReservationForID:(NSString *)reservationID withCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion;

#pragma mark - Flights
-(void)searchFlightsWithParameters:(NSDictionary *)parameters completionBlock:(FRSParsingCompletionBlock)parsingCompletion;
-(void)getFlightInfoForFlightID:(NSString *)flightID withCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion;

@end
