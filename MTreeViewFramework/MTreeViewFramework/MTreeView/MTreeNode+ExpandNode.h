//
//  MTreeNode+ExpandNode.h
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "MTreeNode.h"

@interface MTreeNode (ExpandNode)

@property (nonatomic, strong) NSMutableArray *expandNodes;      //存储当前节点之下展开的节点

- (NSArray *) getSubExpandNodes;

@end
