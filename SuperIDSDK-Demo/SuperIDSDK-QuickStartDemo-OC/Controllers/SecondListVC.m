//
//  SecondListVC.m
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/10/26.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "SecondListVC.h"
#import "CustomFaceFeatureVC.h"
#import "CustomSearchFaceVC.h"

@interface SecondListVC () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView; //功能列表view
@property(nonatomic,strong) NSArray *data;//列表数据源
@end

@implementation SecondListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"人脸属性VC",@"人脸检索VC"];
    [self createUI];
}

//创建UI
- (void)createUI
{
    //创建功能列表view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"functionCell"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"functionCell"];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            //人脸属性
            [self.navigationController pushViewController:[[CustomFaceFeatureVC alloc] init] animated:YES];
            break;
        case 1:
            //人脸检索
            [self.navigationController pushViewController:[[CustomSearchFaceVC alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
