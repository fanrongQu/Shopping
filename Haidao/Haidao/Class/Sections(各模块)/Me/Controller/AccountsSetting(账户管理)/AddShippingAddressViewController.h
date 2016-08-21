//
//  AddShippingAddressViewController.h
//  Haidao
//
//  Created by 1860 on 16/8/20.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "BaseViewController.h"

@interface AddShippingAddressViewController : BaseViewController

- (void)setShippingAddressName:(NSString *)name phone:(NSString *)phone area:(NSString *)area address:(NSString *)address defaultAddress:(BOOL)defaultAddress;

@end
