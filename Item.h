//
//  Item.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Item :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * item_Name;
@property (nonatomic, retain) NSString * course;

@end



