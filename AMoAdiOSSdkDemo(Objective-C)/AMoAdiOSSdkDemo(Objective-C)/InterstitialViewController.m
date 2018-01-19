//
//  InterstitialViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/02.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "InterstitialViewController.h"
#import "AMoAdInterstitial.h"

@implementation InterstitialViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self initAd];
}

- (void) initAd {
    [AMoAdInterstitial registerAdWithSid: self.sid];
    [AMoAdInterstitial loadAdWithSid:self.sid completion:^(NSString *sid, AMoAdResult result, NSError *err) {
        switch (result) {
            case AMoAdResultEmpty:
                //空の広告を受信した
                break;
            case AMoAdResultFailure:
                //広告の取得に失敗した
                break;
            case AMoAdResultSuccess:
                //正常に広告を受信した
                break;
        }
    }];
}

- (void) showAd {
    [AMoAdInterstitial showAdWithSid:self.sid completion:^(NSString *sid, AMoAdInterstitialResult result, NSError *err) {
        switch (result) {
        case AMoAdInterstitialResultClick:
            // 広告をクリックしたから広告を閉じる。
            break;
        case AMoAdInterstitialResultClose:
            // 閉じるボタンをクリックしたから広告を閉じる。
            break;
        case AMoAdInterstitialResultCloseFromApp:
            // アプリからcloseAdWithSid関数が呼ばれたから広告を閉じる
            break;
        case AMoAdInterstitialResultDuplicated:
            // 広告を表示関数(showAdWithSid)が連続で呼ばれたから広告を閉じる
            break;
        case AMoAdInterstitialResultFailure:
            // 広告の取得に失敗したから広告を閉じる
            break;
        }
    }];
}

- (IBAction)onShowBtnClicked:(id)sender {
    [self showAd];
}
@end
