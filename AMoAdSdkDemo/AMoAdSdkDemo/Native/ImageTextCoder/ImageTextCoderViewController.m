//
//  ImageTextCoderViewController.m
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2015/02/19.
//  Copyright (c) 2015年 AMoAd, Inc. All rights reserved.
//
#import "ImageTextCoderViewController.h"
#import <AMoAd/AMoAdNativeView.h>
#import <AMoAd/AMoAdLogger.h>

static NSString *const kSid = @"管理画面から取得したネイティブ（App）メイン画像＋テキストのsidを指定してください";
static NSString *const kTag1 = @"Ad01";
static NSString *const kTag2 = @"Ad02";
static NSString *const kNibName = @"AdImageTextView";

@interface ImageTextCoderViewController () <AMoAdNativeAppDelegate>
@property IBOutlet UIView *adView01;
@property IBOutlet UIView *adView02;
@end

@implementation ImageTextCoderViewController

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
  [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:kSid
                                            iconPreloading:YES
                                           imagePreloading:YES];
  // [SDK] 描画情報を生成する
  AMoAdNativeViewCoder *coder = [[AMoAdNativeViewCoder alloc] init];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setMinimumLineHeight:24.0];
  [paragraphStyle setMaximumLineHeight:24.0];
  coder.serviceNameAttributes = @{ NSForegroundColorAttributeName : [UIColor yellowColor],
                                   NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                   NSParagraphStyleAttributeName : paragraphStyle };
  [paragraphStyle setMinimumLineHeight:16.0];
  [paragraphStyle setMaximumLineHeight:16.0];
  coder.titleShortAttributes = @{ NSForegroundColorAttributeName : [UIColor blueColor],
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSParagraphStyleAttributeName : paragraphStyle };
  [paragraphStyle setMinimumLineHeight:14.0];
  [paragraphStyle setMaximumLineHeight:14.0];
  coder.titleLongAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                 NSParagraphStyleAttributeName : paragraphStyle };

  // [SDK] 広告取得描画（既にあるViewに描画する）
  [[AMoAdNativeViewManager sharedManager] renderAdWithSid:kSid tag:kTag1 view:self.adView01 coder:coder delegate:self];
  [[AMoAdNativeViewManager sharedManager] renderAdWithSid:kSid tag:kTag2 view:self.adView02 coder:coder delegate:self];
}

- (IBAction)performUpdate:(id)sender
{
  // [SDK] 広告更新（updateAd）
  [[AMoAdNativeViewManager sharedManager] updateAdWithSid:kSid tag:kTag1];
  [[AMoAdNativeViewManager sharedManager] updateAdWithSid:kSid tag:kTag2];
}

- (IBAction)performClear:(id)sender
{
  // [SDK] 広告クリア（clearAds）
  [[AMoAdNativeViewManager sharedManager] clearAdsWithSid:kSid];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)amoadNativeDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
  NSLog(@"amoadNativeDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeIconDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
  NSLog(@"amoadNativeIconDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeImageDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
  NSLog(@"amoadNativeImageDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeDidClick:(NSString *)sid tag:(NSString *)tag view:(UIView *)view {
  NSLog(@"amoadNativeDidClick:%@ tag:%@ view:%@", sid, tag, view);
}

@end
