//
//  HotboomView.h
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRTextField.h"

@interface HotboomView : UIView

/**  名字  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  输入框  */
@property (nonatomic, strong) FRTextField *textFiled;
/**  属性  */
@property (nonatomic, strong) UILabel *detailLabel;

@end
