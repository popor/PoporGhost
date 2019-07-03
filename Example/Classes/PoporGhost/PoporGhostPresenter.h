//
//  PoporGhostPresenter.h
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import <Foundation/Foundation.h>
#import "PoporGhostProtocol.h"

// 处理和View事件
@interface PoporGhostPresenter : NSObject <PoporGhostEventHandler, PoporGhostDataSource, UITableViewDelegate, UITableViewDataSource>

// 初始化数据处理
- (void)setMyInteractor:(id)interactor;

// 很多操作,需要在设置了view之后才可以执行.
- (void)setMyView:(id)view;

@end
