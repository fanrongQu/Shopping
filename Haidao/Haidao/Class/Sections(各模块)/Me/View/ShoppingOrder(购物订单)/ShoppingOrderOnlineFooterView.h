//
//  ShoppingOrderOnlineFooterrView.h
//  Haidao
//
//  Created by 1860 on 16/8/19.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ShoppingOrderOnlineState) {
    /**  等待买家付款  */
    ShoppingOrderOnlineWaitPayState = 0,
    /**  买家已付款  */
    ShoppingOrderOnlinePaidState,
    /**  卖家已发货  */
    ShoppingOrderOnlineSendOutState,
    /**  交易完成  */
    ShoppingOrderOnlineFinishState,
};

@class ShoppingOrderOnlineFooterView;
@protocol ShoppingOrderOnlineFooterViewDelegate <NSObject>

@optional

/**
 *  左侧按钮被点击
 *
 *  @param section 对应的section
 *  @param state   footerView的状态
 */
- (void)footerViewLeftButtonClickInSection:(NSInteger)section state:(ShoppingOrderOnlineState)state;

/**
 *  右侧按钮被点击
 *
 *  @param section 对应的section
 *  @param state   footerView的状态
 */
- (void)footerViewRightButtonClickInSection:(NSInteger)section state:(ShoppingOrderOnlineState)state;


@end

@interface ShoppingOrderOnlineFooterView : UITableViewHeaderFooterView

/**
 *  根据tableView创建FooterView
 *
 *  @param tableView  tableView
 *
 *  @return FooterView
 */
+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

/**
 *  设置FooterView
 *
 *  @param price   价格
 *  @param freight 邮费
 *  @param number  数量
 *  @param section 组
 *  @param state   状态
 */
- (void)setFooterViewOfPrice:(NSString *)price freight:(NSString *)freight number:(NSString *)number section:(NSInteger)section state:(ShoppingOrderOnlineState)state;

/**  代理的对象  */
@property (nonatomic, weak) id<ShoppingOrderOnlineFooterViewDelegate> delegate;

@end
