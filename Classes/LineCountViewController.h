//
//  LineCountViewController.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "WristWatch.h"

@interface LineCountViewController : UIViewController <MFMailComposeViewControllerDelegate, MBProgressHUDDelegate> {

	IBOutlet UILabel *thorne_label;
	IBOutlet UILabel *moulton_label;
	IBOutlet UILabel *express_label;
	
	IBOutlet UIView *moultonDetails;
	IBOutlet UIView *thorneDetails;
	
	IBOutlet UILabel *thorneTen_label;
	IBOutlet UILabel *thorneThirty_label;
	IBOutlet UILabel *moultonTen_label;
	IBOutlet UILabel *moultonThirty_label;
	
	IBOutlet UILabel *thorne_name;
	IBOutlet UILabel *moulton_name;
	IBOutlet UILabel *express_name;
	
	IBOutlet UIImageView *thorne_clock;
	IBOutlet UIImageView *moulton_clock;
	IBOutlet UIImageView *express_clock;
	
	/*
	IBOutlet UILabel *descriptionsLabelOne;
	IBOutlet UILabel *descriptionsLabelTwo;
	IBOutlet UILabel *descriptionsLabelThree;
	IBOutlet UILabel *descriptionsLabelFour;
	
	IBOutlet UIImageView *personOne;
	IBOutlet UIImageView *personTwo;
	IBOutlet UIImageView *personThree;
	IBOutlet UIImageView *personFour;
	 */
	
	
	IBOutlet UIButton *moultonButton;
	IBOutlet UIButton *thorneButton;
	IBOutlet UIButton *expressButton;


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
	
	BOOL detailsVisible;
	
}

@property (nonatomic, retain) IBOutlet UILabel *thorne_label;
@property (nonatomic, retain) IBOutlet UILabel *moulton_label;
@property (nonatomic, retain) IBOutlet UILabel *express_label;

@property (nonatomic, retain) IBOutlet UILabel *thorneTen_label;
@property (nonatomic, retain) IBOutlet UILabel *thorneThirty_label;
@property (nonatomic, retain) IBOutlet UILabel *moultonTen_label;
@property (nonatomic, retain) IBOutlet UILabel *moultonThirty_label;

@property (nonatomic, retain) IBOutlet UILabel *currentTime_label;
@property (nonatomic, retain) IBOutlet UILabel *updatedTime_label;

@property (nonatomic, retain) NSTimer *repeatingTimer;


@property (nonatomic, retain) IBOutlet UIButton *refreshButton;


-(IBAction)refresh;
-(IBAction)report;
-(IBAction)toggleDetails;
- (IBAction)dismissPage;
-(void)analyzeData:(NSData*)theData;

@end

