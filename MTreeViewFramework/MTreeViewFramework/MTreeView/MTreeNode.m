//
//  MTreeNode.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/30.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "MTreeNode.h"

@implementation MTreeNode

- (instancetype)init {
    [NSException raise:@"init error" format:@"use - (instancetype)initWithDepth:(NSUInteger)depth parent:(MTreeNode *) parent method to init"];
    return nil;
}

- (instancetype) initWithParent:(MTreeNode *) parent expand:(BOOL) expand {
    self = [super init];
    if (self) {
        self.subNodes = [NSMutableArray arrayWithCapacity:2];
        self.expand = expand;
        self.parentNode = parent;
    }
    return self;
}

+ (instancetype) initWithParent:(MTreeNode *) parent expand:(BOOL) expand {
    return [[MTreeNode alloc] initWithParent:parent expand:expand] ;
}

- (void) setParentNode:(MTreeNode *)parentNode {
    if (_parentNode != parentNode) {
        _parentNode = parentNode;
        [self __computeDepth];
    }
}

- (void) toggle {
    _expand = !_expand;
}


#pragma mark --
#pragma mark interneal 

- (void) __computeDepth {
    NSInteger length = -1;
    MTreeNode *parent = _parentNode;
    while (parent) {
        parent = parent.parentNode;
        length++;
    }
    _depth = length;
}


@end
