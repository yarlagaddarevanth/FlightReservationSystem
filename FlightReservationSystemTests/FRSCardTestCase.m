//
//  FRSCardTestCase.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/16/16.
//  Copyright © 2016 Revanth Kumar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FRSCard.h"
#import <Swizzlean/Swizzlean.h>

@interface FRSCardTestCase : XCTestCase

@end

@implementation FRSCardTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testForMatchingCard
{
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"one";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"one";
    
    NSArray *handOfCards = @[card2];
    
    int matchCount = [card1 match:handOfCards];
    
    XCTAssertEqual(matchCount, 1, @"Should have matched");
}

- (void)testForNotMatchingCard
{
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"one";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"two";
    
    NSArray *handOfCards = @[card2];
    
    int matchCount = [card1 match:handOfCards];
    
    XCTAssertEqual(matchCount, 0, @"No matches should be found.");
}


- (void)testForZeroMatchingCards
{
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"one";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"two";
    FRSCard *card3 = [[FRSCard alloc] init];
    card3.contents = @"thre";
    FRSCard *card4 = [[FRSCard alloc] init];
    card4.contents = @"dga";
    
    NSArray *handOfCards = @[card2, card3, card4];
    
    int matchCount = [card1 numberOfMatches:handOfCards];
    
    XCTAssertEqual(matchCount, 0, @"No matches should be found.");
}

- (void)testForTwoMatchingCards
{
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"one";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"two";
    FRSCard *card3 = [[FRSCard alloc] init];
    card3.contents = @"one";
    FRSCard *card4 = [[FRSCard alloc] init];
    card4.contents = @"one";
    
    NSArray *handOfCards = @[card2, card3, card4];
    
    int matchCount = [card1 numberOfMatches:handOfCards];
    
//    XCTAssertEqual(matchCount, 2, @"Two matches should be found.");
    XCTAssertEqual(matchCount, 2);
}


- (void)testThreeCardsMatch {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //    // Method swizzling
    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[FRSCard class]];
    [swizzle swizzleInstanceMethod:@selector(numberOfMatches:) withReplacementImplementation:^(id _self, NSArray *array) {
        
        NSLog(@"%@ ::: %@",_self, array);
        for (FRSCard *a_card in array) {
            NSLog(@"Contenst:::: %@",a_card.contents);
        }
        
//        NSLog(@":::");
        return 3;
    }];
    
    
    
    
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"one";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"two";
    FRSCard *card3 = [[FRSCard alloc] init];
    card3.contents = @"one";
    FRSCard *card4 = [[FRSCard alloc] init];
    card4.contents = @"one";
    FRSCard *card5 = [[FRSCard alloc] init];
    card5.contents = @"one";
    
    NSArray *handOfCards = @[card2, card3, card4, card5];
    
    int matchCount = [card1 numberOfMatches:handOfCards];
    
    //    XCTAssertEqual(matchCount, 2, @"Two matches should be found.");
    XCTAssertEqual(matchCount, 3);

    
    [swizzle resetSwizzledInstanceMethod];


}

- (void)testClassSwizzle {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //    // Method swizzling
    Swizzlean *swizzle = [[Swizzlean alloc] initWithClassToSwizzle:[FRSCard class]];
    [swizzle swizzleClassMethod:@selector(getCount:) withReplacementImplementation:^(id _self, NSArray *array) {
        
        NSLog(@"%@ ::: %@",_self, array);
        for (FRSCard *a_card in array) {
            NSLog(@"Contenst:::: %@",a_card.contents);
        }
        
        return 100;
    }];
    
    
    
    
    FRSCard *card1 = [[FRSCard alloc] init];
    card1.contents = @"RevCard";
    FRSCard *card2 = [[FRSCard alloc] init];
    card2.contents = @"two";
    FRSCard *card3 = [[FRSCard alloc] init];
    card3.contents = @"RevCard";
    FRSCard *card4 = [[FRSCard alloc] init];
    card4.contents = @"RevCard";
    FRSCard *card5 = [[FRSCard alloc] init];
    card5.contents = @"RevCard";
    
    NSArray *handOfCards = @[card2, card3, card4, card5];
    
    int matchCount = [FRSCard getCount:handOfCards];
    
    //    XCTAssertEqual(matchCount, 2, @"Two matches should be found.");
    XCTAssertEqual(matchCount, 100);
    
    
    [swizzle resetSwizzledClassMethod];
    
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
