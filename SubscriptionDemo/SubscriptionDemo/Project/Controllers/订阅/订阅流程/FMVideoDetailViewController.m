//
//  FMVideoDetailViewController.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/21.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "FMVideoDetailViewController.h"

@interface FMVideoDetailViewController ()

@property (nonatomic, strong) UIView *videoView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *customHeaderView;
@property (nonatomic, strong) SDKCustomLabel *playCountLab;
@property (nonatomic, strong) SDKCustomLabel *timeLab;
@property (nonatomic, strong) SDKCustomLabel *contentLab;

@property (nonatomic, strong) UIView *praiseAndShareView;
@property (nonatomic, strong) UIButton *praiseBtn;


@property (nonatomic, strong) UIView *attentionView;
@property (nonatomic, strong) UIImageView *avatorView;
@property (nonatomic, strong) SDKCustomLabel *attentionNameLab;
@property (nonatomic, strong) SDKCustomLabel *attentionIDLab;
@property (nonatomic, strong) UIButton *attentionBtn;

@end

static NSInteger const kbtnTag = 1000;

@implementation FMVideoDetailViewController

- (UIView *)videoView {
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(211))];
        _videoView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_videoView];
    }
    return _videoView;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.videoView.frame)-adaptY(57)) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.dataSource      = self;
        _mainTableView.delegate  = self;
        _mainTableView.tableHeaderView = self.customHeaderView;
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}

- (UIView *)customHeaderView {
    if (!_customHeaderView) {
        _customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        _playCountLab = [SDKCustomLabel setLabelTitle:@"120次播放" setLabelFrame:CGRectMake(adaptX(15), adaptY(8), kScreenWidth*0.5, adaptY(14)) setLabelColor:UIColorFromRGB(0x666666) setLabelFont:kFont(10)];
        [_customHeaderView addSubview:_playCountLab];
        
        _timeLab = [SDKCustomLabel setLabelTitle:@"12小时前" setLabelFrame:CGRectMake(kScreenWidth*0.5-adaptX(15), adaptY(8), kScreenWidth*0.5, adaptY(14)) setLabelColor:UIColorFromRGB(0x666666)  setLabelFont:kFont(10)];
        _timeLab.textAlignment = 2;
        [_customHeaderView addSubview:_timeLab];
        
        _contentLab = [SDKCustomLabel setLabelTitle:@"" setLabelFrame:CGRectMake(adaptX(15), CGRectGetMaxY(_playCountLab.frame) + adaptY(7), kScreenWidth-2*adaptX(15), 0) setLabelColor:UIColorFromRGB(0x72727) setLabelFont:kFont(14)];
        _contentLab.numberOfLines = 0;
        [_customHeaderView addSubview:_contentLab];
        
        [_customHeaderView addSubview:self.praiseAndShareView];
        _praiseAndShareView.y = CGRectGetMaxY(_contentLab.frame);
        
        
        [_customHeaderView addSubview:self.attentionView];
        _attentionView.y = CGRectGetMaxY(_praiseAndShareView.frame);
        
        _customHeaderView.height = CGRectGetMaxY(_customHeaderView.subviews.lastObject.frame);
        
    }
    return _customHeaderView;
}

- (UIView *)praiseAndShareView {
    if (!_praiseAndShareView) {
        _praiseAndShareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(41))];
        
        CGFloat btnW = kScreenWidth*0.5;
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*btnW, 0, btnW, _praiseAndShareView.height);
//            [btn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
            btn.titleLabel.font = kFont(14);
            [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            btn.tag = kbtnTag + i; // tag
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_praiseAndShareView addSubview:btn];
            
            if (i == 0) {
                _praiseBtn = btn;
            } else {
                [btn setTitle:@"分享" forState:UIControlStateNormal];
            }
        }
        
    }
    return _praiseAndShareView;
}

- (UIView *)attentionView {
    if (!_attentionView) {
        _attentionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, adaptY(58))];
        _attentionView.backgroundColor = [UIColor whiteColor];
        
        UIView *line0 = [self createCuttingLineWithY:0];
        UIView *line1 = [self createCuttingLineWithY:_attentionView.height-0.5f];
        
        [_attentionView addSubview:line0];
        [_attentionView addSubview:line1];
        
        // start
        CGFloat avatorWH = adaptX(38);
        _avatorView = [[UIImageView alloc] initWithFrame:CGRectMake(adaptX(15), (_attentionView.height-avatorWH)*0.5, avatorWH, avatorWH)];
        _avatorView.backgroundColor = [UIColor yellowColor];
        [_attentionView addSubview:_avatorView];
        
        _attentionNameLab = [SDKCustomLabel setLabelTitle:@"" setLabelFrame:CGRectMake(CGRectGetMaxX(_avatorView.frame) + adaptX(15), adaptY(13), kScreenWidth, adaptY(17.5)) setLabelColor:UIColorFromRGB(0x3C3C3C) setLabelFont:kFont(12)];
        [_attentionView addSubview:_attentionNameLab];
        
        _attentionIDLab = [SDKCustomLabel setLabelTitle:@"" setLabelFrame:CGRectMake(CGRectGetMaxX(_avatorView.frame) + adaptX(15), CGRectGetMaxX(_attentionNameLab.frame), kScreenWidth, adaptY(12.5)) setLabelColor:UIColorFromRGB(0x3C3C3C) setLabelFont:kFont(9)];
        [_attentionView addSubview:_attentionIDLab];
        
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionBtn.frame = CGRectMake(_attentionView.width-adaptX(63)-adaptX(15), (_attentionView.height-adaptY(22))*0.5, adaptX(63), adaptY(22));
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentionBtn_orange"] forState:UIControlStateNormal];
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentionBtn_gray"] forState:UIControlStateSelected];
        [_attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_attentionView addSubview:_attentionBtn];
        
    }
    return _attentionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self mainTableView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *str = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        _contentLab.text = str;
        _contentLab.height =  [SDKAboutText calculateTextHeight:str maxWidth:_contentLab.width font:_contentLab.font];
        [self reloadFrame];
        
        [_praiseBtn setTitle:@"999" forState:UIControlStateNormal];
        
        _attentionNameLab.text = @"拯救世界";
        _attentionIDLab.text = @"1234";
        
        
    });
    
    
    
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == kbtnTag) { // 点赞
        
    } else if (sender.tag == kbtnTag+1) { // 分享
    
    }
}

// 关注
- (void)attentionAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ww"];
    
    cell.textLabel.text = @"ss";
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return adaptY(45);
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return adaptY(45);
}

#pragma mark - other method
- (void)reloadFrame {
    _praiseAndShareView.y = CGRectGetMaxY(_contentLab.frame);
    _attentionView.y = CGRectGetMaxY(_praiseAndShareView.frame);
    
    _customHeaderView.height = CGRectGetMaxY(_customHeaderView.subviews.lastObject.frame);
}

- (UIView *)createCuttingLineWithY:(CGFloat)Y {
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, Y, kScreenWidth, 0.5f)];
    grayLine.backgroundColor = cuttingLineColor;
    
    return grayLine;
}

@end
