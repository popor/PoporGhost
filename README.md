# PoporGhost

[![CI Status](https://img.shields.io/travis/popor/PoporGhost.svg?style=flat)](https://travis-ci.org/popor/PoporGhost)
[![Version](https://img.shields.io/cocoapods/v/PoporGhost.svg?style=flat)](https://cocoapods.org/pods/PoporGhost)
[![License](https://img.shields.io/cocoapods/l/PoporGhost.svg?style=flat)](https://cocoapods.org/pods/PoporGhost)
[![Platform](https://img.shields.io/cocoapods/p/PoporGhost.svg?style=flat)](https://cocoapods.org/pods/PoporGhost)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PoporGhost is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PoporGhost'
```

```
目的: 方便测试数据, 将测试数据转变为dic,通过yyCache保存到磁盘,可以在下一次恢复,适用于大量输入数据的情况.

#import "PoporGhost.h"
#import <ReactiveObjC/ReactiveObjC.h>

- (void)ghostAction {
    // 防止block循环引用
    @weakify(self);
    PoporGhostBlockRestore blockRestore;
    PoporGhostBlockVoid blockDisappear;
    
    // 恢复block
    blockRestore = ^(NSDictionary * restoreDic, NSString * description, NSString * time, NSString *     version) {
        @strongify(self);
        self.testEntity = [TestEntity yy_modelWithDictionary:restoreDic];
    
        self.nameTF.text = self.testEntity.name;
        self.addTF.text  = self.testEntity.add;
    
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    // ghost页面关闭block
    blockDisappear = ^(void) { };
    
    self.testEntity.name = self.nameTF.text;
    self.testEntity.add  = self.addTF.text;

    // 设置dic
    NSDictionary * dic;
    dic = @{
        @"blockRestore":blockRestore,
        @"blockDisappear":blockDisappear,
        @"title":@"记录", // 下个页面title
        @"saveKey":NSStringFromClass(self.view.class), // yyCache保存到磁盘的key
        @"saveDic":self.testEntity.yy_modelToJSONObject, // 需要保存的dic
    };
    
    [self.navigationController pushViewController:[[PoporGhost alloc] initWithDic:dic]  animated:YES];
}


```

<p>
<img src="https://github.com/popor/PoporGhost/blob/master/Example/Classes/image/screen1.png" width="30%" height="30%">
<img src="https://github.com/popor/PoporGhost/blob/master/Example/Classes/image/screen2.png" width="30%" height="30%">
<img src="https://github.com/popor/PoporGhost/blob/master/Example/Classes/image/screen3.png" width="30%" height="30%">

</p>

## Author

popor, 908891024@qq.com

## License

PoporGhost is available under the MIT license. See the LICENSE file for more info.
