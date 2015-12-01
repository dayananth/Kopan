//
//  GrouponClient.h
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyAccountViewController.h"
#import "MyAccountTableViewCell.h"

@interface GrouponClient : NSObject
- (void) getCoupons:(MyAccountViewController *) myAccountViewController;
+ (GrouponClient*)sharedInstance ;
- (void) getDealUUID:(int) dealId: (MyAccountTableViewCell*) tableViewCell;
@end
