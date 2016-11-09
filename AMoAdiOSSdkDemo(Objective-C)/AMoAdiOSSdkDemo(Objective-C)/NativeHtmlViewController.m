//
//  NativeHtmlViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/12.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "NativeHtmlViewController.h"
#import "AMoAdNative.h"

@interface NativeHtmlViewController ()
@end

@implementation NativeHtmlViewController
static NSString *const kTag = @"ad01";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAd];
}

- (void)initAd {
    [AMoAdNative loadWithSid:self.sid
                         tag:kTag
                       frame:CGRectMake(100, 200, 140, 120)
                  completion:^(NSString *sid, NSString *tag, AMoAdResult result, NSDictionary *serverInfo) {
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
    [self.view addSubview:[AMoAdNative viewWithSid:self.sid tag:kTag]];
}
- (void)showAd {
    [AMoAdNative showWithSid:self.sid tag:kTag];
}
- (void)reloadAd {
    [AMoAdNative reloadWithSid:self.sid tag:kTag];
}
- (void)hideAd {
    [AMoAdNative hideWithSid:self.sid tag:kTag];
}
- (IBAction)onShowBtnClicked:(id)sender {
    [self showAd];
}
- (IBAction)onReloadBtnClicked:(id)sender {
    [self reloadAd];
}
- (IBAction)onHideBtnClicked:(id)sender {
    [self hideAd];
}

@end
