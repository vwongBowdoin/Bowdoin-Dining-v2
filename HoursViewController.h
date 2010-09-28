//
//  HoursViewController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 8/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScheduleDecider;

@interface HoursViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
 
    ScheduleDecider *hoursScheduler;
    NSMutableArray *openArray;
    
    
}

@property (nonatomic, retain) ScheduleDecider *hoursScheduler;
@property (nonatomic, retain) NSMutableArray *openArray;

@end