//
//  AddShippingAddressViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/20.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "AddShippingAddressViewController.h"
#import "HotboomView.h"

@interface AddShippingAddressViewController ()

/**  收货人  */
@property (nonatomic, strong) HotboomView *nameView;
/**  手机号  */
@property (nonatomic, strong) HotboomView *phoneView;
/**  地区  */
@property (nonatomic, strong) HotboomView *areaView;
/**  地址  */
@property (nonatomic, strong) HotboomView *addressView;
/**  是否为默认地址  */
@property (nonatomic, strong) UIView *defautView;
/**  开关  */
@property (nonatomic, strong) UISwitch *defaultSwitch;

@end

@implementation AddShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    UITapGestureRecognizer *areaViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAreaView)];
    [self.areaView addGestureRecognizer:areaViewTapGesture];

}

- (instancetype)init {
    if (self = [super init]) {
        
        [self defautView];
    }
    return self;
}


- (void)setShippingAddressName:(NSString *)name phone:(NSString *)phone area:(NSString *)area address:(NSString *)address defaultAddress:(BOOL)defaultAddress {
    
    self.nameView.textFiled.text = name;
    self.phoneView.textFiled.text = phone;
    self.areaView.detailLabel.text = area;
    self.addressView.textFiled.text = address;
    self.defaultSwitch.on = defaultAddress;
}

- (void)rightBarButtonItemClick {
    NSLog(@"保存");
    
}

- (void)changeAreaView {
    NSLog(@"选择地区");
}


#pragma mark - 懒加载
- (HotboomView *)nameView {
    if (!_nameView) {
        _nameView = [[HotboomView alloc]init];
        [self.view addSubview:_nameView];
        [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45));
        }];
        _nameView.titleLabel.text = @"收货人";
        _nameView.textFiled.placeholder = @"收货人姓名";
    }
    return _nameView;
}

- (HotboomView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[HotboomView alloc]init];
        [self.view addSubview:_phoneView];
        __weak typeof(self) weakSelf = self;
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.nameView);
            make.size.mas_equalTo(weakSelf.nameView);
        }];
        _phoneView.titleLabel.text = @"手机号";
        _phoneView.textFiled.placeholder = @"收货人手机号";
    }
    return _phoneView;
}



- (HotboomView *)areaView {
    if (!_areaView) {
        _areaView = [[HotboomView alloc]init];
        [self.view addSubview:_areaView];
        __weak typeof(self) weakSelf = self;
        [_areaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.phoneView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.nameView);
            make.size.mas_equalTo(weakSelf.nameView);
        }];
        _areaView.titleLabel.text = @"所在地区";
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_areaView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
    }
    return _areaView;
}

- (HotboomView *)addressView {
    if (!_addressView) {
        _addressView = [[HotboomView alloc]init];
        [self.view addSubview:_addressView];
        __weak typeof(self) weakSelf = self;
        [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.areaView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.nameView);
            make.size.mas_equalTo(weakSelf.nameView);
        }];
        _addressView.titleLabel.text = @"详细地址";
        _addressView.textFiled.placeholder = @"街道、门牌号等";
    }
    return _addressView;
}

- (UIView *)defautView {
    if (!_defautView) {
        _defautView = [[UIView alloc]init];
        [self.view addSubview:_defautView];
        __weak typeof(self) weakSelf = self;
        [_defautView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.addressView.mas_bottom).offset(1);
            make.left.mas_equalTo(weakSelf.nameView);
            make.size.mas_equalTo(weakSelf.nameView);
        }];
        _defautView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]init];
        [_defautView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        label.font = kFontSize(14);
        label.text = @"设为默认";
    }
    return _defautView;
}

- (UISwitch *)defaultSwitch {
    if (!_defaultSwitch) {
        _defaultSwitch = [[UISwitch alloc]init];
        [self.defautView addSubview:_defaultSwitch];
        [_defaultSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
        
    }
    return _defaultSwitch;
}



@end
