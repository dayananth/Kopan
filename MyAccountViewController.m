//
//  ViewController.m
//  Kopan
//
//  Created by Nizha Shree Seenivasan on 11/27/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "MyAccountViewController.h"
#import "GrouponClient.h"
#import "GrouponCoupon.h"
#import "couponParseClient.h"
#import "MBProgressHUD.h"
#import "MyaccountHeaderTableViewCell.h"

@interface MyAccountViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *couponsTable;

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    self.couponsTable.dataSource = self;
    self.couponsTable.delegate = self;
    [self.couponsTable registerNib:[UINib nibWithNibName:@"MyAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAccountTableViewCell"];

    self.couponsTable.estimatedRowHeight = 300;
    self.couponsTable.rowHeight = UITableViewAutomaticDimension;
    [super viewDidLoad];
    [self loadCoupons];
//    [self pingParse];
}

-(void) pingParse{
    couponParseClient* couponclient = [[couponParseClient alloc] init];
    [couponclient getVouchers:1 :^(NSArray *vouchers, NSError *error) {
        if(!error){
            
        }
    } ];
}

- (void) loadCoupons{
//  GrouponClient* grouponClient =  [GrouponClient sharedInstance];
//  [MBProgressHUD showHUDAddedTo:self.couponsTable animated:YES];
//  [grouponClient getCoupons:self];
    couponParseClient* couponclient = [[couponParseClient alloc] init];
    [couponclient getVouchers:1 :^(NSArray *vouchers, NSError *error) {
        if(!error){
            [self showCoupons:vouchers];
        }
    } ];
}

- (void) showCoupons:(NSArray*) couponObjects{
    [MBProgressHUD hideHUDForView:self.couponsTable animated:YES];
    NSLog(@"%@", couponObjects);
    self.couponsArray = couponObjects;
    [self.couponsTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAccountTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyAccountTableViewCell"];
    GrouponCoupon* coupon =  self.couponsArray[indexPath.section];
    [cell setGrouponCouponRecord:coupon];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.couponsArray.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *CellIdentifier = @"sectionHeaderCell";
    MyAccountHeaderTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    GrouponCoupon* coupon =  self.couponsArray[section];
    headerView.voucher_title.text = [NSString stringWithFormat:@"Voucher Code: %@", coupon.couponCode];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}


@end
