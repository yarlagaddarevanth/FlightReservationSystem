//
//  FRSLandingVCTests.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/16/16.
//  Copyright © 2016 Revanth Kumar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FRSLandingViewController.h"
#import <Swizzlean/Swizzlean.h>

@interface FRSLandingVCTests : XCTestCase

@end

@implementation FRSLandingVCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
 [TSMessage showNotificationWithTitle:@"Email"
 subtitle:@"Please enter a valid email id."
 type:TSMessageNotificationTypeWarning];

 */
- (void)testInvalidEmail{
    
    // Setting up things
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FRSLandingViewController *landingVC = [storyboard instantiateViewControllerWithIdentifier:@"LandingVC"];
    UIView *view = landingVC.view;
    
//    // Method swizzling
    __block BOOL correctAlertViewShown = NO;
    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[TSMessage class]];
    [swizzle swizzleClassMethod:@selector(showNotificationWithTitle:subtitle:type:) withReplacementImplementation:^(id _self, NSString *title, NSString *subtitle, TSMessageNotificationType type) {
        
        NSLog(@"%@ ::: %@ ::: %@ ::::: %ld",_self, title, subtitle, type);
        
        if ([title isEqualToString:@"Email"] && [subtitle isEqualToString:@"Please enter a valid email id."]) {
            correctAlertViewShown = YES;
        }
        
        
    }];
    
    
    // Run code under test
    landingVC.emailTextField.text = @"brucewayne";
    landingVC.passwordTextField.text = @"Why so serious?";
    [landingVC.signInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Asserting
    XCTAssertEqual(correctAlertViewShown,YES,@"Show show Alert View when the invalid login");
    [swizzle resetSwizzledClassMethod];
    
}

- (void)testEmptyEmailField{
    
    // Setting up things
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FRSLandingViewController *landingVC = [storyboard instantiateViewControllerWithIdentifier:@"LandingVC"];
    UIView *view = landingVC.view;
    
    //    // Method swizzling
    __block BOOL correctAlertViewShown = NO;
    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[TSMessage class]];
    [swizzle swizzleClassMethod:@selector(showNotificationWithTitle:subtitle:type:) withReplacementImplementation:^(id _self, NSString *title, NSString *subtitle, TSMessageNotificationType type) {
        
        NSLog(@"%@ ::: %@ ::: %@ ::::: %ld",_self, title, subtitle, type);
        
        if ([title isEqualToString:@"Email"] && [subtitle isEqualToString:@"Please fill the Email field."]) {
            correctAlertViewShown = YES;
        }
        
        
    }];
    
    
    // Run code under test
    landingVC.emailTextField.text = @"";
    landingVC.passwordTextField.text = @"Why so serious?";

    [landingVC.signInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Asserting
    XCTAssertEqual(correctAlertViewShown,YES,@"Show Alert View when the email field is empty");
    [swizzle resetSwizzledClassMethod];
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
