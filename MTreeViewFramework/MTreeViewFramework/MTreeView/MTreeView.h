//
//  MTreeView.h
//  MTreeViewFramework
//
//  Created by Micker on 16/3/30.
//  Copyright © 2016年 micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTreeNode.h"

@protocol MTreeViewDelegate;

@interface MTreeView : UITableView

@property (nonatomic, readwrite, strong) MTreeNode *rootNode;

@property (nonatomic, readwrite, weak) IBOutlet id<MTreeViewDelegate> treeViewDelegate;

- (NSInteger) numberOfSectionsInTreeView:(MTreeView *)treeView;

- (NSInteger) treeView:(MTreeView *)treeView numberOfRowsInSection:(NSInteger)section;

- (void) expandNodeAtIndexPath:(NSIndexPath *)indexPath;

- (MTreeNode *) nodeAtIndexPath:(NSIndexPath *)indexPath;

@end



@protocol MTreeViewDelegate <NSObject>

@optional

/**
 *  即将展开/关闭子节点，此代理可以动态加载子节点
 *
 *  @parames
 *  @param  treeView
 *  @param  indexPath
 *
 */
- (void) treeView:(MTreeView *)treeView willexpandNodeAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  已经展开/关闭子节点，此代理可以于此进行动画效果的设置
 *
 *  @parames
 *  @param  treeView
 *  @param  indexPath
 *
 */
- (void) treeView:(MTreeView *)treeView didexpandNodeAtIndexPath:(NSIndexPath *)indexPath;

@end