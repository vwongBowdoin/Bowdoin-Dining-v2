//
//  TransactionCell.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransactionCell : UITableViewCell {

	IBOutlet UILabel *location;
	IBOutlet UILabel *amount;
	IBOutlet UILabel *date;
	IBOutlet UILabel *balance;

}

@property (assign) IBOutlet UILabel *location;
@property (assign) IBOutlet UILabel *amount;
@property (assign) IBOutlet UILabel *date;
@property (assign) IBOutlet UILabel *balance;

@end
