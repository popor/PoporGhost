//
//  PoporGhostProtocol.h
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^PoporGhostBlockRestore) (NSDictionary * restoreDic, NSString * description, NSString * time, NSString * version);
typedef void(^PoporGhostBlockVoid) (void);

// MARK: 对外接口
@protocol PoporGhostProtocol <NSObject>

- (UIViewController *)vc;

// MARK: 自己的
@property (nonatomic, strong) UITableView * infoTV;

// MARK: 外部注入的
@property (nonatomic, strong) NSDictionary   * saveDic;
@property (nonatomic, strong) NSString       * saveKey;

@property (nonatomic, copy  ) PoporGhostBlockRestore blockRestore;
@property (nonatomic, copy  ) PoporGhostBlockVoid blockDisappear;

@end

// MARK: 数据来源
@protocol PoporGhostDataSource <NSObject>

@end

// MARK: UI事件
@protocol PoporGhostEventHandler <NSObject>

- (void)backupAction;

@end
