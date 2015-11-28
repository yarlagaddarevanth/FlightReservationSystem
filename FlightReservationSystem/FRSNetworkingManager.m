//
//  FRSNetworkingManager.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/26/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSNetworkingManager.h"
#import <AFNetworking/AFNetworking.h>
#import "FRSResponseModel.h"
#import "FRSLoginResponse.h"
#import <TSMessages/TSMessage.h>

@class AppDelegate;

//functions/URLs
#define FRS_API_BASE_HOST @"http://a1d21134.ngrok.io/flight/rs"
#define FRS_API_USER_APP @"user"

#define FRS_API_USER FRS_API_BASE_HOST "/" FRS_API_USER_APP

#define USER_GET_USER_DETAILS_URL FRS_API_USER ""
#define USER_SIGNIN_URL FRS_API_USER "/login"
#define USER_SIGNUP_URL FRS_API_USER "/create"
#define USER_FORGOT_PASSWORD_URL FRS_API_USER "/forgot_password"
#define USER_RESET_PASSWORD_URL FRS_API_USER "/reset_password"


typedef void (^FRSAPIResultBlock)(FRSResponseModel *response, NSError *error);

@implementation FRSNetworkingManager

+(instancetype)sharedNetworkingManager{
    static FRSNetworkingManager *networkManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[FRSNetworkingManager alloc] init];
    });
    
    return networkManager;
}

#pragma mark - USER API

-(void)signUpUserWithParameters:(NSDictionary *)parameters completionBlock:(FRSParsingCompletionBlock)parsingCompletion{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:USER_SIGNUP_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%s create JSON: %@", __PRETTY_FUNCTION__,responseObject);
        FRSResponseModel *response = [self success:responseObject];
        if (response.success) {
            
        }
        else [self handleAPIFailure:response];
        
        //coFRSon for API success or failure. SO check API falure in the call back also
        parsingCompletion(response, nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%s create Error: %@",__PRETTY_FUNCTION__, error);
        parsingCompletion(nil, error);
        
        if (operation.responseString) {
            [self handleServerFailure:operation];
        }
        
    }];
    
}

-(void)signInWithUsername:(NSString *)username andPassword:(NSString *)password completionBlock:(FRSParsingCompletionBlock)parsingCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"username": username,
                                 @"password": password,
                                 };
    
    [manager POST:USER_SIGNIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%s login JSON: %@",__PRETTY_FUNCTION__, responseObject);

        NSDictionary *headers = operation.response.allHeaderFields;
        NSLog(@"operation.response.allHeaderFields:: %@", headers);
    
        if ([headers valueForKey:JSESSIONID_KEY]) {
            [USER_DEFAULTS setValue:[headers valueForKey:JSESSIONID_KEY] forKey:JSESSIONID_KEY];
            [USER_DEFAULTS synchronize];
        }
        
        FRSResponseModel *response = [self success:responseObject];
        
        if (response.success) {
            NSError *err;
            FRSLoginResponse *loginResponse = [[FRSLoginResponse alloc] initWithDictionary:response.data error:&err];
            
            parsingCompletion(loginResponse, err);
        }
        else{
            [self handleAPIFailure:response];
            parsingCompletion(response, nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%s login Error: %@",__PRETTY_FUNCTION__, error);
        parsingCompletion(nil, error);
        if (operation.responseString) {
            [self handleServerFailure:operation];
        }
    }];
    
}

-(void)forgotPasswordWithEmailID:(NSString *)email completionBlock:(FRSParsingCompletionBlock)parsingCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"emailid": email,
                                 };
    
    [manager POST:USER_FORGOT_PASSWORD_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%s forgotPassword JSON: %@",__PRETTY_FUNCTION__, responseObject);
        FRSResponseModel *response = [self success:responseObject];
        if (response.success) {
            
        }
        else [self handleAPIFailure:response];
        
        //coFRSon for API success or failure. SO check API falure in the call back also
        parsingCompletion(response, nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%s forgotPassword Error: %@",__PRETTY_FUNCTION__, error);
        parsingCompletion(nil, error);
        if (operation.responseString) {
            [self handleServerFailure:operation];
        }
    }];
}

