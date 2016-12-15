//
//  FPSDisplay.h
//  FPSDisplay
//
//  Created by shoshino21 on 2016/12/15.
//  Copyright © 2016年 shoshino21. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FPSDisplay : NSObject

+ (instancetype)sharedFPSDisplay;

@property (nonatomic, strong) UILabel *displayLabel;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger fpsCount;
@property (nonatomic, assign) NSTimeInterval lastTime;

@end
