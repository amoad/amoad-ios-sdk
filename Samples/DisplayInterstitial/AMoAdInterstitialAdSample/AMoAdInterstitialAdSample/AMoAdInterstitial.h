//
//  AMoAdInterstitial.h
//
//  Created by AMoAd on 2015/07/23.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// インタースティシャル広告完了状態
typedef NS_ENUM(NSInteger, AMoAdInterstitialResult) {
  /// クリックされた
  AMoAdInterstitialResultClick,
  /// 閉じるボタンが押された
  AMoAdInterstitialResultClose,
  /// インタースティシャル広告が表示中（重複して開かない）
  AMoAdInterstitialResultDuplicated,
  /// アプリから閉じられた
  AMoAdInterstitialResultCloseFromApp,
  /// 受信に失敗した
  AMoAdInterstitialResultFailure
};


/// インタースティシャル広告I/F
@interface AMoAdInterstitial : NSObject

/// インタースティシャル広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
+ (void)prepareAdWithSid:(NSString *)sid;

// タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
+ (void)setNetworkTimeoutWithSid:(NSString *)sid millis:(NSInteger)millis;

/// パネル画像（310x380で表示される）を設定する
/// @param sid 管理画面から取得した64文字の英数字
/// @param image パネル画像
+ (void)setPanelWithSid:(NSString *)sid image:(UIImage *)image;

/// リンクボタン画像（280x50で表示される）を設定する
/// @param sid 管理画面から取得した64文字の英数字
/// @param image リンクボタン画像
/// @param highlighted リンクボタン画像（押下時）
+ (void)setLinkButtonWithSid:(NSString *)sid image:(UIImage *)image highlighted:(UIImage *)highlighted;

/// 閉じるボタン画像（40x40で表示される）を設定する
/// @param sid 管理画面から取得した64文字の英数字
/// @param image 閉じるボタン画像
/// @param highlighted 閉じるボタン画像（押下時）
+ (void)setCloseButtonWithSid:(NSString *)sid image:(UIImage *)image highlighted:(UIImage *)highlighted;

/// インタースティシャル広告を表示する
/// @param sid 管理画面から取得した64文字の英数字
/// @param completion 広告受信完了Block
+ (void)showAdWithSid:(NSString *)sid completion:(void (^)(NSString *sid, AMoAdInterstitialResult result))completion;

/// インタースティシャル広告を閉じる
/// @param sid 管理画面から取得した64文字の英数字
+ (void)closeAdWithSid:(NSString *)sid;

@end
