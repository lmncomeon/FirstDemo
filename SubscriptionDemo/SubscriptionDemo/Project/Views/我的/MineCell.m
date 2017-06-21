//
//  MineCell.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/21.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MineCell.h"
#import "MineModel.h"


@interface MineCell ()

@property (nonatomic, strong) UIImageView *avatorView;
@property (nonatomic, strong) SDKCustomLabel *textLab;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) MineModel *dataModel;

@end

static NSInteger const maxLength = 20;

@implementation MineCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat avatorWH = adaptX(100);
        _avatorView = [[UIImageView alloc] initWithFrame:CGRectMake(adaptX(10), adaptX(10), avatorWH, avatorWH)];
        _avatorView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_avatorView];
        
        _textLab = [SDKCustomLabel setLabelTitle:@"" setLabelFrame:CGRectMake(CGRectGetMaxX(_avatorView.frame)+adaptX(5), adaptX(10), kScreenWidth-CGRectGetMaxX(_avatorView.frame)-adaptX(15), 0) setLabelColor:[UIColor blackColor] setLabelFont:kFont(12)];
        _textLab.numberOfLines = 0;
        [self.contentView addSubview:_textLab];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kScreenWidth-adaptX(110), CGRectGetMaxY(_textLab.frame), adaptX(100), adaptY(20));
        [_btn setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        [_btn setTitle:@"展开" forState:UIControlStateNormal];
        _btn.titleLabel.font = kFont(10);
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];

    }
    return self;
}

- (void)configCellWithModel:(MineModel *)dataModel {
    self.dataModel = dataModel;
    
    if (dataModel.cellFlag == 0) {
        [self handleTextNarrowedWithModel:dataModel];

        [_btn setTitle:@"展开" forState:UIControlStateNormal];
    } else {
        [self handleTextspreadWithModel:dataModel];
        
        [_btn setTitle:@"收起" forState:UIControlStateNormal];
    }

    _btn.enabled = dataModel.allowSpread;
    
}

+ (CGFloat)cellHeightWith:(MineModel *)model {
    MineCell *cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell configCellWithModel:model];
    
    [cell layoutIfNeeded];
    
    CGRect frame = cell.btn.frame;
    return frame.origin.y + frame.size.height + adaptY(10);
    
}

- (void)btnAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"展开"])
    {
        [self handleTextspreadWithModel:self.dataModel];
        
        [_btn setTitle:@"收起" forState:UIControlStateNormal];
        
        self.dataModel.cellFlag = 1;
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"收起"])
    {
        
        [self handleTextNarrowedWithModel:self.dataModel];
        
        [_btn setTitle:@"展开" forState:UIControlStateNormal];
        self.dataModel.cellFlag = 0;
    }
    
    !_refreshHeightBlock ? : _refreshHeightBlock();
}

// 处理文本高度
- (void)handleTextNarrowedWithModel:(MineModel *)model {
    
    NSInteger len = MIN(model.text.length, maxLength);
    NSString *substr = [model.text substringWithRange:NSMakeRange(0, len)];
    NSString *lastStr = (substr.length < maxLength) ? substr : [NSString stringWithFormat:@"%@......", substr];
    
    _textLab.text = lastStr;
    _textLab.height =  [SDKAboutText calculateTextHeight:lastStr maxWidth:_textLab.width font:_textLab.font];
    
    _btn.y = MAX(CGRectGetMaxY(_textLab.frame) + adaptY(10), CGRectGetMaxY(_avatorView.frame)-adaptY(20));
}

- (void)handleTextspreadWithModel:(MineModel *)model {
    _textLab.text = model.text;
    _textLab.height =  [SDKAboutText calculateTextHeight:model.text maxWidth:_textLab.width font:_textLab.font];
    
    _btn.y = MAX(CGRectGetMaxY(_textLab.frame) + adaptY(10), CGRectGetMaxY(_avatorView.frame)-adaptY(20));
}

@end
