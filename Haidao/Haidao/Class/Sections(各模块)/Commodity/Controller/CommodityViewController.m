//
//  CommodityViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/10.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "CommodityViewController.h"
#import "ShoppingCartButton.h"
#import "CommodityImgCollectionViewCell.h"
#import "ShoppingView.h"
#import "InfoView.h"

#import "StoreDetailsViewController.h"
#import "LoginViewController.h"

/** 顶部轮播广告的宽高比 */
static CGFloat const commodityImgCollectionViewWH = 0.55;
/** 顶部轮播广告的最大sections */
static CGFloat const MaxSections = 1;
/**  广告CollectionViewCell标记  */
static NSString * const commodityImgCollectionViewCellID = @"commodityImgCollectionViewCell";

@interface CommodityViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ShoppingViewDelegate,InfoViewDelegate>

/**  分页显示商品展示和图文详情页  */
@property (nonatomic, strong) UIScrollView *scrollView;
/**  商品展示  */
@property (nonatomic, strong) UITableView *infoTableView;
/**  图文详情  */
@property (nonatomic, strong) UIScrollView *detailView;
/**  商品图片浏览  */
@property (nonatomic, strong) UICollectionView *commodityImgCollectionView;
/**  商品图片展示pageControl  */
@property (nonatomic, strong) UIPageControl *pageControl;
/**  商品图片数组  */
@property (nonatomic, strong) NSArray *imgArray;
/**  商品规格信息  */
@property (nonatomic, strong) ShoppingView *shoppingView;
///**  商品名称  */
//@property (nonatomic, strong) UILabel *commodityName;
///**  商品价格  */
//@property (nonatomic, strong) UILabel *commodityPrice;

/**
 *  顶部状态栏透明度
 */
/**  是否是第一次加载页面 */
@property (nonatomic, assign) BOOL isFirstLoad;

/**  进入下一个控制器时导航栏的透明度  */
@property (nonatomic, assign) CGFloat navigationBarAlpha;

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBottomView];
    self.imgArray = @[@"轮播1",@"轮播2",@"轮播3",@"轮播4"];
    [self setinfoTableViewHeaderView];
    [self setInfoView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.shoppingView addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark 点击背景退出键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.shoppingView.shoppingNum.numField resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    
    self.scrollView.delegate = self;
    
    self.detailView.delegate = self;
    
    self.commodityImgCollectionView.delegate = self;
    self.commodityImgCollectionView.dataSource = self;
    
    self.shoppingView.delegate = self;
    
    [self setDragTop];
    [self setDragBottom];
    
    if (!_isFirstLoad) {
        self.navigationController.navigationBar.subviews.firstObject.alpha = 0.0;
        _isFirstLoad = YES;
    }else {//从下一个控制器返回时重设控制器的导航栏透明度
        self.navigationController.navigationBar.subviews.firstObject.alpha = self.navigationBarAlpha;
    }
    
    if (self.navigationBarAlpha != 1) {
        UIImage *image = [UIImage imageNamed:@"隐藏-返回"];
        [self.navigationItem.leftBarButtonItem setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.infoTableView.delegate = nil;
    self.infoTableView.dataSource = nil;
    
    self.scrollView.delegate = nil;
    
    self.detailView.delegate = nil;
    
    self.commodityImgCollectionView.delegate = nil;
    self.commodityImgCollectionView.dataSource = nil;
    
    self.shoppingView.delegate = nil;
    
    //记录当前导航的透明度
    self.navigationBarAlpha = self.navigationController.navigationBar.subviews.firstObject.alpha;
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
}


- (void)dealloc {
    
    if (_scrollView != nil) _scrollView = nil;
    
    if (_infoTableView != nil) _infoTableView = nil;
    
    if (_detailView != nil) _detailView = nil;
    
    if (_commodityImgCollectionView != nil) _commodityImgCollectionView = nil;
        
    if (_pageControl != nil) _pageControl = nil;
    
    if (_shoppingView != nil) _shoppingView = nil;
   
}

#pragma mark - 设置拖拽进入图文详情或商品介绍页面
- (void)setDragTop {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"继续拖拽，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"继续拖拽，查看图文详情" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有图文详情" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    self.infoTableView.mj_footer = footer;
}

- (void)loadMoreData {
    self.infoTableView.scrollEnabled = NO;
    //设置动画效果
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.scrollView.contentOffset = CGPointMake(0, kScreenHeight - 64);
        
    } completion:^(BOOL finished) {
        //结束加载
        [self.infoTableView.mj_footer endRefreshing];
    }];
}

