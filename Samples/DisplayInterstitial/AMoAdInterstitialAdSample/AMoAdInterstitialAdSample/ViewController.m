//
//  ViewController.m
//  AMoAdInterstitialAdSample
//
//  Created by AMoAd on 2016/04/25.
//  Copyright (c) 2016年 AMoAd. All rights reserved.
//

#import "ViewController.h"
#import "AMoAdInterstitial.h" // [SDK] インタースティシャル用ヘッダ
#import "AMoAdLogger.h"   // [SDK] ロガー

@interface ViewController ()

@end

// [SDK] 管理画面から取得したsidを入力してください
static NSString *const kSid = @"62056d310111552c000000000000000000000000000000000000000000000000";

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDK] ログ出力の設定
  [AMoAdLogger sharedLogger].logging = YES;

  // [SDK] トレース出力の設定
  [AMoAdLogger sharedLogger].trace = YES;
  
  // [SDK] カスタマイズする画像を準備する（標準の画像で良い場合はnilを指定する）
  UIImage *portraitPanelImage = [UIImage imageNamed:@"user_panel.png"]; // Portraitパネル画像（310x380）
  UIImage *landscapePanelImage = nil;     // Landscapeパネル画像（380x310）
  UIImage *linkButtonImage = nil;         // リンクボタン画像（280x50）
  UIImage *linkButtonHighlighted = nil;   // リンクボタン画像Highlight（280x50）
  UIImage *closeButtonImage = nil;        // 閉じるボタン画像（40x40）
  UIImage *closeButtonHighlighted = nil;  // 閉じるボタン画像Highlight（40x40）

  // [SDK] インタースティシャル広告の準備
  [AMoAdInterstitial registerAdWithSid:kSid];

  // [SDK] 画像を設定する
  [AMoAdInterstitial setPortraitPanelWithSid:kSid image:portraitPanelImage];
  [AMoAdInterstitial setLandscapePanelWithSid:kSid image:landscapePanelImage];
  [AMoAdInterstitial setLinkButtonWithSid:kSid image:linkButtonImage highlighted:linkButtonHighlighted];
  [AMoAdInterstitial setCloseButtonWithSid:kSid image:closeButtonImage highlighted:closeButtonHighlighted];

  // [SDK] 動作を設定する（iOS 7以下では必ず clickable:NO / shown:NO となります）
//  [AMoAdInterstitial setDisplayWithSid:kSid clickable:NO];  // 広告面をクリックできるかどうかを設定する：デフォルトはYES
//  [AMoAdInterstitial setDialogWithSid:kSid shown:NO]; // 確認ダイアログを表示するかどうかを設定する：デフォルトはYES
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
