//
//  CSGoldController.h
//  DiningTableViewTest
//
//  Created by Ben Johnson on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSGoldController : NSObject {

	
	// Login Information
	NSString *userName;
	NSString *password;
	
	NSData *lineCountData;
	
}

@property (nonatomic, assign) NSString *userName;
@property (nonatomic, assign) NSString *password;


// Public Methods
- (void)getCSGoldDataWithUserName:(NSString*)user password:(NSString*)pass;

// Private Methods
- (void)updateAllCSGoldData;
- (NSMutableString*)returnSoapEnvelopeForService:(NSString*)serviceRequested;
- (void)createSOAPRequestWithEnvelope:(NSMutableString*)SOAPEnvelope;

@end
