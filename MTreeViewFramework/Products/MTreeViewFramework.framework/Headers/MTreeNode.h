//
//  MTreeNode.h
//  MTreeViewFramework
//
//  Created by Micker on 16/3/30.
//  Copyright © 2016年 micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTreeNode : NSObject

@property (nonatomic, readwrite, assign) BOOL expand;  // 返回当前节点是否已经展开，默认为NO

@property (nonatomic, readonly, assign) NSInteger depth; // 返回当前节点深度,默认为0，根节点为-1

@property (nonatomic, readonly, weak) MTreeNode *parentNode; // 返回当前节点的爷节点

@property (nonatomic, readwrite, strong) id content;    // 存储当前节点的数据模型

@property (nonatomic, readwrite, strong) NSMutableArray *subNodes; // 存储当前节点的子节点集合

- (instancetype)initWithParent:(MTreeNode *) parent expand:(BOOL) expand;

+ (instancetype)initWithParent:(MTreeNode *) parent expand:(BOOL) expand;

- (void) toggle;

@end
