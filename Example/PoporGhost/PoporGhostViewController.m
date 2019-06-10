//
//  PoporGhostViewController.m
//  PoporGhost
//
//  Created by popor on 06/10/2019.
//  Copyright (c) 2019 popor. All rights reserved.
//

#import "PoporGhostViewController.h"

#import "PoporGhost.h"
#import "TestEntity.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface PoporGhostViewController ()

@property (nonatomic, strong) UITextField * nameTF;
@property (nonatomic, strong) UITextField * addTF;

@property (nonatomic, strong) TestEntity  * testEntity;
@end

@implementation PoporGhostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.title = @"Ghost";
    self.testEntity = [TestEntity new];
    [self addViews];
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(ghostAction)];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
}

- (void)addViews {
    
    for (int i = 0; i<2; i++) {
        UITextField * tf = [UITextField new];
        tf.font = [UIFont systemFontOfSize:16];
        tf.textColor = [UIColor blackColor];
        tf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        tf.layer.cornerRadius = 5.0;
        tf.clipsToBounds = YES;
        
        [self.view addSubview:tf];
        switch (i) {
            case 0:{
                self.nameTF = tf;
                tf.placeholder = @"请输入姓名";
                tf.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 40);
                break;
            }
            case 1:{
                self.addTF = tf;
                tf.placeholder = @"请输入地址";
                tf.frame = CGRectMake(20, 160, self.view.frame.size.width - 40, 40);
                
                break;
            }
            default:
                break;
        }
    }
}

- (void)ghostAction {
    @weakify(self);
    PoporGhostBlockRestore blockRestore;
    PoporGhostBlockVoid blockDisappear;
    
    blockRestore = ^(NSDictionary * restoreDic, NSString * description, NSString * time, NSString * version) {
        @strongify(self);
        self.testEntity = [TestEntity yy_modelWithDictionary:restoreDic];
        
        self.nameTF.text = self.testEntity.name;
        self.addTF.text  = self.testEntity.add;
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    blockDisappear = ^(void) { };
    
    self.testEntity.name = self.nameTF.text;
    self.testEntity.add  = self.addTF.text;
    NSDictionary * dic;
    dic = @{@"blockRestore":blockRestore,
            @"blockDisappear":blockDisappear,
            @"title":@"记录",
            @"saveKey":NSStringFromClass(self.view.class),
            @"saveDic":self.testEntity.yy_modelToJSONObject,
            };
    
    [self.navigationController pushViewController:[[PoporGhost alloc] initWithDic:dic]  animated:YES];
}

@end
