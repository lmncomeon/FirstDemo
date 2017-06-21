//
//  SubscriptionOptionsCell.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/20.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "SubscriptionOptionsCell.h"
#import "SubscriptionOptionsModel.h"

@interface SubscriptionOptionsCell ()

@property (nonatomic, strong) UIImageView *circleView;

@end

@implementation SubscriptionOptionsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    SubscriptionOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SubscriptionOptionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat circleWH = adaptX(22);
        DLog(@"===%@", NSStringFromCGRect(self.frame));
        
        _circleView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-circleWH-kDefaultPadding, (adaptY(100)-circleWH)*0.5, circleWH, circleWH)];
        _circleView.image = [UIImage imageNamed:@"coupon_no"];
        [self.contentView addSubview:_circleView];
    }
    return self;
}

- (void)setModel:(SubscriptionOptionsModel *)model {
    _model = model;
    
    _circleView.image = model.isNike ? [UIImage imageNamed:@"coupon_yes"] : [UIImage imageNamed:@"coupon_no"];
}

@end
