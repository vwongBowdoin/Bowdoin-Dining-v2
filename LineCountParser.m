//
//  LineCountParser.m
//  DiningTableViewTest
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LineCountParser.h"

@interface LineCountParser (PrivateMethods)

-(NSNumber*)returnNSNumberForString:(NSString*)inputString;

@end


@implementation LineCountParser

@synthesize thorne_Line_Array, moulton_Line_Array, express_Line_Array;

- (void)parseWithData:(NSData *)data{
	
	theParser = [[NSXMLParser alloc] initWithData:data];
	[theParser setDelegate:self];
	[theParser setShouldProcessNamespaces:NO];
	[theParser setShouldReportNamespacePrefixes:NO];
	[theParser setShouldResolveExternalEntities:NO];
	[theParser parse];
	
	
}

- (NSMutableArray*)returnThorneCounts{
	return thorne_Line_Array;
}

- (NSMutableArray*)returnMoultonCounts{
	return moulton_Line_Array;
}

- (NSMutableArray*)returnExpressCounts{
	return express_Line_Array;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"Found CSGold File and started parsing");
	
	thorne_Line_Array = [[NSMutableArray alloc] init];
	moulton_Line_Array = [[NSMutableArray alloc] init];
	express_Line_Array = [[NSMutableArray alloc] init];
	
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
	NSLog(@"Done With Document");
	

	NSLog(@"Thorne Line Counts:");
	NSLog(@"%@", thorne_Line_Array);
	
	NSLog(@"Moulton Line Counts:");
	NSLog(@"%@", moulton_Line_Array);
	
	NSLog(@"Express Line Counts:");
	NSLog(@"%@", express_Line_Array);
	
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

	currentElement = elementName;

	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	// Line Counts
	if ([currentElement isEqualToString:@"LOCATION"]) {
		
		if ([string isEqualToString:@"MU Aero 01"]) {
			currentLineLocation = @"moulton";
		} else if ([string isEqualToString:@"MU Aero 02 - Polar Express"]) {
			currentLineLocation = @"express";
		} else if ([string isEqualToString:@"Thorne Aero 01"]) {
			currentLineLocation = @"thorne";
		}
		
	}
	
	if ([currentElement isEqualToString:@"LINECOUNT"]) {
		
		if ([currentLineLocation isEqualToString:@"thorne"]) {
			[thorne_Line_Array addObject:[self returnNSNumberForString:string]];
		}
		else if ([currentLineLocation isEqualToString:@"moulton"]) {
			[moulton_Line_Array addObject:[self returnNSNumberForString:string]];
			
		}
		else if ([currentLineLocation isEqualToString:@"express"]) {
			[express_Line_Array addObject:[self returnNSNumberForString:string]];
			
		}
	}
}	


-(NSNumber*)returnNSNumberForString:(NSString*)inputString{
	
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * myNumber = [f numberFromString:inputString];
	[f release];
	
	return myNumber;
	
}


- (void)dealloc{
	
	[theParser release];
	[thorne_Line_Array release];
	[moulton_Line_Array release];
	[express_Line_Array release];
	[super dealloc];
}

@end
