//
//  ShippingAddressCell.h
//  Haidao
//
//  Created by 1860 on 16/8/20.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShippingAddressCellDelegate <NSObject>

@optional

- (void)setDefaultShippingAddressAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeShippingAddressAtIndexPath:(NSIndexPath *)indexPath;

- (void)editShippingAddressAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ShippingAddressCell : UITableViewCell

/**  默认  */
@property (nonatomic, strong) UIButton *settingDefaultBtn;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setShippingAddressName:(NSString *)name phone:(NSString *)phone address:(NSString *)address indexPath:(NSIndexPath *)indexPath;

/**  代理对象  */
@property (nonatomic, weak) id<ShippingAddressCellDelegate> delegate;

@end
