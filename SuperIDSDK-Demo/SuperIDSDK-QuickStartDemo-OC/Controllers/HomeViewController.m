//
//  HomeViewController.m
//  SuperIDSDK-QuickStartDemo-OC
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

//登录成功后,屏蔽登录功能,开启其他功能
- (void)loginSucceedRefreshTableState
{
    for (FunctionCellModel *model in self.data) {
        if (model.type == FunctionTypeSuperIDLogin) {
            model.titleColor = [UIColor lightGrayColor];
            model.enabled = NO;
        }else {
            model.titleColor = [UIColor blackColor];
            model.enabled = YES;
        }
    }
    [self.tableView reloadData];
}

//开启一登登录功能,屏蔽其他功能,其他功能必须要登录后,才能使用
- (void)openLoginSucceedRefreshTableState
{
    for (FunctionCellModel *model in self.data) {
        if (model.type == FunctionTypeSuperIDLogin) {
            model.titleColor = [UIColor blackColor];
            model.enabled = YES;
        }else {
            model.titleColor = [UIColor lightGrayColor];
            model.enabled = NO;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

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
        case FunctionTypeFaceEmotion:
            //人脸表情
            [self faceEmotion];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case FunctionTypeFaceVerify:
            //刷脸认证
            [self faceVerify];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case FunctionTypeRelieveBinding:
            //解除绑定
            [self relieveBinding];
            break;
        case FunctionTypeQuitSuperIDLogin:
            //退出登录
            [self quitSuperIDLogin];
            break;
            
        default:
            break;
    }
}

#pragma mark - SuperIDDelegate
//登录处理
- (void)superID:(SuperID *)sender userDidFinishLoginWithUserInfo:(NSDictionary *)userInfo withOpenId:(NSString *)openId error:(NSError *)error{
    if (!error) {
        [self loginSucceedRefreshTableState];
        NSLog(@"一登登录成功,返回openId:%@",openId);
        NSLog(@"一登登录成功,返回给开发者用户数据:%@",userInfo);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"一登登录成功" message:@"控制台打印一登回传的数据" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
     
    }else{
        //用户登录失败的执行内容
        NSLog(@"loginView Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}

//人脸表情
- (void)superID:(SuperID *)sender userDidFinishGetFaceFeatureWithFeatureInfo:(NSDictionary *) featureInfo error:(NSError *)error
{
    if (!error) {
        NSLog(@"人脸表情获取成功,返回给开发者表情数据:%@",featureInfo);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人脸表情获取成功" message:@"控制台打印一登回传的表情数据" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        
    }else{
        //用户登录失败的执行内容
        NSLog(@"获取表情Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}

//刷脸认证
- (void)superID:(SuperID *)sender faceVerifyResponse:(SIDFACEVerifyState)state
{
    NSString *title = nil;
    if (state == SIDFaceVerifySucceed) {
        title = @"刷脸验证成功";
    }else {
        title = @"刷脸验证失败";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];
}

//解绑处理
- (void)superID:(SuperID *)sender userDidFinishCancelAuthorization:(NSError *)error
{
    if (!error) {
        [[SuperID sharedInstance] appUserLogoutCurrentAccount];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"解绑成功" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        //解绑成功,重新开启一登登录功能
        [self openLoginSucceedRefreshTableState];
    }else {
        //解绑失败
        NSLog(@"relieveBinding Error =%ld,%@",(long)[error code],[error localizedDescription]);
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

//人脸表情
- (void)faceEmotion
{
    NSError *error = nil;
    id emotionVc = [[SuperID sharedInstance] obtainFaceFeatureViewControllerWithError:&error];
    if (emotionVc) {
        [self presentViewController:emotionVc animated:YES completion:nil];
    }else{
        NSLog(@"FaceEmotion Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}

//刷脸认证
- (void)faceVerify
{
    NSError *error = nil;
    id verifyVc = [[SuperID sharedInstance] obtainFaceVerifyViewControllerWithRetryCount:nil error:&error];
    if (verifyVc) {
        [self presentViewController:verifyVc animated:YES completion:nil];
    }else{
        NSLog(@"FaceVerify Error =%ld,%@",(long)[error code],[error localizedDescription]);
    }
}

//解除绑定
- (void)relieveBinding
{
    [[SuperID sharedInstance] userCancelAuthorization];
}

//退出登录
- (void)quitSuperIDLogin
{
    [[SuperID sharedInstance] appUserLogoutCurrentAccount];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录成功" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];
    //退出登录,重新开启一登登录功能
    [self openLoginSucceedRefreshTableState];
}

@end
