//
//  couponParseClient.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/29/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "couponParseClient.h"
#import "GrouponCoupon.h"


@implementation couponParseClient

- (void) getVouchers:(int) userID:(void(^)(NSArray* vouchers_return_obj, NSError* error)) completion{
    self.getVouchersCompletion = completion;
    
    NSString *urlString =
    @"https://api.parse.com/1/classes/vouchers";
    
    
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionary];
    [postDictionary setValue:[NSNumber numberWithInt:userID]  forKey:@"user_id"];
    
    NSMutableDictionary *includeDictionary = [NSMutableDictionary dictionary];
    [includeDictionary setValue:@"deal_id"  forKey:@"include"];
    
    
    NSError *error;
    NSData *postBody = [NSJSONSerialization dataWithJSONObject:postDictionary options:0 error:&error];
    NSString *json = [[NSString alloc] initWithData:postBody encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:json, @"where", nil];
    [parameters setValue:@"deal" forKey:@"include"];

    
//    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@&%@", urlString, parameters, json]];
    NSString *resultStr = [self addQueryStringToUrlString:urlString withDictionary:parameters];
    
    
    NSURL *url = [NSURL URLWithString:resultStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [config setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json", @"X-Parse-Application-Id": @"2n4m1TKv3LK28lUT8zJAWUUQXErlQwu6xoAVlDbu", @"X-Parse-REST-API-Key": @"DO73LhdLeoeNhNtcmIIglJEPYPzqwMO0oRMDw5V8" }];
    
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
                                                    NSDictionary* vouchers = responseDictionary[@"results"];
                                                    NSMutableArray* vouchersArray = [[NSMutableArray alloc]init];
                                                    for(NSDictionary* voucher in vouchers){
                                                        NSLog(@"%@", voucher);
                                                        GrouponCoupon* coupon =   [[GrouponCoupon alloc] initWithDictionary:voucher];
                                                        [vouchersArray addObject:coupon];
                                                    }
                                                    self.getVouchersCompletion(vouchersArray, nil);
                                                }
                                            }];
    [task resume];
    
}

- (NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary
{
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return urlWithQuerystring;
}

- (NSString*)urlEscapeString:(NSString *)unencodedString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *s = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return s;
}
@end
