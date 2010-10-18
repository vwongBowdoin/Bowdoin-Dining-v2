//
//  HoursViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScheduleDecider;
@class UICustomTableView;

@interface HoursViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
 
    ScheduleDecider *localScheduler;
    NSMutableArray *openNowArray;
    
    IBOutlet UICustomTableView *theTableView;
}

@property (nonatomic, retain) IBOutlet UICustomTableView *theTableView;
@property (nonatomic, retain) ScheduleDecider *hoursScheduler;
@property (nonatomic, retain) NSMutableArray *openNowArray;


-(id)initWithScheduleDecider:(ScheduleDecider*)decider;
-(IBAction)backButtonSelected;


@end