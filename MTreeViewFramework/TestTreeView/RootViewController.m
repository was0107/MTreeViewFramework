//
//  RootViewController.m
//  TestTreeView
//
//  Created by Micker on 16/3/30.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "RootViewController.h"
#import "MTreeView.h"


@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
