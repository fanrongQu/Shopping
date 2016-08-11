//
//  StoreSettingCell.m
//  Haidao
//
//  Created by 1860 on 16/8/9.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "StoreSettingCell.h"

@implementation StoreSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"StoreSettingCell";
    StoreSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[StoreSettingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(200);
        }];
        _titleLabel.font = kFontSize(14);
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_iconImageView);
        }];
    }
    return _iconImageView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(200);
            make.centerY.mas_equalTo(0);
        }];
        _detailLabel.font = kFontSize(14);
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_describeLabel];
        __weak typeof(self) weakSelf = self;
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-12);
        }];
        _describeLabel.font = kFontSize(14);
        _describeLabel.numberOfLines = 0;
    }
    return _describeLabel;
}


@end