- (void)setDragBottom {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"下拉返回宝贝详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放返回宝贝详情" forState:MJRefreshStatePulling];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:0];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 设置刷新控件
    self.detailView.mj_header = header;
}

- (void)loadNewData {
    
    self.infoTableView.scrollEnabled = YES;
    //下拉执行对应的操作
    //设置动画效果
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        //结束加载
        [self.detailView.mj_header endRefreshing];
    }];
}

#pragma mark - 布局页面

/**
 *  设置底部栏
 */
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    //客服
    ShoppingCartButton *serviceBtn = [[ShoppingCartButton alloc]init];
    [bottomView addSubview:serviceBtn];
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(56);
    }];
    
    serviceBtn.titleLabel.font = kFontSize(12);
    [serviceBtn setTitle:@"收藏" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[serviceBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        LoginViewController *logVC = [[LoginViewController alloc]init];
        [weakSelf.navigationController pushViewController:logVC animated:YES];
    }];
    
    //店铺
    ShoppingCartButton *storeBtn = [[ShoppingCartButton alloc]init];
    [bottomView addSubview:storeBtn];
    [storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(serviceBtn.mas_right);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(serviceBtn);
    }];
    
    storeBtn.titleLabel.font = kFontSize(12);
    [storeBtn setTitle:@"店铺" forState:UIControlStateNormal];
    [storeBtn setImage:[UIImage imageNamed:@"店铺主页"] forState:UIControlStateNormal];
    [storeBtn setImage:[UIImage imageNamed:@"店铺主页"] forState:UIControlStateHighlighted];
    
    //加入购物车
    UIButton *addShoppingCartBtn = [[UIButton alloc]init];
    [bottomView addSubview:addShoppingCartBtn];
    [addShoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storeBtn.mas_right);
        make.top.bottom.mas_equalTo(0);
    }];
    addShoppingCartBtn.backgroundColor = kSubjectColor;
    
    addShoppingCartBtn.titleLabel.font = kFontSize(14);
    [addShoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShoppingCartBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [[addShoppingCartBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"加入购物车按钮被点击");
        [self showShoppingView];
    }];
    
    //立即购买
    UIButton *immediateBuyBtn = [[UIButton alloc]init];
    [bottomView addSubview:immediateBuyBtn];
    [immediateBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addShoppingCartBtn.mas_right);
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(addShoppingCartBtn);
    }];
    immediateBuyBtn.backgroundColor = [UIColor redColor];
    
    immediateBuyBtn.titleLabel.font = kFontSize(14);
    [immediateBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [immediateBuyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}


/**
 *  设置商品展示页面
 */
- (void)setinfoTableViewHeaderView {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [headerView addSubview:self.commodityImgCollectionView];
    [_commodityImgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenWidth * commodityImgCollectionViewWH);
    }];
    
    [headerView insertSubview:self.pageControl aboveSubview:_commodityImgCollectionView];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_commodityImgCollectionView).offset(-2);
        make.right.mas_equalTo(_commodityImgCollectionView).offset(-15);
    }];
    
    self.infoTableView.tableHeaderView = headerView;
}

/**
 *  设置商品展示页底部商家信息
 */
- (void)setInfoView {
    InfoView *footerView = [[InfoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
    
    footerView.delegate = self;
    self.infoTableView.tableFooterView = footerView;
}

/**
 *  展示商品规格信息视图
 */
- (void)showShoppingView {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        weakSelf.shoppingView.backgroundColor = kUIColor_RGB(100, 100, 100, 0.6);
        [weakSelf.shoppingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
        }];
        [weakSelf.shoppingView layoutIfNeeded];//masonry动画必须实现layoutIfNeeded
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _commodityImgCollectionView) {
        return MaxSections;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _commodityImgCollectionView) {
        return self.imgArray.count;
    }
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _commodityImgCollectionView) {
        CommodityImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commodityImgCollectionViewCellID forIndexPath:indexPath];
        
        NSString *title = [NSString stringWithFormat:@"%@--%@",self.title,_imgArray[indexPath.row]];
