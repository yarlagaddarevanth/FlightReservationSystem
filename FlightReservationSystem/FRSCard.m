//
//  FRSCard.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/16/16.
//  Copyright © 2016 Revanth Kumar. All rights reserved.
//

#import "FRSCard.h"

@interface FRSCard ()

@property(nonatomic, strong) NSString *name;

- (NSString *)nameOnCard;

@end

@implementation FRSCard

- (int)match:(NSArray *)otherCards
{
    
    int score = 0;
    for (FRSCard *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

- (int)numberOfMatches:(NSArray *)otherCards
{
    int score = 0;
    for (FRSCard *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score++;
        }
    }
    return score;
}

+ (int)getCount:(NSArray *)otherCards{
    NSLog(@"The Count: %ld",otherCards.count);
    return 100;
}

@end
