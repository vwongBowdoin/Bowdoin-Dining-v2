//
//  TransactionCell.m
//  Bowdoin Dining
//
//  Created by Ben Johnson on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TransactionCell.h"


@implementation TransactionCell

@synthesize date, amount, location, balance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
