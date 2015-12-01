//
//  TRSingleTextFieldTableViewCell.h
//  TheTribeApp-Nov15
//
//  Created by Revanth Kumar on 11/16/15.
//  Copyright © 2015 The Tribe Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRSingleLineTextFieldCellVM.h"

@interface TRSingleTextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void)configureCellWithVM:(TRSingleLineTextFieldCellVM *)cellVM;
@end
