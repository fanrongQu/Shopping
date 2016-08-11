//
//  ClassifyViewController.m
//  Haidao
//
//  Created by 1860 on 16/7/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassifyCollectionViewCell.h"

/**   classifyCollectionViewCell的标识 */
static NSString * const classifyCollectionViewCellID = @"classifyCollectionViewCellID";
/**  列表视图的collectionReusableView标示符  */
static NSString * const collectionReusableViewHeaderID = @"classifyCollectionReusableViewHeaderID";

/**  collectionView顶部广告  */
static CGFloat const collectionHeaderADWH = 0.33;


@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/**  分类列表TableView  */
@property (nonatomic, strong) UITableView *classifyTableView;
/**  选中的cell  */
@property (nonatomic, weak) UITableViewCell *deselectCell;
/**  分类单元格CollectionView  */
@property (nonatomic, strong) UICollectionView *classifyCollectionView;

/**  一级分类  */
@property (nonatomic, strong) NSArray *firstClassify;
/**  第一次加载  */
@property (nonatomic, assign) BOOL isFirstLoad;

@end

@implementation ClassifyViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  cell的分割线从头开始
    if ([self.classifyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.classifyTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.classifyTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.classifyTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.classifyCollectionView.delegate = self;
    self.classifyCollectionView.dataSource = self;
    
    if (!_isFirstLoad) {
        
        //默认选中第一行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.classifyTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.classifyTableView didSelectRowAtIndexPath:indexPath];
        _isFirstLoad = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.classifyCollectionView.delegate = nil;
    self.classifyCollectionView.dataSource = nil;
}

- (void)dealloc {
    if (_classifyTableView != nil) _classifyTableView = nil;
    
    if (_classifyCollectionView != nil) _classifyCollectionView = nil;
    
    if (_firstClassify != nil) _firstClassify = nil;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.firstClassify.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"classifyTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.textLabel.font = kFontSize(14);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.contentView.backgroundColor = kUIColor_RGB(235, 240, 244, 1);
        cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    }
    cell.textLabel.text = self.firstClassify[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
/**
 *  cell的分割线从头开始
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.deselectCell != nil) {
        self.deselectCell.contentView.backgroundColor = kUIColor_RGB(235, 240, 244, 1);
        self.deselectCell.textLabel.textColor = [UIColor blackColor];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = kSubjectColor;
    self.deselectCell = cell;
}


#pragma mark - 配置UICollectionView的header和footer视图
//设置顶部的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth - 90, (kScreenWidth - 110) * collectionHeaderADWH + 34);
    }
    return CGSizeMake(kScreenWidth - 90, 18);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            
            UIButton *ADImageButton = [[UIButton alloc]init];
            [reusableview addSubview:ADImageButton];
            [ADImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.bottom.mas_equalTo(-24);
            }];
            ADImageButton.backgroundColor = [UIColor redColor];
        }
        UILabel *headerLabel = [[UILabel alloc]init];
        [reusableview addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
        headerLabel.text = @"常用分类";
        headerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        
    }
    return reusableview;
}

#pragma mark - collectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    ClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classifyCollectionViewCellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog_func();
    
}

#pragma mark - 懒加载
- (UITableView *)classifyTableView {
    if (!_classifyTableView) {
        _classifyTableView = [[UITableView alloc]init];
        [self.view addSubview:_classifyTableView];
        [_classifyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(90);
        }];
        UIView *tableFooterView = [UIView new];
        _classifyTableView.tableFooterView = tableFooterView;
        _classifyTableView.rowHeight = 55;
        
        _classifyTableView.delegate = self;
        _classifyTableView.dataSource = self;
    }
    return _classifyTableView;
}


- (UICollectionView *)classifyCollectionView {
    if (!_classifyCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = (kScreenWidth - 110) / 3;
        flowLayout.itemSize = CGSizeMake(itemWidth, 44);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _classifyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _classifyCollectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_classifyCollectionView];
        __weak typeof(self) weakSelf = self;
        [_classifyCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(weakSelf.classifyTableView.mas_right);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-49);
        }];
        
        //注册cell
        [_classifyCollectionView registerClass:[ClassifyCollectionViewCell class] forCellWithReuseIdentifier:classifyCollectionViewCellID];
        
        [_classifyCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionReusableViewHeaderID];
    } 
    return _classifyCollectionView;
}


- (NSArray *)firstClassify {
    if (!_firstClassify) {
        _firstClassify = @[@"推荐分类",@"精品女鞋",@"潮流女装",@"推荐分类",@"精品女鞋",@"潮流女装",@"推荐分类",@"精品女鞋",@"潮流女装",@"推荐分类",@"精品女鞋",@"潮流女装"];
    }
    return _firstClassify;
}

@end
