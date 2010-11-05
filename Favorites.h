//
//  Favorites.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface Favorites : UITableViewController {

	
	NSMutableArray *favoritesArray;

	NSManagedObjectContext *managedObjectContext;

	
}

@property (nonatomic, retain) NSMutableArray *favoritesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
