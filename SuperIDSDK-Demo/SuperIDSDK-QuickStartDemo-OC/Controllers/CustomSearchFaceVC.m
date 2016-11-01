//
//  CustomSearchFaceVC.m
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/10/26.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "CustomSearchFaceVC.h"

@interface CustomSearchFaceVC ()

@end

@implementation CustomSearchFaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Step_3:  设置预览视频view,三方可以根据自身业务,灵活设置此view的大小,也可以设置隐藏
    [self setupSearchFaceManagerWithPreview:_prevView];

}

//Step_4:  实现协议|SIDSearchFaceProtocol|如下三个方法
- (void)hasGetTheUserFace{
    NSLog(@"检测到人脸");
}

- (void)groupCompareResult:(BOOL)isSucceed usersArray:(NSArray *)usersArray
{
    NSLog(@"%d %@",isSucceed,usersArray);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"检测结果::%@",usersArray] delegate:nil cancelButtonTitle:@"退出" otherButtonTitles: nil];
    [alert show];
}

- (void)userCannotPassLivenessDetect
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请真人刷脸" delegate:nil cancelButtonTitle:@"退出" otherButtonTitles: nil];
    [alert show];
}

//开始搜索
- (IBAction)startCheck:(id)sender {
    //关于sourceId和groupId,详情请查阅技术文档,
    [self startDetectFaceWithSourceId:@"oOLuPIbkuw1TBjO0m5oYe0YP" GroupId:@"82c00fe7ab820b6ceb3bf84093a2539d"];
}

@end
