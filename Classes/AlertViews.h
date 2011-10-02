//
//  AlertViews.h
//  Bowdoin Dining
//
//  Created by Ben Johnson on 12/23/10.
//  Copyright Two Fourteen Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlertViews : NSObject {

}


+ (UIView *)noMealAlert;
+ (UIView *)closedForSemesterAlert;
+ (UIView *)noInternetAlert;
+ (UIView *)noServerAlert;


@end
