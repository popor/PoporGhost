//
//  PoporGhost.h
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import <UIKit/UIKit.h>
#import "PoporGhostProtocol.h"

@interface PoporGhost : UIViewController <PoporGhostProtocol>

- (instancetype)initWithDic:(NSDictionary *)dic;

- (void)addViews;

// 开始执行事件,比如获取网络数据
- (void)startEvent;

@end
