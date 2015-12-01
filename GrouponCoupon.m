//
//  GrouponCoupon.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "GrouponCoupon.h"
#import "MyAccountTableViewCell.h"

@implementation GrouponCoupon

- (id) initWithDictionary:(NSDictionary*) coupon{
    self = [super init];
    if(self){
        self.coupon = coupon;
        self.couponCode = coupon[@"code"];
        self.source = coupon[@"source"];
        self.user_id = [coupon[@"user_id"] intValue];
        self.request_to_sell = coupon[@"request_to_sell"];
        self.expiresAt = [self parseDate:coupon[@"expires_at"][@"iso"]];
        self.deal = [[GrouponDeal alloc] initWithDictionary:coupon[@"deal"]];
    }
    return self;
}

- (NSDate*) parseDate: (NSString*) inputDate{
    if (inputDate == [NSNull null])
        return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd'T'HH::mm::ss.SSS'Z'";
    return [formatter dateFromString:inputDate];
}
@end
