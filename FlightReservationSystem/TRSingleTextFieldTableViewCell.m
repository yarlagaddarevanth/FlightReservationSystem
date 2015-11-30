//
//  TRSingleTextFieldTableViewCell.m
//  TheTribeApp-Nov15
//
//  Created by Revanth Kumar on 11/16/15.
//  Copyright © 2015 The Tribe Inc. All rights reserved.
//

#import "TRSingleTextFieldTableViewCell.h"
@interface TRSingleTextFieldTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftPadding;

@end

@implementation TRSingleTextFieldTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)configureCellWithVM:(TRSingleLineTextFieldCellVM *)cellVM{
    _textField.placeholder = cellVM.placeHolderText;
    if (cellVM.text && cellVM.text.length>0) {
        _textField.text = cellVM.text;
    }
    
    _leftPadding.constant = cellVM.leftPadding;
    _bottomSeparatorLineView.hidden = cellVM.hideBottomSeparator;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
