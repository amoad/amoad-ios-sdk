//
//  ViewController.m
//  AMoAdWebViewSample
//
//  Created by AMoAd on 2015/12/09.
//  Copyright © 2015年 AMoAd. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdWeb.h"
#import "AMoAdLogger.h"

#define LOAD_FROM_URL 1     /* URLからロードする場合、1を指定する */
#define LOAD_FROM_FILE 0    /* ファイルからロードする場合、1を指定する */
#define LOAD_FROM_STRING 0  /* 文字列からロードする場合、1を指定する */

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [Logger] ログ出力設定
  [AMoAdLogger sharedLogger].logging = YES;
  [AMoAdLogger sharedLogger].trace = YES;

  // [SDK] AMoAdWebの利用を開始する（UIWebViewオブジェクトを作る前に呼んでおく）
  [AMoAdWeb prepareAd];

  // UIWebViewのデリゲートを設定する
  self.webView.delegate = self;

#if LOAD_FROM_URL

  // URLからロードする
  NSURL *requestURL = [NSURL URLWithString:@"https://example.com/"];  // TODO: URLを指定する
  NSURLRequest *req = [NSURLRequest requestWithURL:requestURL];
  [self.webView loadRequest:req];

#elif LOAD_FROM_FILE

  // ファイルからロードする
  NSString *requestPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];  // TODO: index.htmlの場合
  NSURL *requestURL = [NSURL URLWithString:requestPath];
  NSURLRequest *req = [NSURLRequest requestWithURL:requestURL];
  [self.webView loadRequest:req];

#elif LOAD_FROM_STRING

  // 文字列からロードする
  [self.webView loadHTMLString:@"<!DOCTYPE html> \
   <html lang='ja'> \
   <head> \
   <meta charset='utf-8'> \
   <meta name='viewport' content='width=device-width,initial-scale=1.0,user-scalable=no'> \
   <title>サンプルページ</title> \
   </head> \
   <body style='margin: 0; padding: 0'> \
   <p>↓ここにアドタグを貼ってください</p> \
   </body> \
   </html> \
   " baseURL:nil];  // TODO: HTMLを文字列で指定する

#endif
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  // [SDK] 広告クリックの時の処理を行う
  if (![AMoAdWeb webView:webView shouldStartLoadWithRequest:request navigationType:navigationType]) {
    return NO;
  }
  return YES;
}

@end
