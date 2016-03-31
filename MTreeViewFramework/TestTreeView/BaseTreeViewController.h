//
//  BaseTreeViewController.h
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTreeView.h"

@interface BaseTreeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MTreeViewDelegate>

@property (nonatomic, strong) IBOutlet MTreeView *treeView;


/**
 *  钩子函数，子类对TreeView进行配置
 *
 *  @parames
 *
 */
- (void) doConfigTreeView;

@end
