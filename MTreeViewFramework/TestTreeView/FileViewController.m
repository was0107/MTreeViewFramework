//
//  FileViewController.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "FileViewController.h"

static NSString *FileViewControllerNode = @"FileViewControllerNode";

@interface FileViewController()
@property (nonatomic, strong) NSFileManager  *fileManager;

@end

@implementation FileViewController

- (void) doConfigTreeView {
    [self.treeView registerClass:[UITableViewCell class] forCellReuseIdentifier:FileViewControllerNode];
    self.treeView.rootNode = [MTreeNode initWithParent:nil expand:NO];
    self.treeView.rootNode.content = NSHomeDirectory();
    self.fileManager = [NSFileManager defaultManager];
    NSArray *files = [self.fileManager contentsOfDirectoryAtPath:self.treeView.rootNode.content error:nil];
    for (int i = 0; i < [files count]; i++) {
        MTreeNode *node = [MTreeNode initWithParent:self.treeView.rootNode expand:NO];
        node.content = files[i];
        [self.treeView.rootNode.subNodes addObject:node];
    }
}

#pragma mark --
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f ;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 0.01f)];
    footerView.alpha = 0;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MTreeNode *subNode = [[self.treeView.rootNode subNodes] objectAtIndex:section];
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 44)];
    {
        sectionView.tag = 1000 + section;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTaped:)];
        [sectionView addGestureRecognizer:recognizer];
        sectionView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = 0.5f;
        [sectionView addSubview:line];
    }
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2.0f, CGRectGetMaxX(self.view.bounds) - 56, 40)];
        label.text = subNode.content;
        label.font = [UIFont systemFontOfSize:16.0];
        [sectionView addSubview:label];
    }
    {
        UIView *accessoryView = [self accessoryViewAtNode:subNode];
        accessoryView.frame = CGRectMake(CGRectGetMaxX(self.view.bounds) - 36, 10, 20, 20);
        [sectionView addSubview:accessoryView];
    }
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FileViewControllerNode];
    cell.separatorInset = UIEdgeInsetsMake(0, subNode.depth * 20.0f, 0, 0);
    cell.textLabel.text = subNode.content;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.accessoryView = [self accessoryViewAtNode:subNode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.treeView expandNodeAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --
#pragma mark MTreeView delegate

- (void) treeView:(MTreeView *)treeView willexpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:indexPath];
    NSString *subPath = [self filePathAtNode:subNode];
    BOOL directiory = NO;
    [_fileManager fileExistsAtPath:subPath isDirectory:&directiory];
    if (directiory) {
        NSArray *files = [self.fileManager contentsOfDirectoryAtPath:subPath error:nil];
        if ([files count] != 0 && [subNode.subNodes count] == 0) {
            for (int i = 0; i < [files count]; i++) {
                MTreeNode *node = [MTreeNode initWithParent:subNode expand:NO];
                node.content = files[i];
                [subNode.subNodes addObject:node];
            }
        }
    }
}

- (void) treeView:(MTreeView *)treeView didexpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:indexPath];
    NSLog(@"file = %@", subNode.content);
}


#pragma mark --
#pragma mark Action

- (void)sectionTaped:(UIGestureRecognizer *) recognizer {
    UIView *view = recognizer.view;
    NSUInteger tag = view.tag - 1000;
    [self.treeView expandNodeAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:tag]];
}

#pragma mark --
#pragma mark internal

- (UIView *) accessoryViewAtNode:(MTreeNode *) node {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:[self isDirectoryAtNode:node] ? @"folder" : @"file"];
    return imageView;
}

- (BOOL) isDirectoryAtNode:(MTreeNode *) node {
    NSString *subPath = [self filePathAtNode:node];
    BOOL directiory = NO;
    [_fileManager fileExistsAtPath:subPath isDirectory:&directiory];
    return directiory;
}

- (NSString *) filePathAtNode:(MTreeNode *)node {
    NSMutableString *subPath = node.content;
    MTreeNode *parent = node;
    while (parent.parentNode) {
        parent = parent.parentNode;
        subPath = [NSMutableString stringWithFormat:@"%@/%@",parent.content, subPath];
    }
    return subPath;
}
@end
