//
//  CustomSearchFaceVC.h
//  SuperIDSDK-QuickStartDemo-OC
//
//  Created by lzn on 16/10/26.
//  Copyright © 2016年 SuperID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDHeader.h"

//Step_1:  集成视图控制器类|SIDSearchFaceViewController|
//Step_2:  遵守协议|SIDSearchFaceProtocol|
@interface CustomSearchFaceVC : SIDSearchFaceViewController <SIDSearchFaceProtocol>

@property (weak, nonatomic) IBOutlet SIDCameraPreviewView *prevView;

@end
