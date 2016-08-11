//
//  MakeSureSettleAccountsView.h
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MakeSureSettleAccountsViewDelegate <NSObject>

@optional
- (void)MakeSureSettleAccountsView:(BOOL)settleAccounts;

@end

@interface MakeSureSettleAccountsView : UIView

/**
 *  设置确认信息数据
 *
 *  @param businessName  商家名称
 *  @param telephone     电话
 *  @param clearingMoney 结算金额
 *  @param clearingType  结算类型
 *  @param clearingTime  时间
 */
- (void)setMakeSureSettleAccountsViewWithBusinessName:(NSString *)businessName telephone:(NSString *)telephone clearingMoney:(NSString *)clearingMoney clearingType:(NSString *)clearingType clearingTime:(NSString *)clearingTime;

/**  代理对象  */
@property (nonatomic, weak) id<MakeSureSettleAccountsViewDelegate> delegate;

@end
