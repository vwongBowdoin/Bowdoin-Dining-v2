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
	IBOutlet UILabel *thorneCount;
	IBOutlet UILabel *moultonCount;
	IBOutlet UILabel *expressCount;
	
	IBOutlet UILabel *totalPatrons;
	
	IBOutlet UIButton *refreshButton;
	
	IBOutlet UISegmentedControl *accuracy;
	IBOutlet UISegmentedControl *location;
	IBOutlet UISegmentedControl *line;
	IBOutlet UISegmentedControl *crowd;
	
	MBProgressHUD *HUD;
	
	NSData *stored_data;
}

@property (nonatomic, retain) IBOutlet UILabel *thorne_label;
@property (nonatomic, retain) IBOutlet UILabel *moulton_label;
@property (nonatomic, retain) IBOutlet UILabel *express_label;
@property (nonatomic, retain) IBOutlet UILabel *thorneCount;
@property (nonatomic, retain) IBOutlet UILabel *moultonCount;
@property (nonatomic, retain) IBOutlet UILabel *expressCount;
@property (nonatomic, retain) IBOutlet UILabel *totalPatrons;

@property (nonatomic, retain) IBOutlet UIButton *refreshButton;


-(IBAction)refresh;
-(IBAction)report;
-(void)analyzeData:(NSData*)theData;

@end

