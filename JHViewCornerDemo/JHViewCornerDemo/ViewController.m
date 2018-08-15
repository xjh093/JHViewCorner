//
//  ViewController.m
//  JHViewCornerDemo
//
//  Created by 薛精豪 on 2018/8/15.
//  Copyright © 2018年 HN. All rights reserved.
//

#import "ViewController.h"
#import "JHImageCornerCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,  strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"圆角&心形";
    [self xjh_setupViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------------------------视图-------------------------------------------

- (void)xjh_setupViews
{
    CGFloat W = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat H = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat Y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.tableView.frame = CGRectMake(0,Y,W,H-Y);
    [self.view addSubview:self.tableView];
}

#pragma mark -------------------------------------事件-------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHImageCornerCell *cell = [JHImageCornerCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UITableView *)tableView{
    if (!_tableView) {
        [self.view addSubview:[[UIView alloc] init]];
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.rowHeight = 60;
        _tableView = tableView;
    }
    return _tableView;
}


@end
