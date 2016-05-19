//
//  AMoAdCocos2dxModule.h
//
//  v1.0.1
//
//  Created by AMoAd on 2015/07/15.
//
#ifndef __AMoAdCocos2dxModule__
#define __AMoAdCocos2dxModule__

#include "cocos2d.h"

/// Cocos2d-xにAMoAdを表示するクラス
/// すべてクラスメソッドなのでインスタンスを生成する必要はありません。
/// 管理画面より発行されるsidで広告を判別します。
/// 同じsidの広告を1つの画面に表示することはできません。
class AMoAdCocos2dxModule {
private:
  /// インスタンスを生成する必要はありません
  AMoAdCocos2dxModule();
public:
  /// モジュールバージョン
  static constexpr char const* VersionNo = "1.3.0";

  /// 広告サイズ
  enum struct AdSize : int {
    B320x50 = 0,
    B320x100 = 1,
    R300x250 = 2,
    B728x90 = 3,
    R300x100 = 4,
  };

  /// 水平方向の広告表示位置
  enum struct HorizontalAlign : int {
    None = 0,
    Left = 1,
    Center = 2,
    Right = 3,
  };

  /// 垂直方向の広告表示位置
  enum struct VerticalAlign : int {
    None = 0,
    Top = 1,
    Middle = 2,
    Bottom = 3,
  };

  /// 広告サイズの調整
  enum struct AdjustMode : int {
    Fixed = 0,
    Responsive = 1,
  };

  /// ローテーション時トランジションアニメーション（iOS/Androidで異なります）
  enum struct RotateTransition : int {
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    None = 0,
    FlipFromLeft = 1,
    FlipFromRight = 2,
    CurlUp = 3,
    CurlDown = 4,
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    None = 0,
    Alpha = 1,
    Rotate = 2,
    Scale = 3,
    Translate = 4,
#endif
  };

  /// クリック時トランジション（iOS/Androidで異なります）
  enum struct ClickTransition : int {
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    None = 0,
    Jump = 1,
#elif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID
    None = 0,
    Jump = 1,
#endif
  };

  /// インライン広告を登録する
  /// @param sid 管理画面より取得したID
  /// @param adSize 広告サイズ
  /// @param hAlign 水平方向の広告表示位置
  /// @param vAlign 垂直方向の広告表示位置
  /// @param adjustMode 広告サイズの調整
  /// @param x x座標（hAlignがNoneのときのみ有効）
  /// @param y y座標（vAlignがNoneのときのみ有効）
  /// @param timeoutMillis タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
  static void registerInlineAd(const char* sid,
                               AMoAdCocos2dxModule::AdSize adSize,
                               AMoAdCocos2dxModule::HorizontalAlign hAlign,
                               AMoAdCocos2dxModule::VerticalAlign vAlign,
                               AMoAdCocos2dxModule::AdjustMode adjustMode,
                               int x = 0,
                               int y = 0,
                               int timeoutMillis = 30*1000);

  /// デフォルト画像をファイル名で指定する
  /// @param sid 管理画面より取得したID
  /// @param imageName デフォルト画像のファイル名
  static void setDefaultImageName(const char* sid, const char* imageName);

  /// ローテーション時トランジションアニメーションを設定する
  /// @param sid 管理画面より取得したID
  /// @param rotateTrans ローテーション時トランジションアニメーション（iOS/Androidで異なります）
  static void setRotateTransition(const char* sid, AMoAdCocos2dxModule::RotateTransition rotateTrans);

  /// クリック時トランジションアニメーションを設定する
  /// @param sid 管理画面より取得したID
  /// @param clickTrans クリック時トランジションアニメーション（iOS/Androidで異なります）
  static void setClickTransition(const char* sid, AMoAdCocos2dxModule::ClickTransition clickTrans);

  /// 広告を表示する
  /// @param sid 管理画面より取得したID
  static void show(const char* sid);

  /// 広告を消す（showで再表示する）
  /// @param sid 管理画面より取得したID
  static void hide(const char* sid);

  /// 広告Viewを破棄する（再表示するにはregisterから行う必要がある）
  /// @param sid 管理画面より取得したID
  static void dispose(const char* sid);


  /// 全画面広告を登録する
  /// @param sid 管理画面より取得したID
  /// @param timeoutMillis タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
  static void registerInterstitialAd(const char *sid, int timeoutMillis = 30*1000);


  /// 広告面をクリックできるかどうかを設定する：デフォルトはYES
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param clickable 広告面をクリックできるかどうか
  static void setInterstitialDisplayClickable(const char *sid, bool clickable);

  /// 確認ダイアログを表示するかどうかを設定する：デフォルトはYES
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param shown 確認ダイアログを表示するかどうか
  static void setInterstitialDialogShown(const char *sid, bool shown);


  /// 全画面広告のPortraitパネル画像を設定する
  /// @param sid 管理画面より取得したID
  /// @param imageName Portraitパネル画像のファイル名
  static void setInterstitialPortraitPanel(const char *sid, const char *imageName);

  /// 全画面広告のLandscapeパネル画像を設定する
  /// @param sid 管理画面より取得したID
  /// @param imageName Landscapeパネル画像のファイル名
  static void setInterstitialLandscapePanel(const char *sid, const char *imageName);


  /// 全画面広告のリンクボタン画像を設定する
  /// @param sid 管理画面より取得したID
  /// @param imageName リンクボタン画像のファイル名
  /// @param highlighted 押下時のリンクボタン画像のファイル名
  static void setInterstitialLinkButton(const char *sid, const char *imageName, const char *highlighted);

  /// 全画面広告の閉じるボタン画像を設定する
  /// @param sid 管理画面より取得したID
  /// @param imageName 閉じるボタン画像のファイル名
  /// @param highlighted 押下時の閉じるボタン画像のファイル名
  static void setInterstitialCloseButton(const char *sid, const char *imageName, const char *highlighted);

  /// 全画面広告を表示する
  /// @param sid 管理画面より取得したID
  static void showInterstitialAd(const char *sid);

  /// 全画面広告を閉じる
  /// @param sid 管理画面より取得したID
  static void closeInterstitialAd(const char *sid);

  /// 自動リロードフラグを設定する
  /// @param sid 管理画面より取得したID
  /// @param autoReload 自動リロードフラグ
  static void setInterstitialAutoReload(const char *sid, bool autoReload);

  /// 全画面広告をロードする
  /// @param sid 管理画面より取得したID
  static void loadInterstitialAd(const char *sid);

  /// 全画面広告がロードされているかどうかを判定する
  /// @param sid 管理画面より取得したID
  /// @return 全画面広告がロードされているかどうか
  static bool isLoadedInterstitialAd(const char *sid);
};

#endif  // __AMoAdCocos2dxModule__
