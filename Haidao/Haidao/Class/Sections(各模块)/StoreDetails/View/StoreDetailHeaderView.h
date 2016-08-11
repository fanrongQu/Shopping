//
//  StoreDetailHeaderView.h
//  Haidao
//
//  Created by 1860 on 16/7/30.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StoreDetailHeaderViewButtonType)
{
    /**  关注按钮  */
    StoreDetailHeaderViewButtonAttentionType = 0,
    /**  店铺首页按钮  */
    StoreDetailHeaderViewButtonStoreHomeType,
    /**  全部商品按钮  */
    StoreDetailHeaderViewButtonAllCommodityType,
    /**  热销商品按钮  */
    StoreDetailHeaderViewButtonHotsCommodityType,
    /**  最新上架商品按钮  */
    StoreDetailHeaderViewButtonNewsCommodityType,
};
@protocol StoreDetailHeaderViewDelegate <NSObject>

@optional
/**
 *  点击量StoreDetailHeaderView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickStoreDetailHeaderViewButtonWithType:(StoreDetailHeaderViewButtonType)type;

@end

@interface StoreDetailHeaderView : UIView

/**  是否显示联系客服、进入首页按钮  */
@property (nonatomic, assign) BOOL isShowService;

/**  代理对象  */
@property (nonatomic, weak) id<StoreDetailHeaderViewDelegate> delegate;

@end
