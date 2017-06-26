//
//  FMPersonalIntroViewController.m
//  FENGZHONG
//
//  Created by 范明 on 17/6/25.
//  Copyright © 2017年 2or3m. All rights reserved.
//

#import "FMPersonalIntroViewController.h"

@interface FMPersonalIntroViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) SDKCustomLabel *descriptionLab;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) SDKCustomLabel *leftLab;
@property (nonatomic, strong) SDKCustomLabel *fansLab;

@end

@implementation FMPersonalIntroViewController

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _mainScrollView.alwaysBounceVertical=true;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(20))];
        [self.mainScrollView addSubview:_bottomView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(adaptX(13), 0, kScreenWidth-2*adaptX(13), 1)];
        line.backgroundColor = UIColorFromRGB(0xF85959);
        [_bottomView addSubview:line];
        
        _leftLab = [SDKCustomLabel setLabelTitle:@"23456，677888，6777播放" setLabelFrame:CGRectMake(adaptX(30), adaptY(10), kScreenWidth*0.7, adaptY(14)) setLabelColor:UIColorFromRGB(0x8F8F8F) setLabelFont:kFont(10)];
        [_bottomView addSubview:_leftLab];
        
        _fansLab = [SDKCustomLabel setLabelTitle:@"345万粉丝" setLabelFrame:CGRectMake(adaptX(30), CGRectGetMinY(_leftLab.frame), kScreenWidth-2*adaptX(30), adaptY(10)) setLabelColor:UIColorFromRGB(0x8F8F8F) setLabelFont:kFont(10) setAlignment:2];
        [_bottomView addSubview:_fansLab];
        
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
    
    // 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *content = @"低眉轻弹 任我一手琵琶拦千帆奈何皆不是 去来留空船君未还 有婵娟高悬来赠明月衫人间四月芳菲 却开与 何人看低眉轻弹 任我一手琵琶拦千帆奈何皆不是";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:adaptY(8)];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : kFont(13), NSForegroundColorAttributeName : UIColorFromRGB(0x363636), NSKernAttributeName: @(0.38), NSParagraphStyleAttributeName: paragraphStyle}];
      
        
        _descriptionLab.attributedText = attrString;
        
        _descriptionLab.height = [attrString boundingRectWithSize:CGSizeMake(_descriptionLab.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        _bottomView.y = CGRectGetMaxY(_descriptionLab.frame) + adaptY(50);
        
        self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_bottomView.frame));
        
    });
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    
    
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

- (void)setupUI {
    
    SDKCustomLabel *introLab = [SDKCustomLabel setLabelTitle:@"简介" setLabelFrame:CGRectMake(adaptX(33), adaptY(21), kScreenWidth*0.5, adaptY(20)) setLabelColor:UIColorFromRGB(0x545454) setLabelFont:kFontName(@"PingFangSC-Semibold", adaptY(14))];
    [self.mainScrollView addSubview:introLab];
    
    _descriptionLab = [SDKCustomLabel setLabelTitle:@"" setLabelFrame:CGRectMake(adaptX(33), CGRectGetMaxY(introLab.frame) + adaptY(10), kScreenWidth-2*adaptX(33), 0) setLabelColor:UIColorFromRGB(0x363636) setLabelFont:kFont(13)];
    _descriptionLab.numberOfLines = 0;
    [self.mainScrollView addSubview:_descriptionLab];
    
    self.bottomView.y = CGRectGetMaxY(_descriptionLab.frame) + adaptY(25);
}

@end
