//
//  DisplayInterstitialViewController.m
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2016/05/10.
//
//
#import "DisplayInterstitialViewController.h"
#import <AMoAd/AMoAdLogger.h>
#import <AMoAd/AMoAdInterstitial.h>

@interface DisplayInterstitialViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *autoReloadSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *logSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *traceSwitch;
@property (weak, nonatomic) IBOutlet UITextView *consoleTextView;
@end

// [SDK] 管理画面から取得したsidを入力してください
static NSString *const kSid = @"62056d310111552c000000000000000000000000000000000000000000000000";

@implementation DisplayInterstitialViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDK] ロガーの設定
  [AMoAdLogger sharedLogger].trace = self.traceSwitch.on;
  [AMoAdLogger sharedLogger].logging = self.logSwitch.on;

#if 0 // Optional
  [AMoAdLogger sharedLogger].onTrace = ^(NSString *message, id target) {
    if (target) {
      self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"%@(target=%@)\n", message, target];
    } else {
      self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"%@\n", message];
    }
    [self scrollToBottom];
  };
  [AMoAdLogger sharedLogger].onLogging = ^(NSString *message, NSError *error) {
    if (error) {
      self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"%@(error=%@)\n", message, error];
    } else {
      self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"%@\n", message];
    }
    [self scrollToBottom];
  };
#endif

  // [SDK] インタースティシャル広告の登録を行なう
  [AMoAdInterstitial registerAdWithSid:kSid];

  // [SDK] showAdを呼んだ後、自動で次の広告をロード（loadAd）するかどうか：デフォルトはYES
  [AMoAdInterstitial setAutoReloadWithSid:kSid autoReload:self.autoReloadSwitch.on];

  // [SDK] 画像をカスタマイズする
  [self customizeImage];
}

- (IBAction)onAutoReloadSwich:(id)sender {
  // [SDK] showAdを呼んだ後、自動で次の広告をロード（loadAd）するかどうか：デフォルトはYES
  [AMoAdInterstitial setAutoReloadWithSid:kSid autoReload:self.autoReloadSwitch.on];
}

- (IBAction)onLoadAdButton:(id)sender {
  // [SDK] インタースティシャル広告のロードを行なう
  [AMoAdInterstitial loadAdWithSid:kSid completion:^(NSString *sid, AMoAdResult result, NSError *err) {
    switch (result) {
      case AMoAdResultSuccess:
        NSLog(@"広告ロード成功");
        break;

      case AMoAdResultFailure:
        NSLog(@"広告ロード失敗");
        break;

      case AMoAdResultEmpty:
        NSLog(@"配信する広告がない");
        break;
    }
  }];
}

- (IBAction)onShowAdButton:(id)sender {
  [self showAd];
}

- (IBAction)onLogSwich:(id)sender {
  [AMoAdLogger sharedLogger].logging = self.logSwitch.on;
}

- (IBAction)onTraceSwitch:(id)sender {
  [AMoAdLogger sharedLogger].trace = self.traceSwitch.on;
}

- (IBAction)onClearButton:(id)sender {
  self.consoleTextView.text = @"";
}

- (void)showAd {
  // [SDK] インタースティシャル広告を表示する
  [AMoAdInterstitial showAdWithSid:kSid completion:^(NSString *sid, AMoAdInterstitialResult result, NSError *err) {
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
        NSLog(@"広告の取得に失敗しました（error=%@）", err);
        break;
    }
  }];
}

- (void)customizeImage {
  // カスタマイズする画像を準備する（標準の画像で良い場合はnilを指定する）
  UIImage *portraitPanelImage = [UIImage imageNamed:@"user_panel.png"]; // Portraitパネル画像（310x380）
  UIImage *landscapePanelImage = [UIImage imageNamed:@"user_panel_l.png"];     // Landscapeパネル画像（380x310）
  UIImage *linkButtonImage = [UIImage imageNamed:@"user_link_btn.png"];         // リンクボタン画像（280x50）
  UIImage *linkButtonHighlighted = [UIImage imageNamed:@"user_link_btn_h.png"];   // リンクボタン画像Highlight（280x50）
  UIImage *closeButtonImage = [UIImage imageNamed:@"user_close_btn.png"];        // 閉じるボタン画像（40x40）
  UIImage *closeButtonHighlighted = [UIImage imageNamed:@"user_close_btn_h.png"];  // 閉じるボタン画像Highlight（40x40）

  // [SDK] 画像を設定する
  [AMoAdInterstitial setPortraitPanelWithSid:kSid image:portraitPanelImage];
  [AMoAdInterstitial setLandscapePanelWithSid:kSid image:landscapePanelImage];
  [AMoAdInterstitial setLinkButtonWithSid:kSid image:linkButtonImage highlighted:linkButtonHighlighted];
  [AMoAdInterstitial setCloseButtonWithSid:kSid image:closeButtonImage highlighted:closeButtonHighlighted];
}

- (void)scrollToBottom {
  self.consoleTextView.scrollEnabled = YES;

  CGFloat scrollY =
  self.consoleTextView.contentSize.height +
  self.consoleTextView.font.pointSize -
  self.consoleTextView.bounds.size.height;
  CGPoint scrollPoint;

  if (scrollY < 0) {
    scrollY = 0;
  }
  scrollPoint = CGPointMake(0.0, scrollY);

  [self.consoleTextView setContentOffset:scrollPoint animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
