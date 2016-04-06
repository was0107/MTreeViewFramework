//
//  MTreeNode+ExpandNode.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "MTreeNode+ExpandNode.h"
#import <objc/runtime.h>

@implementation MTreeNode (ExpandNode)

- (NSMutableArray *) expandNodes {
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:2];
        [self setExpandNodes:array];
    }
    return array;
}

- (void) setExpandNodes:(NSMutableArray *)expandNodes {
    objc_setAssociatedObject(self, @selector(expandNodes), expandNodes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *) getSubExpandNodes {
    [self.expandNodes removeAllObjects];
    [self __computeExpandFromNode:self];
    return self.expandNodes;
}

- (void) __computeExpandFromNode:(MTreeNode *) node {
    NSMutableArray *result = self.expandNodes;
    if (node.expand) {
        for (MTreeNode *node1 in node.subNodes) {
            [result addObject:node1];
            [self __computeExpandFromNode:node1];
        }
    }
}

@end
