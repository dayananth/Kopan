//
//  GrouponDeal.h
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponDeal : NSObject
@property (strong, nonatomic) NSDictionary* deal;
@property(strong, nonatomic) NSString* dealId;
@property(strong, nonatomic) NSString* dealTitle;
@property(strong, nonatomic) NSString* dealOptionTitle;
@property(strong, nonatomic) NSString* dealImageUrl;

- (id) initWithDictionary:(NSDictionary*) deal;

@end
