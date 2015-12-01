//
//  GrouponClient.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/28/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "GrouponClient.h"
#import "UIImageView+AFNetworking.h"
#import "GrouponCoupon.h"
#import "GrouponDeal.h"


@implementation GrouponClient

// Singleton
+ (GrouponClient*)sharedInstance {
    static GrouponClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil)
            instance = [[GrouponClient alloc] init];
    });
    return instance;
}

- (void) getCoupons:(MyAccountViewController*) myaccountViewController{
    NSString *urlString =
    @"http://orders-staging-mongrel-vip.snc1/tps/v1/users/49396665/orders.json?include_audit_records=true&include_billing_record=true&include_vouchers=true&page=1&per_page=25";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if(!error){
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSDictionary* orders = responseDictionary[@"orders"];
                                                    NSMutableArray* couponObjects = [[NSMutableArray alloc]init];
                                                    for(NSDictionary* order in orders){
                                                       NSDictionary* item = order[@"items"][0];
                                                       NSDictionary* vouchers = item[@"vouchers"];
                                                        if(!vouchers){
                                                            continue;
                                                        }
                                                        for(NSDictionary* voucher in vouchers){
                                                            int merchantRedeemed = [voucher[@"isMerchantRedeemed"] intValue];
                                                            int recipientRedeemed = [voucher[@"isRecipientRedeemed"] intValue];
                                                            NSString* status = voucher[@"status"];
//                                                            BOOL hasShipments = voucher[@"hasShipments"];
                                                            if(merchantRedeemed == 0 &&
                                                               recipientRedeemed == 0 &&
                                                                [status isEqualToString: @"collected"]){
                                                                GrouponCoupon* coupon = [[GrouponCoupon alloc ]initWithDictionary:voucher];
                                                                [couponObjects addObject:coupon];
                                                            }
                                                        }
                                                    }
                                                    [myaccountViewController showCoupons:couponObjects];
                                                }
                                            }];
    [task resume];
}

- (void) getDealUUID:(int) dealId: (MyAccountTableViewCell*) tableViewCell{
    
    NSString* formattedUrlString = [NSString stringWithFormat:@"http://deal-catalog-staging.snc1/deal_catalog/v1/deals/lookupId?clientId=5e196dc4f9d2ba1d-cs-tools&legacyId=%d", dealId];
    
    NSURL *url = [NSURL URLWithString:formattedUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:config
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if(!error){
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSDictionary* deal = responseDictionary[@"deal"];
                                                    NSString* dealUUID = deal[@"id"];
                                                    [self getDeal:dealUUID :tableViewCell];
                                                }
                                            }];
    [task resume];
}

- (void) getDeal:(NSString*)dealUUID: (MyAccountTableViewCell*) tableViewCell{
    NSString *queryParams =
    @"client_id=ca6f87fa6d32e26aeb653a5d9a15b0a5b6d0f027&show=database_id%2Cid%2Cnote_count%2Ctitle%2Cis_tipped%2Cuses_generated_voucher_codes%2Cchannels%2Cshipping_address_required%2Coptions%2Coptions.id%2Coptions.title%2Coptions.price%2Coptions%28giftWrappingCharge%2CshippingOptions%2CschedulerOptions%2CinventoryService%29%2Call_pledges%2Cis_now_deal%2Cstart_at%2Cend_at%2Cfine_print%2Cinstructions%2Csalesforce_link%2Cmerchant%28redemptionProcesses%29%2Cstatus%2Cdivision%2Cis_travel_bookable_deal%2Csidebar_image_url%2Cuuid";

    NSString* formattedUrlString = [NSString stringWithFormat:@"http://api.staging-snc1.groupon.com/v2/deals/%@.json?%@", dealUUID, queryParams];
    
    NSURL *url = [NSURL URLWithString:formattedUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    

//    [config setHTTPAdditionalHeaders:@{@"ssl_verifypeer": @false}];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:config
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if(!error){
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSDictionary* deal = responseDictionary[@"deal"];
//                                                    
//                                                    [tableViewCell fillDeal:[[GrouponDeal alloc] initWithDictionary:deal :tableViewCell.grouponCoupon.dealOptionId]];
                                                }
                                            }];
    [task resume];
}


@end
