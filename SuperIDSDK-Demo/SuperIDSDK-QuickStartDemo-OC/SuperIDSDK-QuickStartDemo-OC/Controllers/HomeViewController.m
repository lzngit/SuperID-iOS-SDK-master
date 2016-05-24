//
//  HomeViewController.m
//  SuperIDSDK-Demo-OC
//
//  Created by lzn on 16/5/13.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "HomeViewController.h"
#import "FunctionCellModel.h"

//Step_1:  引用头文件"SuperID.h"
#import "SuperID.h"

//Step_2:  遵守协议<SuperIDDelegate>
@interface HomeViewController () <SuperIDDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView; //功能列表view
@property(nonatomic,strong) NSArray *data;//列表数据源
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self createUI];
    
    //刷新列表数据
    [self refreshTableData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Step_3:  设置|SuperID|代理
    [SuperID sharedInstance].delegate = self;
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

//刷新列表数据
- (void)refreshTableData
{
    //一登登录
    FunctionCellModel *m1 = [FunctionCellModel createWithType:FunctionTypeSuperIDLogin];
    //人脸表情
    FunctionCellModel *m2 = [FunctionCellModel createWithType:FunctionTypeFaceEmotion];
    //刷脸认证
    FunctionCellModel *m3 = [FunctionCellModel createWithType:FunctionTypeFaceVerify];
    //解除绑定
    FunctionCellModel *m4 = [FunctionCellModel createWithType:FunctionTypeRelieveBinding];
    //退出登录
    FunctionCellModel *m5 = [FunctionCellModel createWithType:FunctionTypeQuitSuperIDLogin];
    
    self.data = @[m1,m2,m3,m4,m5];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"functionCell"];
    FunctionCellModel *model = self.data[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.textColor = model.titleColor;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunctionCellModel *model = self.data[indexPath.row];
    return model.enabled;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunctionCellModel *model = self.data[indexPath.row];
    switch (model.type) {
        case FunctionTypeSuperIDLogin:
            //一登登录
            [self superIDLogin];
            break;
            
        default:
            break;
    }
}

#pragma mark - SuperIDDelegate
//登录处理
- (void)superID:(SuperID *)sender userDidFinishLoginWithUserInfo:(NSDictionary *)userInfo withOpenId:(NSString *)openId error:(NSError *)error{
    if (!error) {
        //登录成功,开启其他功能
        for (FunctionCellModel *model in self.data) {
            if (model.type == FunctionTypeSuperIDLogin) {
                model.titleColor = [UIColor lightGrayColor];
                model.enabled = NO;
            }else {
                model.titleColor = [UIColor blackColor];
                model.enabled = NO;
            }
        }
        [self.tableView reloadData];
        NSLog(@"一登登录成功,返回openId:%@",openId);
        NSLog(@"一登登录成功,返回给开发者用户数据:%@",userInfo);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"一登登录成功,请查看控制台打印数据" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
     
    }else{
        //用户登录失败的执行内容
        NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}


#pragma mark - InnerEvent
//一登登录
- (void)superIDLogin
{
    NSError *error = nil;
    //获取SuperID登录VC的实例
    id loginVc = [[SuperID sharedInstance] obtainLoginViewControllerWithError:&error];
    //判断获取登录VC是否创建成功
    if (loginVc) {
        //如果loginVc非nil,则获取成功,则可以使用一登人脸登录服务
        [self presentViewController:loginVc animated:YES completion:nil];
    }else{
        //如果loginVc为nil,打印error信息,查找bug
        NSLog(@"Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}

@end
