//
//  AMoAdView.h (ARC)
//  AMoAd
//
#import <UIKit/UIKit.h>
@class AMoAdView;

/// ローテーション時トランジション
typedef enum {
  /// トランジション「なし」
  AMoAdRotateTransitionNone = UIViewAnimationTransitionNone,
  /// トランジション「左フリップ」
  AMoAdRotateTransitionFlipFromLeft = UIViewAnimationTransitionFlipFromLeft,
  /// トランジション「右フリップ」
  AMoAdRotateTransitionFlipFromRight = UIViewAnimationTransitionFlipFromRight,
  /// トランジション「巻き上げ」
  AMoAdRotateTransitionCurlUp = UIViewAnimationTransitionCurlUp,
  /// トランジション「巻き下げ」
  AMoAdRotateTransitionCurlDown = UIViewAnimationTransitionCurlDown,
} AMoAdRotateTransition;

/// クリック時トランジション
typedef enum {
  /// トランジション「なし」
  AMoAdClickTransitionNone,
  /// トランジション「ジャンプ」
  AMoAdClickTransitionJump,
} AMoAdClickTransition;


/// AMoAdViewデリゲートプロトコル
@protocol AMoAdViewDelegate
@optional
/// 正常に広告を受信した
- (void)AMoAdViewDidReceiveAd:(AMoAdView *)amoadView;
/// 広告の取得に失敗した
- (void)AMoAdViewDidFailToReceiveAd:(AMoAdView *)amoadView error:(NSError *)error;
/// 空の広告を受信した
- (void)AMoAdViewDidReceiveEmptyAd:(AMoAdView *)amoadView;
/// 広告がクリックされた
- (void)AMoAdViewDidClick:(AMoAdView *)amoadView;
/// 広告がクリックされた後、戻ってくる
- (void)AMoAdViewWillClickBack:(AMoAdView *)amoadView;
/// 広告がクリックされた後、戻ってきた
- (void)AMoAdViewDidClickBack:(AMoAdView *)amoadView;

// 使用されていないメソッド（互換性のために残している）
- (void)AMoAdView:(AMoAdView *)amoadView didFailToReceiveAdWithError:(NSError *)error DEPRECATED_ATTRIBUTE;
@end


/// 広告を表示するViewクラス
@interface AMoAdView : UIImageView

/// AMoAd Webサイトで発行されるID（必須）
@property (nonatomic, strong) NSString *sid;

/// デリゲート
@property (nonatomic, weak) id delegate;

/// ローテーション時のアニメーション
@property (nonatomic, assign) AMoAdRotateTransition rotateTransition;

/// クリック時のアニメーション
@property (nonatomic, assign) AMoAdClickTransition clickTransition;

/// 位置とサイズで初期化
- (id)initWithFrame:(CGRect)frame;

/// 初期表示画像で初期化
- (id)initWithImage:(UIImage *)image;

/// 初期表示画像で初期化（ハイライト指定）
- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

// 使用されていないメソッド（互換性のために残している）
typedef enum {
  AMoAdViewAnimationTransitionNone DEPRECATED_ATTRIBUTE = UIViewAnimationTransitionNone,
  AMoAdViewAnimationTransitionFlipFromLeft DEPRECATED_ATTRIBUTE = UIViewAnimationTransitionFlipFromLeft,
  AMoAdViewAnimationTransitionFlipFromRight DEPRECATED_ATTRIBUTE = UIViewAnimationTransitionFlipFromRight,
  AMoAdViewAnimationTransitionCurlUp DEPRECATED_ATTRIBUTE = UIViewAnimationTransitionCurlUp,
  AMoAdViewAnimationTransitionCurlDown DEPRECATED_ATTRIBUTE = UIViewAnimationTransitionCurlDown,
} AMoAdViewAnimationTransition DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) AMoAdViewAnimationTransition rotationAnimationTransition DEPRECATED_ATTRIBUTE;
typedef enum {
  AMoAdViewClickAnimationTransitionNone DEPRECATED_ATTRIBUTE,
  AMoAdViewClickAnimationTransitionJump DEPRECATED_ATTRIBUTE,
} AMoAdViewClickAnimationTransition DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) AMoAdViewClickAnimationTransition clickAnimationTransition DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) BOOL enableModal DEPRECATED_ATTRIBUTE;
@property (nonatomic, weak) id rootController DEPRECATED_ATTRIBUTE;
typedef enum {
  AMoAdContentSizeIdentifierPortrait DEPRECATED_ATTRIBUTE = 1,
  AMoAdContentSizeIdentifierLandscape DEPRECATED_ATTRIBUTE = 2,
} AMoAdContentSizeIdentifier DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) AMoAdContentSizeIdentifier currentContentSizeIdentifier DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) BOOL enableRotation DEPRECATED_ATTRIBUTE;
- (void)displayAd DEPRECATED_ATTRIBUTE;
- (void)startRotation DEPRECATED_ATTRIBUTE;
- (void)stopRotation DEPRECATED_ATTRIBUTE;

/// サポート外のメソッド
- (id)init __attribute__((unavailable("This method is not available.")));
/// サポート外のメソッド
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((availability(ios,unavailable,message="This method is not available.")));

@end
