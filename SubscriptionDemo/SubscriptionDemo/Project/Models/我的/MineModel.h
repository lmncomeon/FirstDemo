//
//  MineModel.h
//  SubscriptionDemo
//
//  Created by 栾美娜 on 2017/6/21.
//  Copyright © 2017年 栾美娜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MineModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL allowSpread;

@property (nonatomic, assign) NSInteger cellFlag;

+ (instancetype)modelWithText:(NSString *)text allowSpread:(BOOL)allowSpread cellFlag:(NSInteger)cellFlag;

@end
