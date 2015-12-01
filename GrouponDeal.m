//
//  GrouponDeal.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "GrouponDeal.h"

@implementation GrouponDeal
- (id) initWithDictionary:(NSDictionary*) deal
{
    self = [super init];
    if(self){
        self.deal = deal;
        self.dealId = deal[@"objectId"];
        self.dealTitle = deal[@"title"];
        self.dealOptionTitle = deal[@"option_title"];
        self.dealImageUrl = self.deal[@"image_url"];
    }
    return self;
}
@end
