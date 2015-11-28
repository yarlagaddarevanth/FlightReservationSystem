//
//  NSString+Validity.h
//  MintMesh
//
//  Created by Enterpi on 05/05/15.
//  Copyright (c) 2015 Enterpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validity)

-(BOOL)isValid;
+(BOOL)isStringValid:(NSString *)str;
-(BOOL)isValidUsername;
-(BOOL)isValidPassword;
-(BOOL)isValidMobileNumber;
-(BOOL)isValidEmail;
-(BOOL)isEmptyText;
-(NSString *)string;
-(BOOL)isBeginWithSpaceText;
+(NSString *)dateToFormatedDate:(NSString *)dateStr;
+(NSString *)JSONstringFor:(id)obj;
@end
