//
//  couponParseClient.h
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/29/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface couponParseClient : NSObject
- (void) getVouchers:(int) userID:(void(^)(NSArray* vouchers, NSError* error)) completion;
@property (nonatomic, strong) void(^ getVouchersCompletion)(NSArray* user, NSError* error);
@end
