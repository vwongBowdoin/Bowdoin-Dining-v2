//
//  LineCountParser.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 11/16/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LineCountParser : NSObject <NSXMLParserDelegate> {

	NSXMLParser *theParser;
	NSString *currentElement;
	NSString *currentLineLocation;
	
	NSMutableArray *thorne_Line_Array;
	NSMutableArray *moulton_Line_Array;
	NSMutableArray *express_Line_Array;
	
}

@property (nonatomic, retain) NSMutableArray *thorne_Line_Array;
@property (nonatomic, retain) NSMutableArray *moulton_Line_Array;
@property (nonatomic, retain) NSMutableArray *express_Line_Array;


- (NSMutableArray*)returnThorneCounts;
- (NSMutableArray*)returnMoultonCounts;
- (NSMutableArray*)returnExpressCounts;


- (void)parseWithData:(NSData *)data;

@end
