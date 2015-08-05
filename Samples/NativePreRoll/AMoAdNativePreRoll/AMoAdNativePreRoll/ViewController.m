//
//  ViewController.m
//  AMoAdNativePreRoll
//
//  Created by AMoAd on 2015/07/31.
//  Copyright (c) 2015年 AMoAd. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdNativePreRoll.h"
#import "AMoAdLogger.h"

static NSString *const kSid = @"管理画面から取得したプリロール広告のsidを指定してください";
static NSString *const kTag = @"UserPreRollAd";

@interface ViewController ()
@property (nonatomic,readwrite,strong) UIButton *userBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDK] 広告分析情報を生成する
  //   => ご利用の際は担当営業までお問い合わせください。利用しない場合は、nilを指定してください。
  NSString *report_id = @"ABCD";  // レポートを細分化するためのID
  NSString *value1 = @"ABCD";  // パブリッシャ様が任意に指定できる分析用パラメタ文字列
  NSString *value2 = @"ABCD";  // パブリッシャ様が任意に指定できる分析用パラメタ文字列
  NSString *value3 = @"ABCD";  // パブリッシャ様が任意に指定できる分析用パラメタ文字列

  AMoAdAnalytics *analytics = [[AMoAdAnalytics alloc] initWithReportId:report_id];
  analytics.publisherParam = @{@"key1":value1,@"key2":value2,@"key3":value3};

  // [SDK] 広告準備
  [AMoAdNativePreRoll prepareAdWithSid:kSid];

  self.view.hidden = YES; // 広告取得成功まで非表示にする（推奨）

  // [SDK] プリロール広告を描画する
  [AMoAdNativePreRoll renderAdWithSid:kSid tag:kTag view:self.view analytics:analytics completion:^(NSString *sid, NSString *tag, UIView *view, AMoAdResult state) {
    switch (state) {
      case AMoAdResultSuccess:
        self.view.hidden = NO;  // 広告取得成功後、表示する（推奨）
        NSLog(@"広告受信成功:sid=%@,tag=%@", sid, tag);
        break;
      case AMoAdResultFailure:
        NSLog(@"広告受信失敗:sid=%@,tag=%@", sid, tag);
        break;
      case AMoAdResultEmpty:
        NSLog(@"配信する広告が無い:sid=%@,tag=%@", sid, tag);
        break;
    };
  }];

  // 画面下から92pxまではパブリッシャ様固有のViewを追加することが可能です。
  self.userBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, 155, 34)];
  [self.userBtn setTitle:@"本編へ進む" forState:UIControlStateNormal];
  [self.userBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [self.userBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
  [self.view addSubview:self.userBtn];
}

// 回転対応：iOS 8.0未満のときのみ呼び出される（iOS 8.0以上では呼び出されない）
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  // [SDK] 再レイアウトする
  [AMoAdNativePreRoll layoutAdWithSid:kSid tag:kTag];

  // パブリッシャ様固有ビューを再レイアウトする
  dispatch_async(dispatch_get_main_queue(), ^{
    self.userBtn.frame = CGRectMake(0, self.view.bounds.size.height - 50, 155, 34);
  });
}

// 回転対応：iOS 8.0以上のときのみ呼び出される
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  // [SDK] 再レイアウトする
  [AMoAdNativePreRoll layoutAdWithSid:kSid tag:kTag];

  // パブリッシャ様固有ビューを再レイアウトする
  dispatch_async(dispatch_get_main_queue(), ^{
    self.userBtn.frame = CGRectMake(0, self.view.bounds.size.height - 50, 155, 34);
  });
}

@end
