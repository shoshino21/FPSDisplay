//
//  FPSDisplay.m
//  FPSDisplay
//
//  Created by shoshino21 on 2016/12/15.
//  Copyright © 2016年 shoshino21. All rights reserved.
//

#import "FPSDisplay.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kFPSDisplayWidth 60
#define kFPSDisplayHeight 20

@implementation FPSDisplay

+ (instancetype)sharedFPSDisplay {
  static FPSDisplay *sharedFPSDisplay;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedFPSDisplay = [[FPSDisplay alloc] init];
  });
  return sharedFPSDisplay;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [self settingDisplayLabel];
  }
  return self;
}

- (void)settingDisplayLabel {
  CGRect frame = CGRectMake(SCREEN_WIDTH * 0.65, 0, kFPSDisplayWidth, kFPSDisplayHeight);
  self.displayLabel = [[UILabel alloc] initWithFrame:frame];
  self.displayLabel.layer.cornerRadius = 5;
  self.displayLabel.clipsToBounds = YES;
  self.displayLabel.textAlignment = NSTextAlignmentCenter;
  self.displayLabel.userInteractionEnabled = NO;
  self.displayLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
  self.displayLabel.textColor = [UIColor greenColor];
  self.displayLabel.font = [UIFont systemFontOfSize:14.f];

  [self initCADisplayLink];

  // 永遠顯示在畫面上
  [[UIApplication sharedApplication].keyWindow addSubview:self.displayLabel];
}

- (void)initCADisplayLink {
  self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];

  // Timer 必須加入 NSRunLoopCommonModes，否則滑動時 Timer 會暫停運作
  // 參照 http://www.jianshu.com/p/878bfd38666d
  [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)link {
  if (self.lastTime == 0) {
    self.lastTime = link.timestamp;
    return;
  }

  self.fpsCount += 1;
  NSTimeInterval delta = link.timestamp - self.lastTime;

  // 每秒計算一次 FPS
  if (delta >= 1) {
    self.lastTime = link.timestamp;
    float fps = self.fpsCount / delta;
    self.fpsCount = 0;

    [self updateDisplayLabelText:fps];
  }
}

- (void)updateDisplayLabelText:(float)fps {
  self.displayLabel.text = [NSString stringWithFormat:@"%d FPS", (int)round(fps)];
}

- (void)dealloc {
  [_displayLink invalidate];
}

@end
