//
//  FRSResponseModel.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/26/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSResponseModel.h"

#define SUCCESS_STRING @"success"
#define SUCCESS_STATUS_CODE @"200"

@implementation FRSResponseModel

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    if (self = [super initWithDictionary:dict error:err]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.messagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSString *key in self.message.allKeys) {
        if ([[self.message valueForKey:key] isKindOfClass:[NSString class]]) {
            [self.messagesArray addObject:[self.message valueForKey:key]];
        }else{
            NSArray *arr = [self.message valueForKey:key];
            
            for (NSString *msg in arr) {
                [self.messagesArray addObject:msg];
            }
        }
    }
    
    if (self.messagesArray.count > 0) {
        self.firstMessage = [self.messagesArray firstObject];
    }
}

-(BOOL)success{
    if (self.data) {
        return YES;
    }
    return NO;
}

-(void)isValidAccessToken{
    
}

+(instancetype)defaultAPIFailedResponse{
    NSError *err;
    FRSResponseModel *response = [[FRSResponseModel alloc] initWithDictionary:@{
                                                                              @"firstMessage": @"Unable to process.",
                                                                              @"status": @"failed",
                                                                              @"status_code": @"",
                                                                              } error:&err];
    
    return response;
}
+(instancetype)defaultServerFailedResponse:(NSString *)error{
    NSError *err_parsing;
    NSDictionary *erraoDic = [NSJSONSerialization JSONObjectWithData:[error dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"Error%@",erraoDic);
    FRSResponseModel *response;
    if(erraoDic.count>0){
        response = [[FRSResponseModel alloc] initWithDictionary:@{
                                                                 @"firstMessage": [erraoDic valueForKey:@"error_description"],
                                                                 @"status": [erraoDic valueForKey:@"error"],
                                                                 @"status_code": @"",
                                                                 } error:&err_parsing];
    }
    
    return response;
}

@end