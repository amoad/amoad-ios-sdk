//
//  ViewController.m
//  AMoAdNativeAppText
//
//  Created by AMoAd on 2015/02/19.
//  Copyright (c) 2015年 AMoAd. All rights reserved.
//

#import "ViewController.h"
#import "AMoAdNativeView.h"
#import "AMoAdLogger.h"

static NSString *const kSid = @"管理画面から取得したネイティブ（App）アイコン＋テキストのsidを指定してください";
static NSString *const kTag1 = @"Ad01";
static NSString *const kTag2 = @"Ad02";
static NSString *const kNibName = @"AdTextView";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *renderAdView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [SDL] ロガーの設定
    [AMoAdLogger sharedLogger].logging = YES; // YES...ログを出力する
    [AMoAdLogger sharedLogger].onLogging = ^(NSString *message, NSError *error) { // 出力方法をカスタマイズ（オプショナル）
        NSLog(@"【%@】%@:%@", [[NSBundle mainBundle] bundleIdentifier], message, error);
    };
    [AMoAdLogger sharedLogger].trace = YES; // YES...トレースを出力する
    [AMoAdLogger sharedLogger].onTrace = ^(NSString *message, NSObject *target) { // 出力方法をカスタマイズ（オプショナル）
        NSLog(@"【%@】%@:%@", [[NSBundle mainBundle] bundleIdentifier], message, target);
    };
    // [SDK] 広告準備（prepareAd）
    [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:kSid];
    
    // [SDK] 広告取得（view）
    UIView *adView = [[AMoAdNativeViewManager sharedManager]
                      viewWithSid:kSid
                      tag:kTag1
                      nibName:kNibName
                      onFailure:^(NSString *sid, NSString *tag, UIView *view) {
                      }];
    [adView setFrame:CGRectMake(0, 100, 320, 100)];
    [self.view addSubview:adView];

    // [SDK] 広告取得描画（既にあるViewに描画する）
    [[AMoAdNativeViewManager sharedManager] renderAdWithSid:kSid tag:kTag2 view:self.renderAdView onFailure:^(NSString *sid, NSString *tag, UIView *view) {
        NSLog(@"【%@】広告描画失敗！", [[NSBundle mainBundle] bundleIdentifier]);
    }];
}

- (IBAction)performUpdate:(id)sender
{
    // [SDK] 広告更新（updateAd）
    [[AMoAdNativeViewManager sharedManager] updateAdWithSid:kSid tag:kTag1];
    [[AMoAdNativeViewManager sharedManager] updateAdWithSid:kSid tag:kTag2];
}

- (IBAction)performClear:(id)sender
{
    // [SDK] 広告更新（updateAd）
    [[AMoAdNativeViewManager sharedManager] clearAdWithSid:kSid tag:kTag1];
    [[AMoAdNativeViewManager sharedManager] clearAdWithSid:kSid tag:kTag2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
