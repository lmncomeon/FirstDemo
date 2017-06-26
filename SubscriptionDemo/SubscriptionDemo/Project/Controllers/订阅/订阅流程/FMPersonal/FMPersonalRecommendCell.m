//
//  FMPersonalRecommendCell.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/26.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "FMPersonalRecommendCell.h"

@interface FMPersonalRecommendCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) SDKCustomLabel *nameLab;
@property (nonatomic, strong) SDKCustomLabel *videoCountLab;
@property (nonatomic, strong) SDKCustomLabel *fansCountLab;

@end

@implementation FMPersonalRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    FMPersonalRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FMPersonalRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat iconWH = adaptX(50);
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(adaptX(34), adaptY(15), iconWH, iconWH)];
        _iconView.backgroundColor = [UIColor redColor];
        _iconView.layer.masksToBounds = true;
        _iconView.layer.cornerRadius = iconWH*0.5;
        [self.contentView addSubview:_iconView];
        
        _nameLab = [SDKCustomLabel setLabelTitle:@"哈哈" setLabelFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) +adaptX(16), adaptY(13), kScreenWidth*0.7, adaptY(20)) setLabelColor:UIColorFromRGB(0x272727) setLabelFont:kFont(14)];
        [self.contentView addSubview:_nameLab];
        
        _videoCountLab = [SDKCustomLabel setLabelTitle:@"100个视频" setLabelFrame:CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_nameLab.frame), kScreenWidth*0.7, adaptY(15)) setLabelColor:UIColorFromRGB(0x8F8F8F) setLabelFont:kFont(11)];
        [self.contentView addSubview:_videoCountLab];
        
        _fansCountLab = [SDKCustomLabel setLabelTitle:@"24万粉丝" setLabelFrame:CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_videoCountLab.frame), kScreenWidth*0.7, adaptY(15)) setLabelColor:UIColorFromRGB(0x8F8F8F) setLabelFont:kFont(11)];
        [self.contentView addSubview:_fansCountLab];
    }
    return self;
}



@end
