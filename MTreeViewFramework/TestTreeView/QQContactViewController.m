//
//  QQContactViewController.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "QQContactViewController.h"
#import "ContactTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

#define DegreesToRadians(degrees) (degrees * M_PI / 180)

static NSString *QQContactViewControllerNode = @"QQContactViewControllerNode";

@implementation QQContactViewController

- (void) doConfigTreeView {
    self.treeView.rowHeight = 60.0f;
    [self.treeView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:QQContactViewControllerNode];
    self.treeView.rootNode = [MTreeNode initWithParent:nil expand:NO];
    
    NSArray *sectionData = @[@{@"name":@"我的设备", @"data":@"2/2"},
                             @{@"name":@"手机通讯录", @"data":@"未权限"},
                             @{@"name":@"我的好友", @"data":@"21/42"},
                             @{@"name":@"宝马", @"data":@"12/22"},
                             @{@"name":@"奔驰", @"data":@"32/50"}];
    
    for (NSUInteger i = 0; i < [sectionData count]; i++) {
        MTreeNode *node = [MTreeNode initWithParent:self.treeView.rootNode expand:(2 == i)];
        for (int j = 0; j < 4; j++) {
            MTreeNode *subnode = [MTreeNode initWithParent:node expand:NO];
            subnode.content = @{@"name":@"你好", @"image":@"User",@"detail":@"micker.cn", @"env":@"4G"};
            [node.subNodes addObject:subnode];
        }
        node.content = sectionData[i];
        [self.treeView.rootNode.subNodes addObject:node];
    }
}


#pragma mark --
#pragma mark UITableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1 == section ? 20 : 0.1f ;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 1 == section ? 20 : 0.1f)];
    footerView.alpha = 0;
    return footerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MTreeNode *subNode = [[self.treeView.rootNode subNodes] objectAtIndex:section];
    NSDictionary *nodeData = subNode.content;
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds), 50)];
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
        UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 20, 8, 10)];
        tipImageView.image = [UIImage imageNamed:@"tip"];
        tipImageView.tag = 10;
        [sectionView addSubview:tipImageView];
        [self doTipImageView:tipImageView expand:subNode.expand];
    }
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 30)];
        label.font = [UIFont systemFontOfSize:17.0f];
        label.tag = 20;
        label.text = nodeData[@"name"];
        [sectionView addSubview:label];
    }
    {
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - 100, 10, 90, 30)];
        numberLabel.font = [UIFont systemFontOfSize:12.0f];
        numberLabel.textColor = [UIColor lightGrayColor];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.tag = 30;
        numberLabel.text = nodeData[@"data"];
        [sectionView addSubview:numberLabel];
    }
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:indexPath];
    NSDictionary *nodeData = subNode.content;
    ContactTableViewCell *cell = (ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QQContactViewControllerNode];
    cell.nameLabel.text = nodeData[@"name"];
    cell.detailLabel.text = nodeData[@"detail"];
    cell.envLabel.text = nodeData[@"env"];
    cell.userImageView.image = [UIImage imageNamed:nodeData[@"image"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.treeView expandNodeAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --
#pragma mark Action

- (void) doTipImageView:(UIImageView *)imageView expand:(BOOL) expand {
    [UIView animateWithDuration:0.2f animations:^{
        imageView.transform = (expand) ? CGAffineTransformMakeRotation(DegreesToRadians(90)) : CGAffineTransformIdentity;
    }];
}

- (void)sectionTaped:(UIGestureRecognizer *) recognizer {
    UIView *view = recognizer.view;
    NSUInteger tag = view.tag - 1000;
    UIImageView *tipImageView = [view viewWithTag:10];
    MTreeNode *subNode = [self.treeView nodeAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:tag]];
    [self.treeView expandNodeAtIndexPath:[NSIndexPath indexPathForRow:-1 inSection:tag]];
    [self doTipImageView:tipImageView expand:subNode.expand];
}
@end
