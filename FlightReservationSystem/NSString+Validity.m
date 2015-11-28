//
//  NSString+Validity.m
//  MintMesh
//
//  Created by Enterpi on 05/05/15.
//  Copyright (c) 2015 Enterpi. All rights reserved.
//

#import "NSString+Validity.h"

@implementation NSString (Validity)

+(NSString *)JSONstringFor:(id)obj{
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(BOOL)isValid{
    if (self == (id)[NSNull null] || self.length == 0 )
        return false;
    else
        return true;
}

+(BOOL)isStringValid:(NSString *)str{
    if (str == (id)[NSNull null] || str.length == 0 )
        return false;
    else
        return true;
}

-(BOOL)isEmptyText{
    if (self.length >0)
        return NO;
    else
        return YES;
}

-(NSString *)string{
    if (self == (id)[NSNull null] || self.length == 0 || self == nil )
        return @"";
    return self;
}

-(BOOL)isBeginWithSpaceText{
    
    if ([[self substringToIndex:1] isEqualToString:@" "])
        return YES;
    else
        return NO;
}


-(BOOL)isValidUsername{
    if (self.length < 5 || self.length > 20)
        return NO;
    else
        return YES;
}

-(BOOL)isValidPassword{
    if (self.length < 5)
        return NO;
    else
        return YES;
}

-(BOOL)isValidMobileNumber{
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [self length]);
    NSArray *matches = [detector matchesInString:self options:0 range:inputRange];
    
    // no match at all
    if ([matches count] == 0) {
        return NO;
    }
    
    // found match but we need to check if it matched the whole string
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
    
    if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length && self.length == 10) {
        // it matched the whole string
        return YES;
    }
    else {
        // it only matched partial string
        return NO;
    }

}

-(BOOL)isValidEmail{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailTest evaluateWithObject:self]) {
        return NO;
    }
    
    return YES;
}

+(NSString *)dateToFormatedDate:(NSString *)dateStr{
    NSArray *arry = [dateStr componentsSeparatedByString:@" "];
    NSString *finalDate = [arry objectAtIndex:0]?:@"2014-10-15";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:finalDate];
    [dateFormatter setDateFormat:@"d MMM, YYYY"];//@"EE, d MMM, YYYY"
    
    
    NSDictionary *timeScale = @{@"sec"  :@1,
                                @"min"  :@60,
                                @"hr"   :@3600,
                                @"day"  :@86400,
                                @"week" :@605800,
                                @"month":@2629743,
                                @"year" :@31556926};
    NSString *scale;
    int timeAgo = 0-(int)[date timeIntervalSinceNow];
    if (timeAgo < 60) {
        scale = @"sec";
    } else if (timeAgo < 3600) {
        scale = @"min";
    } else if (timeAgo < 86400) {
        scale = @"hr";
    } else if (timeAgo < 605800) {
        scale = @"day";
    } else if (timeAgo < 2629743) {
        scale = @"week";
    } else if (timeAgo < 31556926) {
        scale = @"month";
    } else {
        scale = @"year";
    }
    
    timeAgo = timeAgo/[[timeScale objectForKey:scale] integerValue];
    NSString *s = @"";
    if (timeAgo > 1) {
        s = @"s";
    }
    NSLog(@"timeAgo:%@",[NSString stringWithFormat:@"%d %@%@", timeAgo, scale, s]);
    //return [dateFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"%d %@%@ ago", timeAgo, scale, s];
    //return [dateFormatter stringFromDate:date];

}

@end
