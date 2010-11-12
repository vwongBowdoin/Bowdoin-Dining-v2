//
//  LogInViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PolarPoints;

@interface LogInViewController : UIViewController <UITextFieldDelegate> {

	IBOutlet UISwitch *saveSwitch;
	IBOutlet UITextField *userNameField;
	IBOutlet UITextField *passwordField;
	
	
	PolarPoints *delegate;
	
}

@property (nonatomic, retain) NSObject *delegate;

-(IBAction)dismissModalController;
-(IBAction)launchPolarPoints;


@end
