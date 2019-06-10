//
//  PoporGhost.m
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import "PoporGhost.h"
#import "PoporGhostPresenter.h"
#import <Masonry/Masonry.h>

@interface PoporGhost ()

@property (nonatomic, strong) PoporGhostPresenter * present;

@end

@implementation PoporGhost
@synthesize infoTV;
@synthesize saveDic;
@synthesize saveKey;
@synthesize blockRestore;
@synthesize blockDisappear;

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        if (dic) {
            self.title          = dic[@"title"];
            self.saveKey        = dic[@"saveKey"];
            self.blockRestore   = dic[@"blockRestore"];
            self.blockDisappear = dic[@"blockDisappear"];
            self.saveDic        = dic[@"saveDic"];
        }
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.blockDisappear) {
        self.blockDisappear();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.title) {
        self.title = @"Ghost";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!self.present) {
        PoporGhostPresenter * present = [PoporGhostPresenter new];
        self.present = present;
        [present setMyView:self];
    }
    
    [self addViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 参考: https://www.jianshu.com/p/c244f5930fdf
    if (self.isViewLoaded && !self.view.window) {
        // self.view = nil;//当再次进入此视图中时能够重新调用viewDidLoad方法
        
    }
}

#pragma mark - VCProtocol
- (UIViewController *)vc {
    return self;
}

- (void)setMyPresent:(id)present {
    self.present = present;
}

#pragma mark - views
- (void)addViews {
    self.infoTV = [self addTVs];
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self.present action:@selector(backupAction)];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
}

- (UITableView *)addTVs {
    UITableView * oneTV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    oneTV.delegate   = self.present;
    oneTV.dataSource = self.present;
    
    oneTV.allowsMultipleSelectionDuringEditing = YES;
    oneTV.directionalLockEnabled = YES;
    
    oneTV.estimatedRowHeight           = 0;
    oneTV.estimatedSectionHeaderHeight = 0;
    oneTV.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:oneTV];
    
    [oneTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    return oneTV;
}

@end
