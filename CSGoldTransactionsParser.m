//
//  CSGoldTransactionsParser.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 10/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSGoldTransactionsParser.h"


@implementation CSGoldTransactionsParser

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
    
	NSLog(@"Done With Document");
	
    // Store plan type and meals remaining in NSUserDefaults and Post Notification
	
	NSLog(@"Posting Notification");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"CSGold Transactions Completed" object:nil];
	
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"ERROR!");
	// Handle Error
}

#define onecard 1
#define polarpoints 2

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
	// set the current element
	currentElement = elementName;
	
	// Signifies a New Transaction
	if ([elementName isEqualToString:@"dtCSGoldGLTrans"]) {
		
		transactionsDict = [[NSMutableDictionary alloc] init];
		
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	// Signifies a New Transaction
	if ([elementName isEqualToString:@"dtCSGoldGLTrans"]) {
		
		[transactionsArray addObject:transactionsDict];

	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	
	if ([currentElement isEqualToString:@"TRANDATE"]) {
		// Transaction Date
		
		[transactionsDict setObject:string forKey:@"TRANDATE"];
		
	}
	
	if ([currentElement isEqualToString:@"LONGDES"]) {
		// Location Description
		
		[transactionsDict setObject:string forKey:@"LONGDES"];

	}
	
	if ([currentElement isEqualToString:@"APPRVALUEOFTRAN"]) {
		
		[transactionsDict setObject:[self returnFormattedMoneyBalance:string] forKey:@"APPRVALUEOFTRAN"];
		
	}

}

- (NSString*)returnFormattedMoneyBalance:(NSString *)inputString{
	NSString *stringToReturn;
	
	
	if (inputString !=nil) {
		
		NSString *firstHalf;
		NSString *secondHalf;
		
		int indexForPeriod;
		
		switch (inputString.length) {
				// Must be displayed as $0.00
			case 0:
				return @"$0.00";
				break;
				
				
				// Must be displayed $0.01
			case 1:
				
				return [NSString stringWithFormat:@"$0.0%@", inputString];
				break;
				
				// Must be displayed $0.12
			case 2:
				return [NSString stringWithFormat:@"$0.%@", inputString];
				break;
				
				// Must be displayed $1.23
			case 3:
				indexForPeriod = 1;
				break;
				
				
				// Must be displayed $12.34
			case 4:
				indexForPeriod = 2;
				break;
				
				// Must be displayed $123.45	
			case 5:
				indexForPeriod = 3;
				break;
				
				// Must be displayed $1234.56
			case 6:
				indexForPeriod = 4;
				break;
				
				// If they have this many polar points - I envy them and you should too.
			case 7:
				indexForPeriod = 5;
				break;
				
			default:
				break;
		}
		
		firstHalf = [inputString substringToIndex:indexForPeriod];
		secondHalf = [inputString substringFromIndex:indexForPeriod];
		
		stringToReturn = [NSString stringWithFormat:@"$%@.%@", firstHalf, secondHalf];
		
	}
	
	return stringToReturn;
	
}

@end
