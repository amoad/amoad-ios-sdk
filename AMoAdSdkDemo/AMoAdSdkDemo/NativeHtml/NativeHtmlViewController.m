//
//  NativeHtmlViewController.m
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2018/10/10.
//  Copyright © 2018年 AMoAd. All rights reserved.
//

#import "NativeHtmlViewController.h"
#import <AMoAd/AMoAdNative.h>   // [SDK] ネイティブHTML広告
#import <AMoAd/AMoAdLogger.h>   // [SDK] ロガー

@interface NativeHtmlViewController ()

@end

static NSString *const kSid = @"管理画面から発行されるSIDを設定してください";
static NSString *const kTag = @"Ad01";

@implementation NativeHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    // [SDK] ログ出力の設定
    [AMoAdLogger sharedLogger].logging = YES;
    
    // [SDK] トレース出力の設定
    [AMoAdLogger sharedLogger].trace = YES;
    
    // [SDK] 表示位置とサイズを指定する
    CGRect frame = CGRectMake(20, 160, 140, 120);
    
    // [SDK] 広告をロードする
    [AMoAdNative loadWithSid:kSid tag:kTag frame:frame completion:^(NSString *sid, NSString *tag, AMoAdResult result, NSDictionary *serverInfo) {
        switch (result) {
            case AMoAdResultSuccess:
                NSLog(@"広告取得成功（sid=%@, tag=%@, serverInfo=%@）", sid, tag, serverInfo);
                break;
            case AMoAdResultEmpty:
                NSLog(@"空広告を受信（sid=%@, tag=%@, serverInfo=%@）", sid, tag, serverInfo);
                break;
            case AMoAdResultFailure:
                NSLog(@"広告取得失敗（sid=%@, tag=%@, serverInfo=%@）", sid, tag, serverInfo);
                break;
        }
#if 1
    } option:@{ @"border" : @"dotted 2px #0000ff"}];  // DEBUG 枠線が表示されます
#else
    }];
#endif

    // [SDK] 広告Viewを取得してaddする
    [self.view addSubview:[AMoAdNative viewWithSid:kSid tag:kTag]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showAd:(id)sender {
    // [SDK] 広告を表示する
    [AMoAdNative showWithSid:kSid tag:kTag];
}

- (IBAction)hideAd:(id)sender {
    // [SDK] 広告を非表示にする
    [AMoAdNative hideWithSid:kSid tag:kTag];
}

- (IBAction)startRotation:(id)sender {
    // [SDK] ローテーションを開始する
    [AMoAdNative startRotationWithSid:kSid tag:kTag seconds:10]; // 9 - 60秒（範囲内に丸められます）
}

- (IBAction)stopRotation:(id)sender {
    // [SDK] ローテーションを停止する
    [AMoAdNative stopRotationWithSid:kSid tag:kTag];
}

- (IBAction)reloadAd:(id)sender {
    // [SDK] 広告をリロードする
    [AMoAdNative reloadWithSid:kSid tag:kTag];
}

@end
