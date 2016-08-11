//
//  ShoppingNum.h
//  Haidao
//
//  Created by 1860 on 16/7/14.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingNumDelegate <NSObject>

@optional
/**
 *  ShoppingNum警告信息
 *
 *  @param message 警告信息
 */
- (void)actionMessage:(NSString *)message;

@end

@interface ShoppingNum : UIView

/**  文本框  */
@property (nonatomic, strong) UITextField *numField;
/**  是否显示边框  */
@property (nonatomic, assign) BOOL showBorder;
/**  代理对象  */
@property (nonatomic, weak) id<ShoppingNumDelegate> delegate;

@end