-(void)resetPassword:(NSString *)newPassword withCode:(NSString *)code completionBlock:(FRSParsingCompletionBlock)parsingCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{
                                 @"password": newPassword,
                                 @"code": code,
                                 };
    
    [manager POST:USER_RESET_PASSWORD_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%s resetPassword JSON: %@",__PRETTY_FUNCTION__, responseObject);
        FRSResponseModel *response = [self success:responseObject];
        if (response.success) {
            
        }
        else [self handleAPIFailure:response];
        
        //coFRSon for API success or failure. SO check API falure in the call back also
        parsingCompletion(response, nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%s resetPassword Error: %@",__PRETTY_FUNCTION__, error);
        parsingCompletion(nil, error);
        if (operation.responseString) {
            [self handleServerFailure:operation];
        }
    }];
    
}

-(void)getUserDetailsWithCompletionBlock:(FRSParsingCompletionBlock)parsingCompletion{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:JSESSIONID forHTTPHeaderField:JSESSIONID_KEY];

    
    [manager GET:USER_GET_USER_DETAILS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"%s getUserDetailsWithCompletionBlock JSON: %@",__PRETTY_FUNCTION__, responseObject);
        
        FRSResponseModel *response = [self success:responseObject];
        
        if (response.success) {
            NSError *err;
            FRSUser *user = [[FRSUser alloc] initWithDictionary:response.data error:&err];
            
            parsingCompletion(user, err);
        }
        else{
            [self handleAPIFailure:response];
            parsingCompletion(response, nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%s getUserDetailsWithCompletionBlock Error: %@",__PRETTY_FUNCTION__, error);
        parsingCompletion(nil, error);
        if (operation.responseString) {
            [self handleServerFailure:operation];
        }
    }];
    
}

#pragma - mark mark Helpers

-(id)success:(NSDictionary *)responseObject{
    if (responseObject) {
        NSError *err;
        FRSResponseModel *response = [[FRSResponseModel alloc] initWithDictionary:responseObject error:&err];
        return response;
    }
    else return nil;
}

-(BOOL)successCheck:(id)responseObject completionBlock:(FRSAPIResultBlock)compBlock{
    if (responseObject) {
        NSError *err;
        FRSResponseModel *response = [[FRSResponseModel alloc] initWithDictionary:responseObject error:&err];
        compBlock(response, err);
        return [response data];
    }
    else return NO;
    
}
-(void)handleAPIFailure:(FRSResponseModel *)response{
    if (!response)
        response = [FRSResponseModel defaultAPIFailedResponse];
    
    [self showFailureForResponse:response];
    
}
-(void)handleServerFailure:(AFHTTPRequestOperation *)operation{
    
    FRSResponseModel *response = [FRSResponseModel defaultServerFailedResponse:operation.responseString];
    [self showFailureForResponse:response];
    
}

-(void)showFailureForResponse:(FRSResponseModel *)response{
    
    if (([response.status isEqualToString:@"access_denied"]||[response.firstMessage isEqualToString:@"The resource owner or authorization server denied the request."] )) {
        if (!alert) {
            alert = [[UIAlertView alloc] initWithTitle:@"Session Expired" message:@"Please Login Again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }else{
        [TSMessage showNotificationWithTitle:NSLocalizedString(response.status.capitalizedString, nil)
                                    subtitle:NSLocalizedString(response.firstMessage?:@"Request failed: internal server error (500)!", nil)
                                        type:TSMessageNotificationTypeError];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        alert = nil;
        UINavigationController *navVC = (UINavigationController *)SHARED_APP_DELEGATE.window.rootViewController;
        [navVC popToRootViewControllerAnimated:NO];
        NSLog(@"Session Expired!");
    }
}


@end
