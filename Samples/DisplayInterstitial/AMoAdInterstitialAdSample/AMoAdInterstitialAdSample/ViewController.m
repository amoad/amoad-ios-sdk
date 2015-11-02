//
//  ViewController.m
//  AMoAdInterstitialAdSample
//
//  Created by AMoAd on 2015/08/13.
//  Copyright (c) 2015年 AMoAd. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdLogger.h"
#import "AMoAdInterstitial.h" // [SDK] インタースティシャル用ヘッダ

@interface ViewController ()

@end

static NSString *const kSid = @"管理画面から取得したsidを入力してください";

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDL] ロガーの設定（エラーログ）
  [AMoAdLogger sharedLogger].logging = YES; // YES...ログを出力する
  [AMoAdLogger sharedLogger].onLogging = ^(NSString *message, NSError *error) { // 出力方法をカスタマイズ（オプショナル）
    NSLog(@"【LOG: %@】%@: %@", [[NSBundle mainBundle] bundleIdentifier], message, error);
  };

  // [SDL] ロガーの設定（トレース）
  [AMoAdLogger sharedLogger].trace = YES; // YES...トレース出力ON
  [AMoAdLogger sharedLogger].onTrace =    // 出力方法をカスタマイズしたいときに設定する
  ^(NSString *message, NSObject *target) {
    NSLog(@"【TRACE: %@】%@: %@", [[NSBundle mainBundle] bundleIdentifier], message, target);
  };


  // [SDK] パネル画像を準備する（標準の画像で良い場合はnilを指定する）
  UIImage *panelImage = [UIImage imageNamed:@"user_panel.png"]; // パネル画像（310x380）

  // [SDK] その他、画像を設定する場合は担当営業までご連絡ください
  UIImage *linkButtonImage = nil;         // リンクボタン画像（280x50）
  UIImage *linkButtonHighlighted = nil;   // リンクボタン画像Highlight（280x50）
  UIImage *closeButtonImage = nil;        // 閉じるボタン画像（40x40）
  UIImage *closeButtonHighlighted = nil;  // 閉じるボタン画像Highlight（40x40）

  // [SDK] インタースティシャル広告の準備
  [AMoAdInterstitial prepareAdWithSid:kSid];

  // [SDK] 画像を設定する
  [AMoAdInterstitial setPanelWithSid:kSid image:panelImage];
  [AMoAdInterstitial setLinkButtonWithSid:kSid image:linkButtonImage highlighted:linkButtonHighlighted];
  [AMoAdInterstitial setCloseButtonWithSid:kSid image:closeButtonImage highlighted:closeButtonHighlighted];
}

- (IBAction)showAd:(id)sender {
  // [SDK] インタースティシャル広告を表示する
  [AMoAdInterstitial showAdWithSid:kSid completion:^(NSString *sid, AMoAdInterstitialResult result) {
    switch (result) {
      case AMoAdInterstitialResultClick:
        NSLog(@"リンクボタンがクリックされたので閉じました");
        break;
      case AMoAdInterstitialResultClose:
        NSLog(@"閉じるボタンがクリックされたので閉じました");
        break;
      case AMoAdInterstitialResultDuplicated:
        NSLog(@"既に開かれているので開きませんでした");
        break;
      case AMoAdInterstitialResultCloseFromApp:
        NSLog(@"アプリから閉じられました");
        break;
      case AMoAdInterstitialResultFailure:
        NSLog(@"広告の取得に失敗しました");
        break;
    }
  }];
}

@end
