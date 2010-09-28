//
//  CSGoldParser.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSGoldParser.h"


@implementation CSGoldParser

- (void)parseWithData:(NSData *)data{
	
	theParser = [[NSXMLParser alloc] initWithData:data];
	[theParser setDelegate:self];
	[theParser setShouldProcessNamespaces:NO];
	[theParser setShouldReportNamespacePrefixes:NO];
	[theParser setShouldResolveExternalEntities:NO];
	
	[theParser parse];
	
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"Found CSGold File and started parsing");
	
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    // Store plan type and meals remaining in NSUserDefaults and Post Notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CSGold DownloadCompleted" object:nil];
	
	NSLog(@"Posted Notification Regarding CSGold");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	// Handle Error
}

#define onecard 1
#define polarpoints 2

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
	// set the current element
	currentElement = elementName;
	
	// Checks for One Card Balance
	if ([elementName isEqualToString:@"dtCSGoldSVCBalances"] && [[attributeDict objectForKey:@"diffgr:id"] isEqualToString:@"dtCSGoldSVCBalances1"]) {
		currentSVCAccount = onecard;	
	}
	
	// Checks for Polar Points Balance
	if ([elementName isEqualToString:@"dtCSGoldSVCBalances"] && [[attributeDict objectForKey:@"diffgr:id"] isEqualToString:@"dtCSGoldSVCBalances2"]) {
		currentSVCAccount = polarpoints;	
	}
	
	
	
	
	
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"MEDIUMBUCKET"]) {
		NSLog(@"Meals Remaining = %@", string);
		[[NSUserDefaults standardUserDefaults] setValue:string forKey:@"MealsRemaining"];

	}
	
	if ([currentElement isEqualToString:@"DESCRIPTION"]) {
		NSLog(@"Meal Plan = %@", string);
		
	}
	
	if ([currentElement isEqualToString:@"BALANCE"]) {
		
		if (currentSVCAccount == polarpoints) {
			NSLog(@"Polar Points Balance = %@", string);
			[[NSUserDefaults standardUserDefaults] setValue:string forKey:@"PolarPointBalance"];

		}
		
		if (currentSVCAccount == onecard) {
			NSLog(@"One Card Balance = %@", string);
			[[NSUserDefaults standardUserDefaults] setValue:string forKey:@"OneCardBalance"];

		}
		
		
	}
	
}

@end
