//
//  AMoAdNative.h
//
//  Created by AMoAd on 2016/01/15.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AMoAd.h"

/// ネイティブHTML広告
@interface AMoAdNative : NSObject

/// 広告をロードする
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param frame 広告の表示位置・サイズ
/// @param completion 広告リクエスト結果を受け取るBlock
+ (void)loadWithSid:(NSString *)sid tag:(NSString *)tag frame:(CGRect)frame completion:(void (^)(NSString *sid, NSString *tag, AMoAdResult result, NSDictionary *serverInfo))completion;

/// 広告Viewを取得する（親ビューにaddしてください）
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (UIView *)viewWithSid:(NSString *)sid tag:(NSString *)tag;

/// 広告Viewを削除する（親ビューからのremoveは行いません）
/// 親ビューからremoveする方法：
/// [[AMoAdNative viewWithSid:kSid tag:kTag] removeFromSuperview]
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (void)disposeViewWithSid:(NSString *)sid tag:(NSString *)tag;

/// すべての広告Viewを削除する（親ビューからのremoveは行いません）
+ (void)disposeAllView;

/// 広告をリロード（別の広告に更新）する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (void)reloadWithSid:(NSString *)sid tag:(NSString *)tag;

/// 広告Viewを表示する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (void)showWithSid:(NSString *)sid tag:(NSString *)tag;

/// 広告Viewを非表示にする
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (void)hideWithSid:(NSString *)sid tag:(NSString *)tag;

/// ローテーションを開始する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param seconds ローテーション間隔（秒）
+ (void)startRotationWithSid:(NSString *)sid tag:(NSString *)tag seconds:(NSInteger)seconds;

/// ローテーションを終了する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
+ (void)stopRotationWithSid:(NSString *)sid tag:(NSString *)tag;

/// 開発用
+ (void)setHtmlUrlString:(NSString *)htmlUrlString;
+ (void)loadWithSid:(NSString *)sid tag:(NSString *)tag frame:(CGRect)frame completion:(void (^)(NSString *sid, NSString *tag, AMoAdResult result, NSDictionary *serverInfo))completion option:(NSDictionary *)option;
- (instancetype)init __attribute__((unavailable("This method is not available.")));
@end
