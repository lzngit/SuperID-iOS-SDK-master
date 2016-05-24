//
//  FunctionCellModel.h
//  SuperIDSDK-Demo-OC
//
//  Created by lzn on 16/5/23.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FunctionType) {
    FunctionTypeSuperIDLogin = 1, //一登登录
    FunctionTypeFaceEmotion,      //人脸表情
    FunctionTypeFaceVerify,       //刷脸认证
    FunctionTypeRelieveBinding,   //解除绑定
    FunctionTypeQuitSuperIDLogin, //退出登录
};

@interface FunctionCellModel : NSObject

//获取model属性
@property(nonatomic,assign,readonly) FunctionType type;

//获取title文本
@property(nonatomic,assign,readonly) NSString *title;

//获取title颜色
@property(nonatomic,strong) UIColor *titleColor;

//是否支持点击事件
@property(nonatomic,assign) BOOL enabled;

//创建model
+ (instancetype)createWithType:(FunctionType)type;

@end
