//
//  ExpendPersonalView.h
//  Haidao
//
//  Created by 1860 on 16/8/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpendButton.h"

typedef NS_ENUM(NSInteger,ExpendPersonalViewType) {
    /**  赠送积分  */
    ExpendPersonalViewPresentIntegralType = 0,
    /**  消费让利  */
    ExpendPersonalViewExpendProfitsType,
};

@protocol ExpendPersonalViewDelegate <NSObject>

@optional
/**
 *  点击量ExpendPersonalView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickExpendPersonalViewButtonWithType:(ExpendPersonalViewType)type;

@end


@interface ExpendPersonalView : UIView

/**  代理对象  */
@property (nonatomic, assign) id<ExpendPersonalViewDelegate> delegate;

@end
