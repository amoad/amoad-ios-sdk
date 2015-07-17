//
//  AMoAdNativePreRoll.h
//
//  Created by AMoAd on 2015/07/13.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AMoAdNativeView.h"
#import "AMoAdAnalytics.h"

@interface AMoAdNativePreRoll : NSObject

/// プリロール広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
+ (void)prepareAdWithSid:(NSString *)sid;

/// 既存のビューにプリロール広告をレンダリングする
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param view 広告を描画するビュー
/// @param delegate 広告デリゲート
+ (void)renderAdWithSid:(NSString *)sid tag:(NSString *)tag view:(UIView *)view analytics:(AMoAdAnalytics *)analytics completion:(void (^)(NSString *sid, NSString *tag, UIView *view, AMoAdNativeResult state))completion;

@end
