//
//  PoporGhostInteractor.h
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import <Foundation/Foundation.h>
#import "PoporGhostListEntity.h"

// 处理Entity事件
@interface PoporGhostInteractor : NSObject

@property (nonatomic, strong) NSMutableArray * infoArray;

- (void)fetchArray:(NSString *)className;
- (void)addDic:(NSDictionary *)dic des:(NSString *)description;
- (void)updateDic;

@end
