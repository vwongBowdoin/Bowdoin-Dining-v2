//
//  GrillParser.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GrillParser.h"


@implementation GrillParser
@synthesize currentDaySpecials, cafeGrillSpecials;


-(id)init{
	
	
	currentDaySpecials = [[NSMutableDictionary alloc] init];
	cafeGrillSpecials = [[NSMutableArray alloc] init];
	
	return self;	
	
}

-(void)parseSpecialsFromData:(NSData*)data{

	rssParser = [[NSXMLParser alloc] initWithData:data];
	
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[rssParser setDelegate:self];
	
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[rssParser setShouldProcessNamespaces:NO];
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	
	[rssParser parse];
	
	
	
}


#pragma mark -
#pragma mark Parser Code

-(void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"Found Grill/Cafe XML and started parsing");


}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
	NSLog(@"Ended");
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
	currentElement = [elementName copy];
	
	
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	// stores the current day specials after the day's specials have been entered
	if ([elementName isEqualToString:@"day"]) {
		
		[cafeGrillSpecials addObject:currentDaySpecials];
	
	}
	
	if ([elementName isEqualToString:@"item"]) {
		[currentDaySpecials setObject:currentItem forKey:currentUnit];

	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	if ([currentElement isEqualToString:@"description"]) {
		
		// store the description of this week's special
		
	}
	

	if ([currentElement isEqualToString:@"name"]) {
		
		if ([string isEqualToString:@"magees"]) {
			
			currentUnit = string;
			
		} else if ([string isEqualToString:@"cafe"]) {
			
			currentUnit = string;
		}
		
	}
	
	if ([currentElement isEqualToString:@"item"]) {
		
		currentItem = [currentItem stringByAppendingString:string];

	}

	
	
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSString * errorString = [NSString stringWithFormat:@"Something went wrong! We were unable to download the menus right now. Sorry!"];
	[self performSelectorOnMainThread:@selector(displayError:) 
						   withObject:errorString
						waitUntilDone:false];
	
}

-(void)displayError:(NSString*)errorToDisplay {
	NSLog(@"Error parsing XML: %@", errorToDisplay);
	
}


	
@end
