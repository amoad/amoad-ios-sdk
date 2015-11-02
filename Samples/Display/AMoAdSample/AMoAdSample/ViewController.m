//
//  ViewController.m
//  AMoAdSample
//
//  Created by AMoAd on 2015/08/05.
//  Copyright (c) 2015年 AMoAd. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdLogger.h"

@interface ViewController ()

@end

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
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
