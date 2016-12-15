# FPSDisplay
顯示 App 運行時的 FPS

使用時只要在 AppDelegate 的 application:didFinishLaunchingWithOptions: 中加上

**[FPSDisplay sharedFPSDisplay];**

即可，需注意必須放在 [self.window makeKeyAndVisible] 之後
