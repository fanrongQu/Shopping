//
//  NearViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NearViewController.h"
#import "NearBusinessCell.h"
#import "NearBusinessViewController.h"
#import "BusinessTypeviewCell.h"
#import "BusinessTypeButton.h"
#import "NearListViewController.h"

/** 顶部商家分类的宽高比 */
static CGFloat const NearBusinessTypeCollectionViewWH = 0.55;
/**  商家分类CollectionViewCell标记  */
static NSString * const BusinessTypeviewCellID = @"BusinessTypeviewCell";

@interface NearViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

/**  商家列表  */
@property (nonatomic, strong) UITableView *tableview;
/**  商家列表数据  */
@property (nonatomic, strong) NSMutableArray *nearBusinessArray;

/**  商家分类  */
@property (nonatomic, strong) UICollectionView *nearBusinessTypeCollectionView;
/**  商家分类pageControl  */
@property (nonatomic, strong) UIPageControl *pageControl;
/**  商家分类数组  */
@property (nonatomic, strong) NSArray *typeArray;
/**  商家分类页数  */
@property (nonatomic, assign) NSInteger typePages;


@end

@implementation NearViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nearBusinessArray addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@""]];
    
    [self setTableHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.nearBusinessTypeCollectionView.delegate = self;
    self.nearBusinessTypeCollectionView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tableview.delegate = nil;
    self.tableview.dataSource = nil;
    
    self.nearBusinessTypeCollectionView.delegate = nil;
    self.nearBusinessTypeCollectionView.dataSource = nil;
}

- (void)dealloc {
    
    if (_tableview != nil) _tableview = nil;
    
    if (_nearBusinessTypeCollectionView != nil) _nearBusinessTypeCollectionView = nil;
    
    if (_pageControl != nil) _pageControl = nil;
    
    if (_nearBusinessArray != nil) _nearBusinessArray = nil;
    
    if (_typeArray != nil) _typeArray = nil;

}

/**
 *  设置商品展示页面
 */
- (void)setTableHeaderView {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * NearBusinessTypeCollectionViewWH)];
    [headerView addSubview:self.nearBusinessTypeCollectionView];
    [_nearBusinessTypeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth * NearBusinessTypeCollectionViewWH);
    }];
    
    [headerView insertSubview:self.pageControl aboveSubview:_nearBusinessTypeCollectionView];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_nearBusinessTypeCollectionView).offset(-2);
        make.centerX.mas_equalTo(0);
    }];
    
    self.tableview.tableHeaderView = headerView;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearBusinessArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearBusinessCell *cell = [NearBusinessCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearBusinessViewController *nearBusinessVC =[[NearBusinessViewController alloc]init];

    [self.navigationController pushViewController:nearBusinessVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.typePages;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
   
    BusinessTypeviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BusinessTypeviewCellID forIndexPath:indexPath];
    NSLog(@"%lu",(unsigned long)cell.contentView.subviews.count);
    
    // 移除之前的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSLog(@"%lu",(unsigned long)cell.contentView.subviews.count);
    NSInteger typeNumber;
    NSInteger maxPages = self.typePages - 1;
    if (row == maxPages) {
        typeNumber = self.typeArray.count - row * 10;
    }else {
        typeNumber = 10;
    }
    
    CGFloat btnW = 42;
    CGFloat btnH = btnW + 20;
    int list = 5;//列
    CGFloat margin = 20;//按钮周边的边距
    CGFloat rankMargin = (kScreenWidth - btnW * list - margin * 2) / 4;
    CGFloat rowledge = 20;//两行之间的间距
    for (int i = 0 ; i < typeNumber; i++) {
        CGFloat x = margin + i % list * (rankMargin + btnW);
        CGFloat y = margin + i / list *(rowledge + btnH);
        BusinessTypeButton *businessTypeBtn = [[BusinessTypeButton alloc]initWithFrame:CGRectMake(x, y, btnW, btnH)];
        
        NSString *title = self.typeArray[row * 10 + i];
        [businessTypeBtn setTitle:title forState:UIControlStateNormal];
        businessTypeBtn.backgroundColor = [UIColor yellowColor];
        NSString *urlString ;
        [businessTypeBtn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
        
        [businessTypeBtn addTarget:self action:@selector(businessTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:businessTypeBtn];
    }

    return cell;
}

/**
 *  分类按钮点击
 */
- (void)businessTypeBtnAction:(BusinessTypeButton *)button {
    NSLog(@"%@",button.titleLabel.text);
    
    NearListViewController *nearListVC = [[NearListViewController alloc]init];
    [self.navigationController pushViewController:nearListVC animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.nearBusinessTypeCollectionView) {//设置页码
        int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.typeArray.count;
        self.pageControl.currentPage = page;
    }
}



#pragma mark - 懒加载
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

- (UICollectionView *)nearBusinessTypeCollectionView {
    if (!_nearBusinessTypeCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * NearBusinessTypeCollectionViewWH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _nearBusinessTypeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _nearBusinessTypeCollectionView.pagingEnabled = YES;
        _nearBusinessTypeCollectionView.showsHorizontalScrollIndicator = NO;
        _nearBusinessTypeCollectionView.bounces = NO;
        _nearBusinessTypeCollectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_nearBusinessTypeCollectionView registerClass:[BusinessTypeviewCell class] forCellWithReuseIdentifier:BusinessTypeviewCellID];
    }
    return _nearBusinessTypeCollectionView;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = kSubjectColor;
        _pageControl.enabled = NO;
    }
    return _pageControl;
}

- (NSMutableArray *)nearBusinessArray {
    if (!_nearBusinessArray) {
        _nearBusinessArray = [NSMutableArray array];
    }
    return _nearBusinessArray;
}

- (NSArray *) typeArray{
    if (!_typeArray) {
        
        _typeArray = @[@"餐饮",@"酒店",@"旅游",@"娱乐",@"购物",@"服务",@"健身",@"汽车",@"母婴",@"家装",@"鲜花",@"酒店",@"旅游",@"娱乐",@"购物",@"服务",@"健身",@"汽车",@"母婴",@"家装",@"鲜花"];;
    }
    return _typeArray;
}

- (NSInteger)typePages {
    
    NSInteger count = self.typeArray.count;
    //余数
    NSInteger remainder = count % 10;
    //商
    NSInteger quotients = count / 10;
    
    if (remainder > 0) quotients += 1;
    self.pageControl.numberOfPages = quotients;
    return quotients;
}

@end
