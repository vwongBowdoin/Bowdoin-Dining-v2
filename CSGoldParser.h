//
//  CSGoldParser.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSGoldParser : NSObject <NSXMLParserDelegate> {

	
	NSXMLParser *theParser;
	NSString *currentElement;
	int currentSVCAccount;
	
	
	NSString *smallBucket;
	NSString *mediumBucket;
	
}

@property (nonatomic, retain) NSString *smallBucket;
@property (nonatomic, retain) NSString *mediumBucket;

- (void)parseWithData:(NSData *)data;

@end
