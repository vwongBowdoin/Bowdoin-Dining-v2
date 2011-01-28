//
//  LineCountViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "WristWatch.h"

@interface LineCountViewController : UIViewController <MFMailComposeViewControllerDelegate, MBProgressHUDDelegate> {

	IBOutlet UILabel *thorne_label;
	IBOutlet UILabel *moulton_label;
	IBOutlet UILabel *express_label;
	IBOutlet UILabel *currentTime_label;
	IBOutlet UILabel *updatedTime_label;

	IBOutlet UIButton *refreshButton;
	
	IBOutlet UISegmentedControl *accuracy;
	IBOutlet UISegmentedControl *location;
	IBOutlet UISegmentedControl *line;
	IBOutlet UISegmentedControl *crowd;
	
	MBProgressHUD *HUD;
	
	NSData *stored_data;
	
	NSTimer *repeatingTimer;
	
}

@property (nonatomic, retain) IBOutlet UILabel *thorne_label;
@property (nonatomic, retain) IBOutlet UILabel *moulton_label;
@property (nonatomic, retain) IBOutlet UILabel *express_label;
@property (nonatomic, retain) IBOutlet UILabel *currentTime_label;
@property (nonatomic, retain) IBOutlet UILabel *updatedTime_label;

@property (nonatomic, retain) NSTimer *repeatingTimer;


@property (nonatomic, retain) IBOutlet UIButton *refreshButton;


-(IBAction)refresh;
-(IBAction)report;
- (IBAction)dismissPage;
-(void)analyzeData:(NSData*)theData;

@end

