//
//  SettingsController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	IBOutlet UITableViewCell *cellOne;
    IBOutlet UITableViewCell *cellTwo;
	IBOutlet UITableViewCell *cellThree;
    IBOutlet UITableViewCell *cellFour;
	IBOutlet UITableViewCell *cellFive;
    IBOutlet UITableViewCell *cellSix;
	IBOutlet UITableViewCell *cellSeven;
    IBOutlet UITableViewCell *cellEight;


	
}

@property (nonatomic, retain) IBOutlet UITableViewCell *cellOne;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellTwo;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellThree;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellFour;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellFive;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellSix;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellSeven;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEight;


@end
