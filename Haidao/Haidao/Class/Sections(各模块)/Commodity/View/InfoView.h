//
//  InfoView.h
//  Haidao
//
//  Created by 1860 on 16/7/17.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, InfoViewButtonType)
{
    /**  关注按钮  */
    InfoViewButtonAttentionType = 0,
    /**  店铺首页按钮  */
    InfoViewButtonStoreHomeType,
    /**  全部商品按钮  */
    InfoViewButtonAllCommodityType,
    /**  热销商品按钮  */
    InfoViewButtonHotsCommodityType,
    /**  最新上架商品按钮  */
    InfoViewButtonNewsCommodityType,
    /**  联系客服按钮  */
    InfoViewButtonServiceType,
};
@protocol InfoViewDelegate <NSObject>

@optional
/**
 *  点击量InfoView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickInfoViewButtonWithType:(InfoViewButtonType)type;

@end

@interface InfoView : UIView

/**  是否显示联系客服、进入首页按钮  */
@property (nonatomic, assign) BOOL isShowService;

/**  代理对象  */
@property (nonatomic, weak) id<InfoViewDelegate> delegate;


@end
