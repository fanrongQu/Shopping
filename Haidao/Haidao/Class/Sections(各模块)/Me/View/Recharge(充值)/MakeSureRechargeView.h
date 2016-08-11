//
//  MakeSureRechargeView.h
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MakeSureRechargeViewDelegate <NSObject>

@optional
- (void)makeSureRechargeView:(BOOL)settleAccounts;

@end

@interface MakeSureRechargeView : UIView

/**
 *  设置确认信息数据
 *
 *  @param businessName     商家名称
 *  @param telephone        电话
 *  @param rechargeMoney    充值金额金额
 *  @param receiveIntegral  获赠积分
 */
- (void)setMakeSureRechargeViewWithBusinessName:(NSString *)businessName telephone:(NSString *)telephone rechargeMoney:(NSString *)rechargeMoney receiveIntegral:(NSString *)receiveIntegral;

/**  代理对象  */
@property (nonatomic, weak) id<MakeSureRechargeViewDelegate> delegate;

@end
