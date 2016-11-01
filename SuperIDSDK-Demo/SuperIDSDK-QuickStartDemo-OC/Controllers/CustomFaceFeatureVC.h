//
//  CustomFaceFeatureVC.h
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/10/26.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDHeader.h"

//Step_1:  集成视图控制器类|SIDFaceFeatureViewController|
@interface CustomFaceFeatureVC : SIDFaceFeatureViewController

//此view不仅支持xib创建,也可以代码生成,可以灵活设置此view大小
@property (weak, nonatomic) IBOutlet SIDCameraPreviewView *preView;

@end
