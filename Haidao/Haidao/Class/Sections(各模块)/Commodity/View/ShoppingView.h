//
//  ShoppingView.h
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingNum.h"

@protocol ShoppingViewDelegate <NSObject>

/**
 *  选择的商品参数
 *
 *  @param size   商品尺寸
 *  @param color  商品颜色
 *  @param number 商品数量
 */
- (void)selectSize:(NSString *)size color:(NSString *)color number:(NSString *)number;

@end


@interface ShoppingView : UIView 

/**  确认按钮  */
@property (nonatomic, strong) UIButton *makeSureBtn;
/**  数量选择器  */
@property (nonatomic, strong) ShoppingNum *shoppingNum;

@property(nonatomic,assign)id delegate;

@end