//        [cell setADImage:nil ADtitle:title];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }else {
       
        return nil;
    }
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
//    CommodityViewController *commodityVC = [[CommodityViewController alloc]init];
//    [self.navigationController pushViewController:commodityVC animated:YES];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.infoTableView) {
        CGFloat scrollY = scrollView.contentOffset.y;
        // 导航栏渐变
        if (scrollY > kScreenWidth * commodityImgCollectionViewWH - 64) {
            self.title = @"商品详情";
            
            self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
            
            [self.navigationItem.leftBarButtonItem setImage: [UIImage imageNamed:@"navigationbar_back"]];
        }else {
            self.title = nil;
            
            CGFloat alpha = scrollY / (kScreenWidth * commodityImgCollectionViewWH - 64);
            self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
            //去除图片的渲染效果
            UIImage *image = [UIImage imageNamed:@"隐藏-返回"];
            [self.navigationItem.leftBarButtonItem setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        
    }else if (scrollView == self.commodityImgCollectionView) {//设置页码
        int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.imgArray.count;
        self.pageControl.currentPage = page;
    }
}


#pragma mark - shoppingView delegate
/**
 *  选择的商品参数
 */
- (void)selectSize:(NSString *)size color:(NSString *)color number:(NSString *)number {
    NSLog_func();
    NSLog(@"size:%@  color:%@   number:%@",size,color,number);
}

#pragma mark - InfoView delegate
/**
 *  点击量InfoView的内部按钮
 *
 *  @param type 按钮的类型
 */
- (void)clickInfoViewButtonWithType:(InfoViewButtonType)type {
    switch (type) {
            
        case InfoViewButtonAttentionType://点击了关注按钮
            NSLog(@"点击了关注按钮");
            
            break;
        case InfoViewButtonStoreHomeType://点击了店铺首页按钮
            NSLog(@"点击了店铺首页按钮");
            [StoreDetailsViewController showStoreDetailsViewController:self];
            break;
        case InfoViewButtonHotsCommodityType://点击了热销商品按钮
            NSLog(@"点击了热销商品按钮");
            
            break;
        case InfoViewButtonAllCommodityType://点击了全部商品按钮
            NSLog(@"点击了全部商品按钮");
            
            break;
        case InfoViewButtonNewsCommodityType://点击了最新上架商品按钮
            NSLog(@"点击了最新上架商品按钮");
            
            break;
        case InfoViewButtonServiceType://点击量联系客服按钮
            NSLog(@"点击量联系客服按钮");
            
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
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-49);
        }];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UITableView *)infoTableView {
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]init];
        [self.scrollView addSubview:_infoTableView];
        [_infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - 49));
        }];
        _infoTableView.backgroundColor = [UIColor greenColor];
    }
    return _infoTableView;
}

- (UIScrollView *)detailView {
    if (!_detailView) {
        _detailView = [[UIScrollView alloc]init];
        [self.scrollView addSubview:_detailView];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kScreenHeight);
            make.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - 49 - 64));
        }];
    }
    _detailView.backgroundColor = [UIColor whiteColor];
    return _detailView;
}

- (UICollectionView *)commodityImgCollectionView {
    if (!_commodityImgCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * commodityImgCollectionViewWH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _commodityImgCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _commodityImgCollectionView.pagingEnabled = YES;
        _commodityImgCollectionView.showsHorizontalScrollIndicator = NO;
        _commodityImgCollectionView.bounces = NO;
        _commodityImgCollectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_commodityImgCollectionView registerClass:[CommodityImgCollectionViewCell class] forCellWithReuseIdentifier:commodityImgCollectionViewCellID];
    }
    return _commodityImgCollectionView;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = self.imgArray.count;
    }
    return _pageControl;
}

- (ShoppingView *)shoppingView {
    if (!_shoppingView) {
        _shoppingView = [[ShoppingView alloc]init];
        [self.view addSubview:_shoppingView];
        __weak typeof(self) weakSelf = self;
        [_shoppingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.view.mas_bottom).priorityMedium();
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(kScreenHeight);
        }];
        [_shoppingView.superview layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
    }
    return _shoppingView;
}

@end
