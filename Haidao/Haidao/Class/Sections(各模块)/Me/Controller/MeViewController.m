//
//  MeViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "MeViewController.h"
#import "PersonalTopView.h"
#import "ExpendPersonalView.h"
#import "ExpendBusinessView.h"
#import "MeCollectionViewCell.h"

#import "PresentIntegralViewController.h"
#import "ReceiveListViewController.h"
#import "ExpendProfitsViewController.h"
#import "MerchantProfitsViewController.h"
#import "BusinessPaymentViewController.h"
#import "RefundableMoneyViewController.h"
#import "AccountsSettingViewController.h"
#import "SettingViewController.h"
#import "OrderManageViewController.h"
#import "ShoppingOrderViewController.h"
#import "HotboomViewController.h"
#import "SettingOrderViewController.h"
#import "IntegralExchangeViewController.h"
#import "SettleAccountsViewController.h"
#import "RechargeViewController.h"
#import "BusinessMemberViewController.h"
#import "StoreSettingViewController.h"

/** 页边距 */
static CGFloat const edgeDistance = 1;
/** CollectionView的item宽高比 */
static CGFloat const collectionViewW = 90;
/**  CollectionViewCell标记  */
static NSString * const collectionViewCellID = @"MeCollectionViewCell";
/**  列表视图的collectionReusableView标示符  */
static NSString * const collectionReusableViewHeaderID = @"MeCollectionReusableViewHeaderID";

@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ExpendBusinessViewDelegate,ExpendPersonalViewDelegate,PersonalTopViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
/**  个人赠送概览视图  */
@property (nonatomic, strong) ExpendPersonalView *expendPersonalView;
/**  商家赠送概览视图  */
@property (nonatomic, strong) ExpendBusinessView *expendBusinessView;
/**  功能分类  */
@property (nonatomic, strong) UICollectionView *collectionView;
/**  顶部视图  */
@property (nonatomic, strong) PersonalTopView *personalTopView;
/**  导航栏的透明度  */
@property (nonatomic, assign) CGFloat navigationBarAlpha;

/**  是否为商家  */
@property (nonatomic, assign) BOOL isBusiness;
/**  相关功能数组  */
@property (nonatomic, strong) NSArray *functionArray;

@end

@implementation MeViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isBusiness = YES;
    NSString *gradeType;
    if (_isBusiness) {
        self.functionArray = @[@[@"积分兑换",@"做单",@"结算",@"充值"],@[@"店铺设置",@"订单管理",@"商家会员",@"购物订单",@"我的代购"]];
        [self expendBusinessView];
        
        gradeType = @"商家";
    }else {
        self.functionArray = @[@[@"购物订单",@"我的代购"]];
        
        [self expendPersonalView];
        gradeType = @"注册会员";
    }
    [self.personalTopView setPersonalIcon:nil name:@"阳春白雪" gradeType:gradeType empiricalValue:@"100"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.delegate = self;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.scrollView.delegate = nil;
    
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)dealloc {
    
    if (_scrollView != nil) _scrollView = nil;
    
    if (_personalTopView != nil) _personalTopView = nil;
    
    if (_expendBusinessView != nil) _expendBusinessView = nil;
    
    if (_expendPersonalView != nil) _expendPersonalView = nil;
    
    if (_collectionView != nil) _collectionView = nil;
}



#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.functionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sectionArray = self.functionArray[section];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    
    NSArray *sectionArray = self.functionArray[indexPath.section];
    NSString *title = sectionArray[indexPath.row];
    [cell setMeCollectionViewCellWithImageName:title title:title];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

