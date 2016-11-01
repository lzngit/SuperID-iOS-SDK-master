//
//  CustomFaceFeatureVC.m
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/10/26.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "CustomFaceFeatureVC.h"

@interface CustomFaceFeatureVC ()



@end

@implementation CustomFaceFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Step_2:  设置预览视频view,三方可以根据自身业务,灵活设置此view的大小,也可以设置隐藏
    
    //创建视频输出窗口view
    SIDCameraPreviewView *preView = [[SIDCameraPreviewView alloc] init];
    //设置frame,开发者可以使用约束灵活设置其frame
    preView.frame = self.view.bounds;
    //加载预览窗口view
    [self.view addSubview:preView];

    [self setupFaceFeatureManagerWithPreview:preView];
    
    
    
    [self.view sendSubviewToBack:preView];

}

//Step_3: 重写下面三个方法,三方可以根据自身业务,灵活设计UI交互
- (void)didFinishDetectFace
{
    NSLog(@"检查到人脸,调用此方法");
}

- (void)getFaceFeatureFail:(NSError *)error
{
    NSLog(@"检查人脸属性错误");
}

- (void)getFaceFeatureSucceedWithFeatureInfo:(NSDictionary *)featureInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"检测结果::%@",featureInfo] delegate:nil cancelButtonTitle:@"退出" otherButtonTitles: nil];
    [alert show];
}

//开始检测人脸属性
- (IBAction)start:(id)sender {
    [self startDetectFaceFeature];
}

//停止检测人脸属性
- (IBAction)stop:(id)sender {
    [self stopDetectFaceFeature];
}

//可以设置隐藏预览视频view
- (IBAction)hiddenCameraView:(id)sender {
    self.preView.hidden = !self.preView.hidden;
}


@end
