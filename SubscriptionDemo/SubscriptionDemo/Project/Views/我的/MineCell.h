//
//  MineCell.h
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/21.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MineModel;

@interface MineCell : BaseTableViewCell

- (void)configCellWithModel:(MineModel *)dataModel;

+ (CGFloat)cellHeightWith:(MineModel *)model;

@property (nonatomic, copy) dispatch_block_t refreshHeightBlock;

@end
