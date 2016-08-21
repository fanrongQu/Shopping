//
//  MakeSureOrderViewController.m
//  Haidao
//
//  Created by 1860 on 16/8/21.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MakeSureOrderViewController.h"
#import "MakeSureOrderCell.h"
#import "MakeSureOrderHeaderView.h"
#import "MakeSureOrderFooterView.h"

@interface MakeSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  订单列表  */
@property (nonatomic, strong) UITableView *tableView;
/**  headerView  */
@property (nonatomic, strong) UIView *headerView;
/**  收货人  */
@property (nonatomic, strong) UILabel *nameLabel;
/**  收货人电话  */
@property (nonatomic, strong) UILabel *phoneLabel;
/**  收货人地址  */
@property (nonatomic, strong) UILabel *addressLabel;

/**  底部确认栏  */
@property (nonatomic, strong) UIView *bottomView;
/**  合计  */
@property (nonatomic, strong) UILabel *totalLabel;
/**  价格  */
@property (nonatomic, strong) UILabel *priceLabel;
/**  提交订单  */
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation MakeSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    [self tableView];
    [self setName:@"IOS-RONG" phone:@"15839952321" address:@"河南省南阳市宛城区长江路80号南阳理工学院" totalPrice:@"400.00"];
}

- (void)dealloc {
    
    if (_tableView != nil) _tableView = nil;
    if (_headerView != nil) _headerView = nil;
    if (_nameLabel != nil) _nameLabel = nil;
    if (_phoneLabel != nil) _phoneLabel = nil;
    if (_addressLabel != nil) _addressLabel = nil;
    if (_bottomView != nil) _bottomView = nil;
    if (_submitButton != nil) _submitButton = nil;
    if (_priceLabel != nil) _priceLabel = nil;
    if (_totalLabel != nil) _totalLabel = nil;
}


- (void)setName:(NSString *)name phone:(NSString *)phone address:(NSString *)address totalPrice:(NSString *)price {
    self.nameLabel.text = name;
    NSString *string1 = [phone substringToIndex:3];
    NSString *string2 = [phone substringFromIndex:phone.length - 4];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"%@****%@",string1,string2];
    self.addressLabel.text = address;

    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    [self totalLabel];
}


#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MakeSureOrderCell *cell = [MakeSureOrderCell cellWithTableView:tableView];
    
    [cell setCommodityImage:nil name:@"2016新款韩版时尚夏季衬衣新款韩版时尚夏季衬衣" color:@"白色" size:@"XL" price:@"120" oldPrice:@"130" num:@"2"];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 146;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MakeSureOrderHeaderView *headerView = [MakeSureOrderHeaderView headerViewWithTableView:tableView];
    
    [headerView setMakeSureOrderHeaderViewTitle:@"汇佰硕电子商行"];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MakeSureOrderFooterView *footerView = [MakeSureOrderFooterView footerViewWithTableView:tableView];
    
    return footerView;
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 49, 0));
        }];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
        
        
        [_tableView registerClass:[MakeSureOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"MakeSureOrderHeaderView"];
        [_tableView registerClass:[MakeSureOrderFooterView class] forHeaderFooterViewReuseIdentifier:@"MakeSureOrderFooterView"];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 85)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [_headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [imageView setImage:[UIImage imageNamed:@"导向"]];
        
    }
    return _headerView;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [self.headerView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
        }];
        
        _nameLabel.font = kFontSize(14);
    }
    return _nameLabel;
}


- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        [self.headerView addSubview:_phoneLabel];
        __weak typeof(self) weakSelf = self;
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel);
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(20);
        }];
        
        _phoneLabel.font = kFontSize(14);
    }
    return _phoneLabel;
}


- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        [self.headerView addSubview:_addressLabel];
        __weak typeof(self) weakSelf = self;
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        _addressLabel.font = kFontSize(14);
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(49);
        }];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]init];
        [self.bottomView addSubview:_submitButton];
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_equalTo(120);
        }];
        
        _submitButton.titleLabel.font = kFontSize(14);
        _submitButton.backgroundColor = kSubjectColor;
        
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitButton;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [self.bottomView addSubview:_priceLabel];
        __weak typeof(self) weakSelf = self;
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.submitButton.mas_left).offset(-25);
            make.centerY.mas_equalTo(0);
        }];
        
        _priceLabel.font = kFontSize(14);
        _priceLabel.textColor = kSubjectColor;
    }
    return _priceLabel;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]init];
        [self.bottomView addSubview:_totalLabel];
        __weak typeof(self) weakSelf = self;
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.priceLabel.mas_left);
            make.centerY.mas_equalTo(0);
        }];
        
        _totalLabel.font = kFontSize(14);
        _totalLabel.text = @"合计：";
        
    }
    return _totalLabel;
}

@end
