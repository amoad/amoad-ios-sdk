//
//  ScreenViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/12.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "ScreenViewController.h"
#import "AMoAdNativePreRoll.h"
#import "AMoAdAnalytics.h"

@interface ScreenViewController ()

@end

@implementation ScreenViewController
static NSString *const kTag = @"ad01";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAd];
}

- (void)initAd{
    UIView *templateView = [[UIView alloc]initWithFrame:[self fullSizeFrame]];
    
    AMoAdAnalytics *analytics = [[AMoAdAnalytics alloc]initWithReportId:@"report001"];
    analytics.publisherParam = @{@"key1":@"value1", @"key2":@"value2"};
    
    [AMoAdNativePreRoll prepareAdWithSid:self.sid];
    [AMoAdNativePreRoll renderAdWithSid:self.sid tag:kTag view:templateView analytics:analytics completion:^(NSString *sid, NSString *tag, UIView *view, AMoAdResult result) {
        switch (result) {
            case AMoAdResultEmpty:
                // 空の広告を受信した
                NSLog(@"空の広告を受信した");
                break;
            case AMoAdResultFailure:
                // 広告の取得に失敗した
                NSLog(@"広告の取得に失敗した");
                break;
            case AMoAdResultSuccess:
                // 正常に広告を受信した
                NSLog(@"正常に広告を受信した");
                break;
        }
    }];
    
    [self.view addSubview:templateView];
}

- (CGRect)fullSizeFrame {
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenBounds = screen.bounds;
    return CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
}

@end
