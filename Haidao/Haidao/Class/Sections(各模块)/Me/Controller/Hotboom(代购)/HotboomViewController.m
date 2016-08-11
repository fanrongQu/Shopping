//
//  HotboomViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/8.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "HotboomViewController.h"
#import "HotboomView.h"

@interface HotboomViewController ()

/**  滚动视图  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  会员账号  */
@property (nonatomic, strong) HotboomView *accountNumberView;
/**  收货人  */
@property (nonatomic, strong) HotboomView *consigneeView;
/**  电话  */
@property (nonatomic, strong) HotboomView *telephoneView;
/**  代购网站  */
@property (nonatomic, strong) HotboomView *webSiteView;
/**  产品名称  */
@property (nonatomic, strong) HotboomView *productNameView;
/**  数量  */
@property (nonatomic, strong) HotboomView *productNumberView;
/**  属性  */
@property (nonatomic, strong) HotboomView *productTypeView;
/**  产品链接  */
@property (nonatomic, strong) HotboomView *productLinkView;
/**  收货地址  */
@property (nonatomic, strong) HotboomView *addressView;
/**  交易密码  */
@property (nonatomic, strong) HotboomView *passwordView;
/**  生成订单  */
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation HotboomViewController

+ (void)showHotboomViewController:(UIViewController *)controller {
    
    HotboomViewController *hotbottomVC = [[HotboomViewController alloc]init];
    [controller.navigationController pushViewController:hotbottomVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代购";
    
    [self addEvent];
}

- (void)addEvent {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeWebSite)];
    [self.webSiteView addGestureRecognizer:tapGesture];
    
    //提交订单
    [[self.orderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

/**
 *  修改代购网站
 */
- (void)changeWebSite {
    NSLog(@"修改代购网站");
}

- (void)dealloc {
    if (_scrollView != nil) _scrollView = nil;
    
    if (_accountNumberView != nil) _accountNumberView = nil;
    
    if (_consigneeView != nil) _consigneeView = nil;
    
    if (_telephoneView != nil) _telephoneView = nil;
    
    if (_webSiteView != nil) _webSiteView = nil;
    
    if (_productLinkView != nil) _productLinkView = nil;
    
    if (_productNameView != nil) _productNameView = nil;
    
    if (_productTypeView != nil) _productTypeView = nil;
    
    if (_productNumberView != nil) _productNumberView = nil;
    
    if (_addressView != nil) _addressView = nil;
    
    if (_passwordView != nil) _passwordView = nil;
    
    if (_orderButton != nil) _orderButton = nil;
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

- (HotboomView *)consigneeView {
    if (!_consigneeView) {
        _consigneeView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_consigneeView];
        __weak typeof(self) weakSelf = self;
        [_consigneeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.accountNumberView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _consigneeView.titleLabel.text = @"收货人";
        _consigneeView.textFiled.placeholder = @"请输入收货人姓名";
    }
    return _consigneeView;
}

- (HotboomView *)telephoneView {
    if (!_telephoneView) {
        _telephoneView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_telephoneView];
        __weak typeof(self) weakSelf = self;
        [_telephoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.consigneeView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _telephoneView.titleLabel.text = @"电话";
        _telephoneView.textFiled.placeholder = @"请输入收货人电话";
    }
    return _telephoneView;
}

- (HotboomView *)webSiteView {
    if (!_webSiteView) {
        _webSiteView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_webSiteView];
        __weak typeof(self) weakSelf = self;
        [_webSiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.telephoneView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _webSiteView.titleLabel.text = @"代购网站";
        _webSiteView.detailLabel.text = @"淘宝网";
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_webSiteView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
    }
    return _webSiteView;
}

- (HotboomView *)productNameView {
    if (!_productNameView) {
        _productNameView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productNameView];
        __weak typeof(self) weakSelf = self;
        [_productNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.webSiteView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productNameView.titleLabel.text = @"产品名称";
        _productNameView.textFiled.placeholder = @"请输入代购商品名称";
    }
    return _productNameView;
}

- (HotboomView *)productNumberView {
    if (!_productNumberView) {
        _productNumberView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productNumberView];
        __weak typeof(self) weakSelf = self;
        [_productNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productNameView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productNumberView.titleLabel.text = @"数量";
        _productNumberView.textFiled.placeholder = @"请输入代购数量";
    }
    return _productNumberView;
}

- (HotboomView *)productTypeView {
    if (!_productTypeView) {
        _productTypeView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productTypeView];
        __weak typeof(self) weakSelf = self;
        [_productTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productNumberView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productTypeView.titleLabel.text = @"属性";
        _productTypeView.textFiled.placeholder = @"请输入商品颜色、规格";
    }
    return _productTypeView;
}

- (HotboomView *)productLinkView {
    if (!_productLinkView) {
        _productLinkView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_productLinkView];
        __weak typeof(self) weakSelf = self;
        [_productLinkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productTypeView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _productLinkView.titleLabel.text = @"产品链接";
        _productLinkView.textFiled.placeholder = @"请输入产品链接地址";
    }
    return _productLinkView;
}

- (HotboomView *)addressView {
    if (!_addressView) {
        _addressView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_addressView];
        __weak typeof(self) weakSelf = self;
        [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.productLinkView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.accountNumberView);
            make.size.mas_equalTo(weakSelf.accountNumberView);
        }];
        _addressView.titleLabel.text = @"收货地址";
        _addressView.textFiled.placeholder = @"请输入收货地址";
    }
    return _addressView;
}

- (HotboomView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[HotboomView alloc]init];
        [self.scrollView addSubview:_passwordView];
        __weak typeof(self) weakSelf = self;
        [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.addressView.mas_bottom).offset(1);
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
