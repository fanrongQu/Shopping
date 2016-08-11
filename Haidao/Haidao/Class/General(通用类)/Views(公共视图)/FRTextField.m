//
//  BaseTextFiled.m
//  Haidao
//
//  Created by 1860 on 16/7/12.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRTextField.h"

@implementation FRTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
//        self.layer.cornerRadius = 5.0;
//        self.layer.borderWidth = 1.0;
//        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];//边框颜色
//        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];//设置左边距
//        self.leftView = leftView;
//        self.leftViewMode = UITextFieldViewModeAlways;//一直显示UITextField的leftView
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textColor = [UIColor blackColor];
        self.returnKeyType = UIReturnKeyDone;//确定按钮类型
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


@end
