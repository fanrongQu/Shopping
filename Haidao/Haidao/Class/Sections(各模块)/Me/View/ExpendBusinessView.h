//
//  ExpendBusinessView.h
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpendButton.h"

typedef NS_ENUM(NSInteger,ExpendBusinessViewType) {
    /**  赠送积分  */
    ExpendBusinessViewPresentIntegralType = 0,
    /**  消费让利  */
    ExpendBusinessViewExpendProfitsType,
    /**  商家让利  */
    ExpendBusinessViewMerchantProfitsType,
    /**  商家货款  */
    ExpendBusinessViewBusinessPaymentType,
    /**  保证金  */
    ExpendBusinessViewRefundableMoneyType,
};

@protocol ExpendBusinessViewDelegate <NSObject>

@optional
/**
 *  点击量ExpendBusinessView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickExpendBusinessViewButtonWithType:(ExpendBusinessViewType)type;

@end

@interface ExpendBusinessView : UIView

/**  代理对象  */
@property (nonatomic, assign) id<ExpendBusinessViewDelegate> delegate;

@end
