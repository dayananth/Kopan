//
//  MyAccountTableViewCell.h
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrouponCoupon.h"
#import "GrouponDeal.h"

@interface MyAccountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dealImageURL;
@property (weak, nonatomic) IBOutlet UILabel *dealTitile;
@property (weak, nonatomic) IBOutlet UILabel *dealOptionTitle;
@property (weak, nonatomic) IBOutlet UILabel *voucherCode;
@property (weak, nonatomic) IBOutlet UILabel *expiresAt;
@property (weak, nonatomic) GrouponCoupon * grouponCoupon;

-(void) fillDeal:(GrouponDeal*) deal;
- (void) setGrouponCouponRecord:(GrouponCoupon *)grouponCoupon;
@end
