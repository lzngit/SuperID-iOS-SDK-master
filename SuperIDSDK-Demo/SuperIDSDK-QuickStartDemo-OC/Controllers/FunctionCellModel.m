//
//  FunctionCellModel.m
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/5/23.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import "FunctionCellModel.h"

@interface FunctionCellModel ()
{
    FunctionType _type;
    NSString *_title;
    UIColor *_titleColor;
    BOOL _enabled;
}
@end

@implementation FunctionCellModel
@dynamic type,title;

- (void)makeContentWithType:(FunctionType)type
{
    _type = type;
    switch (type) {
        case FunctionTypeSuperIDLogin:
            _title = @"一登登录";
            _titleColor = [UIColor blackColor];
            _enabled = YES;
            break;
        case FunctionTypeFaceEmotion:
            _title = @"人脸表情";
            _titleColor = [UIColor blackColor];
            _enabled = YES;
            break;
        case FunctionTypeFaceVerify:
            _title = @"刷脸认证";
            _titleColor = [UIColor lightGrayColor];
            _enabled = NO;
            break;
        case FunctionTypeRelieveBinding:
            _title = @"解除绑定";
            _titleColor = [UIColor lightGrayColor];
            _enabled = NO;
            break;
        case FunctionTypeQuitSuperIDLogin:
            _title = @"退出登录";
            _titleColor = [UIColor lightGrayColor];
            _enabled = NO;
            break;
            
        default:
            _title = @"异常type";
            _titleColor = [UIColor lightGrayColor];
            _enabled = NO;
            break;
    }
}

+ (instancetype)createWithType:(FunctionType)type
{
    FunctionCellModel *model = [[FunctionCellModel alloc] init];
    [model makeContentWithType:type];
    return model;
}
- (FunctionType)type
{
    return _type;
}
- (NSString *)title
{
    return _title;
}
@end
