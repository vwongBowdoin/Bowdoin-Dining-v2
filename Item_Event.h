//
//  Item_Event.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Item.h"


@interface Item_Event :  Item  
{
}

@property (nonatomic, retain) NSString * Dining_Hall;
@property (nonatomic, retain) NSString * Meal_Name;
@property (nonatomic, retain) NSDate * Date_of_Event;

@end



