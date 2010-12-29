//
//  GrillParser.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GrillParser : NSObject <NSXMLParserDelegate> {

	NSXMLParser * rssParser;

	NSMutableArray *cafeGrillSpecials;
	NSMutableDictionary *currentDaySpecials;
	NSMutableArray *specialsForToday;
	
	NSString * currentElement, * currentUnit, * currentItem;

}

@property (nonatomic, retain) NSString *currentUnit;
@property (nonatomic, retain) NSMutableArray *cafeGrillSpecials;
@property (nonatomic, retain) NSMutableDictionary *currentDaySpecials;

-(void)parseSpecialsFromData:(NSData*)data;


@end
