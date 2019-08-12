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

- (void)setMyInteractor:(id)interactor;

- (void)setMyView:(id)view;

// 开始执行事件,比如获取网络数据
- (void)startEvent;

@end
