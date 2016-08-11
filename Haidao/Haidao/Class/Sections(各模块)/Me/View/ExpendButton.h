//
//  ExpendButton.h
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ExpendButtonType) {
    /**  赠送积分  */
    ExpendButtonPresentIntegralType = 0,
    /**  消费让利  */
    ExpendButtonExpendProfitsType,
    /**  商家让利  */
    ExpendButtonMerchantProfitsType,
};

@interface ExpendButton : UIButton

- (void)setExpendButtonWithExpendNum:(NSString *)expendNum expendType:(ExpendButtonType)expendButtonType todayExpendNum:(NSString *)todayExpendNum totalExpendNum:(NSString *)totalExpendNum;

@end
