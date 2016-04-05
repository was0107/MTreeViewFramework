//
//  TestViewController.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "TestViewController.h"


static NSString *TestViewControllerNode = @"TestViewControllerNode";

@implementation TestViewController

- (void) doConfigTreeView {
    [self.treeView registerClass:[UITableViewCell class] forCellReuseIdentifier:TestViewControllerNode];
    self.treeView.rootNode = [MTreeNode initWithParent:nil expand:NO];
    
    for (int i = 0; i < 3; i++) {
        MTreeNode *node = [MTreeNode initWithParent:self.treeView.rootNode expand:(0 == i)];
        for (int j = 0; j < 4; j++) {
            MTreeNode *subnode = [MTreeNode initWithParent:node expand:NO];
            [node.subNodes addObject:subnode];
            if (0 == j || 2 == j) {
                for (int k = 0; k < 5; k++) {
                    MTreeNode *subnode1 = [MTreeNode initWithParent:subnode expand:NO];
                    [subnode.subNodes addObject:subnode1];
                }
                subnode.expand = YES;
            }
        }
        [self.treeView.rootNode.subNodes addObject:node];
    }
}


#pragma mark --
#pragma mark UITableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MTreeNode *subNode = [[self.treeView.rootNode subNodes] objectAtIndex:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 40)];
    label.tag = 1000 + section;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTaped:)];
    [label addGestureRecognizer:recognizer];
    label.userInteractionEnabled = YES;
    label.text = [NSString stringWithFormat:@" %@级类目：%@",@(subNode.depth), @(section)];
    label.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@", label.text);
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestViewControllerNode];
    cell.separatorInset = UIEdgeInsetsMake(0, subNode.depth * 20.0f, 0, 0);
    cell.textLabel.text = [NSString stringWithFormat:@" %@级类目：%@",@(subNode.depth), @(indexPath.row)];
//    NSLog(@"==%@", cell.textLabel.text);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.treeView expandNodeAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --
#pragma mark MTreeView delegate

- (void) treeView:(MTreeView *)treeView willexpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"willexpandNodeAtIndexPath = [%@, %@]", @(indexPath.section), @(indexPath.row));
}

- (void) treeView:(MTreeView *)treeView didexpandNodeAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didexpandNodeAtIndexPath = [%@, %@]", @(indexPath.section), @(indexPath.row));
}


#pragma mark --
#pragma mark Action

- (void)sectionTaped:(UIGestureRecognizer *) recognizer {
    UIView *view = recognizer.view;
    NSUInteger tag = view.tag - 1000;
    [self.treeView expandNodeAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:tag]];
}
@end
