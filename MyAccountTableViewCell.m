//
//  MyAccountTableViewCell.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "MyAccountTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "GrouponClient.h"
#import "MBProgressHUD.h"

@implementation MyAccountTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setGrouponCouponRecord:(GrouponCoupon *)grouponCoupon{
    [MBProgressHUD showHUDAddedTo:self.dealImageURL animated:YES];
    self.grouponCoupon = grouponCoupon;

    [grouponCoupon setMyAccountTableViewCell:self];
    self.voucherCode.text = [grouponCoupon couponCode];
    self.expiresAt.text = [NSString stringWithFormat:@"%@", [grouponCoupon expiresAt]];
    self.dealTitile.text = [grouponCoupon.deal dealTitle];
    self.dealOptionTitle.text = [grouponCoupon.deal dealOptionTitle];
    [self.dealImageURL setImageWithURL: [NSURL URLWithString: [grouponCoupon.deal dealImageUrl ]]];
    [MBProgressHUD hideHUDForView:self.dealImageURL animated:YES];
    
}
@end
