//
//  TRSingleLineTextFieldVM.h
//  TheTribeApp-Nov15
//
//  Created by Revanth Kumar on 11/16/15.
//  Copyright © 2015 The Tribe Inc. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRSingleLineTextFieldCellVM : NSObject
@property (nonatomic) NSString *placeHolderText;
@property (nonatomic) NSString *text;
@property (nonatomic, assign) BOOL hideBottomSeparator;
@property (nonatomic, assign) CGFloat leftPadding;
@end
