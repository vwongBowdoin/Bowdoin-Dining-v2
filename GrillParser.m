//
//  GrillParser.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GrillParser.h"

@interface GrillParser (PrivateMethods)

-(NSString *)documentsDirectory;

@end


@implementation GrillParser
@synthesize currentDaySpecials, cafeGrillSpecials, currentUnit;

-(void)parseSpecialsFromData:(NSData*)data{

	rssParser = [[NSXMLParser alloc] initWithData:data];
	
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[rssParser setDelegate:self];
	
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	
	currentDaySpecials = [[NSMutableDictionary alloc] init];
	cafeGrillSpecials = [[NSMutableArray alloc] init];
	//specialsForToday = [[NSMutableArray alloc] init];
	currentItem = [[NSString alloc] init];
	currentUnit = [[NSString alloc] init];

	
	
	[rssParser parse];
	
	
	
}


#pragma mark -
#pragma mark Parser Code

-(void)parserDidStartDocument:(NSXMLParser *)parser {	
	
	// Adds Value for Sunday Meal
	[currentDaySpecials setObject:@"There are no Grill Specials on the Weekend" forKey:@"magees"];
	[currentDaySpecials setObject:@"There are no Cafe Specials on the Weekend" forKey:@"cafe"];
	[cafeGrillSpecials addObject:currentDaySpecials];

	// Resets the Specials Dictionary
	currentDaySpecials = [[NSMutableDictionary alloc] init];

	
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
	// Adds Value for Saturday Meal
	[currentDaySpecials setObject:@"There are no Grill Specials on the Weekend" forKey:@"magees"];
	[currentDaySpecials setObject:@"There are no Cafe Specials on the Weekend" forKey:@"cafe"];
	[cafeGrillSpecials addObject:currentDaySpecials];
	
	// Resets the Specials Dictionary
	currentDaySpecials = [[NSMutableDictionary alloc] init];
	
	
	
    NSString *archivePath = [NSString stringWithFormat:@"%@/specials.xml",[self documentsDirectory]];
    [cafeGrillSpecials writeToFile:archivePath atomically:YES];
	//NSLog(@"Storing Specials: %@", [archivePath stringByReplacingOccurrencesOfString:[self documentsDirectory] withString:@""]);
	
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
	currentElement = [elementName copy];
	
	
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	// stores the current day specials after the day's specials have been entered
	if ([elementName isEqualToString:@"day"]) {
		
		[cafeGrillSpecials addObject:currentDaySpecials];
		
		//Wipes specials
		currentDaySpecials = [[NSMutableDictionary alloc] init];
		//specialsForToday = [[NSMutableArray alloc] init];
	}
	
	if ([elementName isEqualToString:@"item"]) {
		
		[currentDaySpecials setObject:currentItem forKey:currentUnit];
		
		// Resetting CurrentItem
		currentItem = [[NSString alloc] init];
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	
	if ([currentElement isEqualToString:@"description"]) {
		
		[currentDaySpecials setObject:string forKey:@"description"];
	}
	

	if ([currentElement isEqualToString:@"name"]) {
		
		if ([string isEqualToString:@"magees"]) {
			
			self.currentUnit = string;			
		} else if ([string isEqualToString:@"cafe"]) {
			
			self.currentUnit = string;
		}
		
	}
	
	if ([currentElement isEqualToString:@"item"]) {
		
		NSString *tempString = string;
		
		
		tempString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	
		currentItem = [currentItem stringByAppendingFormat:@"%@", tempString];
		

	}
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"**Error parsing Grill/ Specials XML: \n--%@", parseError);
	
}


-(NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}


	
@end
