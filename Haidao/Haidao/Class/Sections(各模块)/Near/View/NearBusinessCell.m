//
//  NearBusinessCell.m
//  Haidao
//
//  Created by 1860 on 16/8/11.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "NearBusinessCell.h"

@interface NearBusinessCell ()

@property (nonatomic, strong) UIImageView *imageV;//图片

@property (nonatomic, strong) UILabel *name;//名称

@property (nonatomic, strong) UILabel *address;//地址

@property (nonatomic, strong) UILabel *distance;//距离

@property (nonatomic, strong) UILabel *browseNumber;//浏览量


@end


@implementation NearBusinessCell

+ (NearBusinessCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"NearBusinessCell";
    NearBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NearBusinessCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setNearBusinessCellImage:nil name:@"美味西餐厅" distance:@"2.0" address:@"河南省南阳市卧龙区工业南路河南省南阳市卧龙区工业南路" browseNumber:@"10000"];
    }
    return self;
}

- (void)setNearBusinessCellImage:(NSString *)imageName name:(NSString *)name distance:(NSString *)distance address:(NSString *)address browseNumber:(NSString *)browseNumber {
   
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageName]];
    self.name.text = name;
    self.distance.text = [NSString stringWithFormat:@"%@km",distance];
    self.address.text = address;
    self.browseNumber.text = [NSString stringWithFormat:@"浏览量：%@",browseNumber];
}


#pragma mark - 控件懒加载
- (UIImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(110, 78));
        }];
        _imageV.backgroundColor = [UIColor purpleColor];
    }
    return _imageV;
}

- (UILabel *)name {
    if (_name == nil) {
        _name = [[UILabel alloc]init];
        [self.contentView addSubview:_name];
        __weak typeof(self) weakSelf = self;
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.imageV);
            make.left.mas_equalTo(weakSelf.imageV.mas_right).with.offset(10);
            make.right.mas_equalTo(-70);
        }];
        _name.font = kFontSize(16);
    }
    return _name;
}

- (UILabel *)distance {
    if (_distance == nil) {
        _distance = [[UILabel alloc]init];
        [self.contentView addSubview:_distance];
        __weak typeof(self) weakSelf = self;
        [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.imageV);
            make.right.mas_equalTo(-15);
        }];
        _distance.font = kFontSize(12);
        _distance.textColor = kGrayColor;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_distance.mas_left).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(8, 12));
            make.centerY.mas_equalTo(_distance);
        }];
        [imageView setImage:[UIImage imageNamed:@"当前城市"]];
    }
    return _distance;
}

- (UILabel *)address {
    if (_address == nil) {
        _address = [[UILabel alloc]init];
        [self.contentView addSubview:_address];
        __weak typeof(self) weakSelf = self;
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.name.mas_bottom).with.offset(5);
            make.left.mas_equalTo(weakSelf.name);
            make.right.mas_equalTo(-15);
        }];
        _address.font = kFontSize(12);
        _address.numberOfLines = 2;
        _address.textColor = kGrayColor;
    }
    return _address;
}

- (UILabel *)browseNumber {
    if (_browseNumber == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        __weak typeof(self) weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.name);
            make.bottom.mas_equalTo(-13);
            make.size.mas_equalTo(CGSizeMake(15, 9));
        }];
        
        [imageView setImage:[UIImage imageNamed:@"浏览量"]];
        _browseNumber = [[UILabel alloc]init];
        [self.contentView addSubview:_browseNumber];
        [_browseNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).with.offset(2);
            make.centerY.mas_equalTo(imageView.mas_centerY);
        }];
        _browseNumber.font = kFontSize(12);
        _browseNumber.textColor = kGrayColor;
    }
    return _browseNumber;
}

@end

