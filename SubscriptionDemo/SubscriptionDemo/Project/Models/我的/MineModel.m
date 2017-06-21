//
//  MineModel.m
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/21.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel

+ (instancetype)modelWithText:(NSString *)text allowSpread:(BOOL)allowSpread cellFlag:(NSInteger)cellFlag {
    MineModel *model = [MineModel new];
    model.text = text;
    model.allowSpread = allowSpread;

    return model;
}

@end
