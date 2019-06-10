//
//  PoporGhostPresenter.m
//  Ycsj
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 艾慧勇. All rights reserved.

#import "PoporGhostPresenter.h"
#import "PoporGhostInteractor.h"

//#import "PoporGhostListCell.h"

@interface PoporGhostPresenter ()

@property (nonatomic, weak  ) id<PoporGhostProtocol> view;
@property (nonatomic, strong) PoporGhostInteractor * interactor;

@end

@implementation PoporGhostPresenter

- (id)init {
    if (self = [super init]) {
        [self initInteractors];
        
    }
    return self;
}

- (void)setMyView:(id<PoporGhostProtocol>)view {
    self.view = view;
    [self.interactor fetchArray:self.view.saveKey];
}

- (void)initInteractors {
    if (!self.interactor) {
        self.interactor = [PoporGhostInteractor new];
    }
}

#pragma mark - VC_DataSource
#pragma mark - TV_Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interactor.infoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellID = @"CellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    PoporGhostListEntity * entity = self.interactor.infoArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, V:%@", entity.time, entity.version];
    cell.detailTextLabel.text = entity.des;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak typeof(self) weakSelf = self;
    {
        UIAlertController * oneAC = [UIAlertController alertControllerWithTitle:@"恢复该记录吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            PoporGhostListEntity * entity = weakSelf.interactor.infoArray[indexPath.row];
            
            if (weakSelf.view.blockRestore) {
                weakSelf.view.blockRestore(entity.dic, entity.des, entity.time, entity.version);
            }
        }];
        
        [oneAC addAction:cancleAction];
        [oneAC addAction:okAction];
        
        [self.view.vc presentViewController:oneAC animated:YES completion:nil];
    }
    
}

#pragma mark - tv 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 只要实现了这个方法，左滑出现按钮的功能就有了
// (一旦左滑出现了N个按钮，tableView就进入了编辑模式, tableView.editing = YES)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.view.infoTV) {
        __weak typeof(self) weakSelf = self;
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            [weakSelf.interactor.infoArray removeObjectAtIndex:indexPath.row];
            //[self.wineArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [weakSelf.interactor updateDic];
        }];
        
        return @[action1];
    }else{
        return nil;
    }
}


#pragma mark - VC_EventHandler
- (void)backupAction {
    {
        UIAlertController * oneAC = [UIAlertController alertControllerWithTitle:@"备份" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(self) weakSelf = self;
        [oneAC addTextFieldWithConfigurationHandler:^(UITextField *textField){
            
            textField.placeholder = @"描述";
            textField.text = @"";
        }];
        
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * changeAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField * nameTF = oneAC.textFields[0];
            //NSLog(@"更新 name: %@", nameTF.text);
            
            [weakSelf.interactor addDic:weakSelf.view.saveDic des:nameTF.text];
            [weakSelf.view.infoTV reloadData];
        }];
        
        [oneAC addAction:cancleAction];
        [oneAC addAction:changeAction];
        
        [self.view.vc presentViewController:oneAC animated:YES completion:nil];
    }
    
}

#pragma mark - Interactor_EventHandler

@end