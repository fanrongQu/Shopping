//
//  IntegralExchangeViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "IntegralExchangeViewController.h"
#import "HotboomView.h"

@interface IntegralExchangeViewController ()

/**  滚动视图  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  会员账号  */
@property (nonatomic, strong) HotboomView *accountNumberView;
/**  姓名电话  */
@property (nonatomic, strong) HotboomView *telephoneView;
/**  选择店铺  */
@property (nonatomic, strong) HotboomView *storeView;
/**  购物金额  */
@property (nonatomic, strong) HotboomView *monetaryView;
/**  让利金额  */
@property (nonatomic, strong) HotboomView *preferenceMoneyView;
/**  商品数量  */
@property (nonatomic, strong) HotboomView *productNumberView;
/**  商品名称  */
@property (nonatomic, strong) HotboomView *productNameView;
/**  交易密码  */
@property (nonatomic, strong) HotboomView *passwordView;
/**  生成订单  */
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation IntegralExchangeViewController

+ (void)showIntegralExchangeViewController:(UIViewController *)controller {
    
    IntegralExchangeViewController *IntegralExchangeVC = [[IntegralExchangeViewController alloc]init];
    [controller.navigationController pushViewController:IntegralExchangeVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分兑换";
    
    [self addEvent];
}

- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_accountNumberView != nil) _accountNumberView = nil;
    
    if (_telephoneView != nil) _telephoneView = nil;
    
    if (_storeView != nil) _storeView = nil;
    
    if (_productNameView != nil) _productNameView = nil;
    
    if (_monetaryView != nil) _monetaryView = nil;
    
    if (_productNumberView != nil) _productNumberView = nil;
    
    if (_preferenceMoneyView != nil) _preferenceMoneyView = nil;
    
    if (_passwordView != nil) _passwordView = nil;
    
    if (_orderButton != nil) _orderButton = nil;
}


- (void)addEvent {
    UITapGestureRecognizer *storeViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStore)];
    [self.storeView addGestureRecognizer:storeViewTapGesture];
    
    //提交订单
    [[self.orderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

/**
 *  选择店铺
 */
- (void)changeStore {
    NSLog(@"选择店铺");
}



#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _scrollView;
}

- (HotboomView *)accountNumberView {
    if (!_accountNumberView) {
        _accountNumberView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_accountNumberView];
        [_accountNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _accountNumberView.titleLabel.text = @"会员账户";
        _accountNumberView.textFiled.placeholder = @"请输入用户名/手机号";
    }
    return _accountNumberView;
}

- (HotboomView *)telephoneView {
    if (!_telephoneView) {
        _telephoneView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_telephoneView];
        __weak typeof(self) weakSelf = self;
        [_telephoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.accountNumberView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _telephoneView.titleLabel.text = @"姓名电话";
        _telephoneView.textFiled.placeholder = @"啦啦啦/15888888888";
    }
    return _telephoneView;
}

- (HotboomView *)storeView {
    if (!_storeView) {
        _storeView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_storeView];
        __weak typeof(self) weakSelf = self;
        [_storeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.telephoneView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _storeView.titleLabel.text = @"选择店铺";
        _storeView.detailLabel.text = @"盛世开元广告有限公司";
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_storeView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
    }
    return _storeView;
}

- (HotboomView *)monetaryView {
    if (!_monetaryView) {
        _monetaryView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_monetaryView];
        __weak typeof(self) weakSelf = self;
        [_monetaryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.storeView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _monetaryView.titleLabel.text = @"购物金额";
        _monetaryView.textFiled.placeholder = @"请输入购物金额";
    }
    return _monetaryView;
}

- (HotboomView *)preferenceMoneyView {
    if (!_preferenceMoneyView) {
        _preferenceMoneyView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_preferenceMoneyView];
        __weak typeof(self) weakSelf = self;
        [_preferenceMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.monetaryView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _preferenceMoneyView.titleLabel.text = @"让利金额";
        _preferenceMoneyView.textFiled.placeholder = @"请输入让利金额";
    }
    return _preferenceMoneyView;
}

- (HotboomView *)productNumberView {
    if (!_productNumberView) {
        _productNumberView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productNumberView];
        __weak typeof(self) weakSelf = self;
        [_productNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.preferenceMoneyView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productNumberView.titleLabel.text = @"商品数量";
        _productNumberView.textFiled.placeholder = @"请输入商品数量";
    }
    return _productNumberView;
}

- (HotboomView *)productNameView {
    if (!_productNameView) {
        _productNameView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productNameView];
        __weak typeof(self) weakSelf = self;
        [_productNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productNumberView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productNameView.titleLabel.text = @"商品名称";
        _productNameView.textFiled.placeholder = @"请输入商品名称";
    }
    return _productNameView;
}

- (HotboomView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_passwordView];
        __weak typeof(self) weakSelf = self;
        [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productNameView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _passwordView.titleLabel.text = @"交易密码";
        _passwordView.textFiled.placeholder = @"请输入交易密码";
    }
    return _passwordView;
}

- (UIButton *)orderButton {
    if (!_orderButton) {
        _orderButton = [[UIButton alloc]init];
        [self.scrollView addSubview:_orderButton];
        __weak typeof(self) weakSelf = self;
        [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.passwordView.mas_bottom).offset(20);
            make.width.mas_equalTo(kScreenWidth - 60);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(weakSelf.accountNumberView);
            make.bottom.mas_equalTo(-60);
        }];
        _orderButton.titleLabel.font = kFontSize(14);
        [_orderButton setTitle:@"生成订单" forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _orderButton.backgroundColor = kRedColor;
    }
    return _orderButton;
}

@end