//设置顶部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
  
    return CGSizeMake(kScreenWidth, 10);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID forIndexPath:indexPath];
        
    }
    return reusableview;
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (_isBusiness) {//商家
        if (section == 0) {
            switch (row) {
                case 0: {//积分兑换
                    [IntegralExchangeViewController showIntegralExchangeViewController:self];
                }
                    break;
                case 1: {//做单
                    [SettingOrderViewController showSettingOrderViewController:self];
                }
                    break;
                case 2: {//结算
                    [SettleAccountsViewController showSettleAccountsViewController:self];
                }
                    break;
                case 3: {//充值
                    [RechargeViewController showRechargeViewController:self];
                }
                    break;
                default:
                    break;
            }

        }else if (section == 1) {
            switch (row) {
                case 0: {//店铺设置
                    [StoreSettingViewController showStoreSettingViewController:self];
                }
                    break;
                case 1: {//订单管理
                    [OrderManageViewController showOrderManageViewController:self];
                }
                    break;
                case 2: {//商家会员
                    [BusinessMemberViewController showBusinessMemberViewController:self];
                }
                    break;
                case 3:{
                    //购物订单
                    [ShoppingOrderViewController showShoppingOrderViewController:self];
                }
                    break;
                case 4:{
                    //代购
                    [HotboomViewController showHotboomViewController:self];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
    }else {//普通用户
        switch (row) {
            case 0:{
                //购物订单
                [OrderManageViewController showOrderManageViewController:self];
            }
                break;
            case 1:{
                //代购
                [HotboomViewController showHotboomViewController:self];
            }
                break;
                
            default:
                break;
        }
    }
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark - PersonalTopView delegate
- (void)personalTopViewClickButtonWithType:(PersonalTopViewType)type {
    switch (type) {
        case PersonalTopViewIconType: {
            NSLog(@"点击了头像/名字按钮");
            AccountsSettingViewController *accountsSettingVC = [[AccountsSettingViewController alloc]init];
            [self.navigationController pushViewController:accountsSettingVC animated:YES];
        }
            break;
            
        case PersonalTopViewGradeType: {
            NSLog(@"点击了用户等级按钮");
        }
            break;
            
        case PersonalTopViewEmpiricalType: {
            NSLog(@"点击了积分按钮");
        }
            break;
            
        case PersonalTopViewSettingType: {
            NSLog(@"点击了设置按钮");
            SettingViewController *settingVC = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:settingVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ExpendBusinessView delegate
/**
 *  点击量ExpendBusinessView的内部按钮
 */
- (void)clickExpendBusinessViewButtonWithType:(ExpendBusinessViewType)type {
    switch (type) {
        case ExpendBusinessViewPresentIntegralType: {//赠送积分
            NSLog(@"赠送积分");
            PresentIntegralViewController *presentIntegralVC = [[PresentIntegralViewController alloc]init];
            [self.navigationController pushViewController:presentIntegralVC animated:YES];
        }
            break;
        case ExpendBusinessViewExpendProfitsType: {//消费让利
            NSLog(@"消费让利");
            ExpendProfitsViewController *expendProfitsVC = [[ExpendProfitsViewController alloc]init];
            [self.navigationController pushViewController:expendProfitsVC animated:YES];
        }
            break;
        case ExpendBusinessViewMerchantProfitsType: {//商家让利
            NSLog(@"商家让利");
            MerchantProfitsViewController *merchantProfitsVC = [[MerchantProfitsViewController alloc]init];
            [self.navigationController pushViewController:merchantProfitsVC animated:YES];
        }
            break;
        case ExpendBusinessViewBusinessPaymentType: {//商家货款
            NSLog(@"商家货款");
            BusinessPaymentViewController *businessPaymentVC = [[BusinessPaymentViewController alloc]init];
            [self.navigationController pushViewController:businessPaymentVC animated:YES];
        }
            break;
        case ExpendBusinessViewRefundableMoneyType: {//保证金
            NSLog(@"保证金");
            RefundableMoneyViewController *refundableMoneyVC = [[RefundableMoneyViewController alloc]init];
            [self.navigationController pushViewController:refundableMoneyVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ExpendPersonalView delegate
/**
 *  点击量ExpendPersonalView的内部按钮
 */
- (void)clickExpendPersonalViewButtonWithType:(ExpendPersonalViewType)type {
    switch (type) {
        case ExpendPersonalViewPresentIntegralType: {//赠送积分
            NSLog(@"赠送积分");
            ReceiveListViewController *receiveListVC = [[ReceiveListViewController alloc]init];
            [self.navigationController pushViewController:receiveListVC animated:YES];
        }
            break;
        case ExpendPersonalViewExpendProfitsType: {//消费让利
            NSLog(@"消费让利");
            ExpendProfitsViewController *expendProfitsVC = [[ExpendProfitsViewController alloc]init];
            [self.navigationController pushViewController:expendProfitsVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}


- (PersonalTopView *)personalTopView {
    if (!_personalTopView) {
        _personalTopView = [[PersonalTopView alloc]init];
        [self.scrollView addSubview:_personalTopView];
        
        [_personalTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-20);
            make.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth * 110 / 320));
        }];
        _personalTopView.delegate = self;
    }
    return _personalTopView;
}

- (ExpendPersonalView *)expendPersonalView {
    if (!_expendPersonalView) {
        _expendPersonalView = [[ExpendPersonalView alloc]init];
        [self.scrollView addSubview:_expendPersonalView];
        __weak typeof(self) weakSelf = self;
        [_expendPersonalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.personalTopView.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        _expendPersonalView.delegate = self;
    }
    return _expendPersonalView;
}

- (ExpendBusinessView *)expendBusinessView {
    if (!_expendBusinessView) {
        _expendBusinessView = [[ExpendBusinessView alloc]init];
        [self.scrollView addSubview:_expendBusinessView];
        __weak typeof(self) weakSelf = self;
        [_expendBusinessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.personalTopView.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        _expendBusinessView.delegate = self;
    }
    return _expendBusinessView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = (kScreenWidth - edgeDistance * 5) * 0.25;
        flowLayout.itemSize = CGSizeMake(itemWidth, collectionViewW);
        flowLayout.sectionInset = UIEdgeInsetsMake(edgeDistance, edgeDistance, edgeDistance, edgeDistance);
        flowLayout.minimumLineSpacing = edgeDistance;
        flowLayout.minimumInteritemSpacing = edgeDistance;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.scrollView addSubview:_collectionView];
        
        UIView *collectionTopView;
        if (_isBusiness) {
            collectionTopView = self.expendBusinessView;
        }else {
            collectionTopView = self.expendPersonalView;
        }
       
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(collectionTopView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(330);
            make.bottom.mas_equalTo(0);
        }];
        
        //注册cell
        [_collectionView registerClass:[MeCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID];
        
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

@end
