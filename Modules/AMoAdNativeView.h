//
//  AMoAdNativeView.h
//
//  Created by AMoAd on 2014/11/25.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - 広告テンプレート

/// <p>広告テンプレートに指定するタグ番号</p>
/// 広告テンプレート（Xib）のAttributes Inspector -> View -> Tagに指定する番号。
/// この指定を行うことで、自動的に広告情報を埋めて表示する。
typedef NS_ENUM(NSInteger, AMoAdNativeView) {

  /// アイコン画像（UIImage）
  AMoAdNativeViewUIImageIcon = 1,

  /// メイン画像（UIImage）
  AMoAdNativeViewUIImageMain = 2,

  /// タイトルショート（UILabel）
  AMoAdNativeViewUILabelTitleShort = 3,

  /// タイトルロング（UILabel）
  AMoAdNativeViewUILabelTitleLong = 4,

  /// サービス名（UILabel）
  AMoAdNativeViewUILabelServiceName = 5
};

#pragma mark - 【リストビュー】広告表示アイテム

/// <p>【リストビュー】広告表示アイテム</p>
/// データソース配列（NSArray）に追加される。
@interface AMoAdNativeViewItem : NSObject

/// <p>【リストビュー】広告セルを取得する</p>
/// UITableViewDataSource#tableView:cellForRowAtIndexPath:メソッド内で、
/// データソース配列のindexPath番目がAMoAdNativeViewItem型だったら、このメソッドで広告セルを取得する。
/// <p>サンプルコード</p>
///    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
///    {
///      if ([self.ads[indexPath.row] isKindOfClass:[AMoAdNativeViewItem class]]) {
///        // 広告セル
///        AMoAdNativeViewItem *item = self.ads[indexPath.row];
///        return [item tableView:tableView cellForRowAtIndexPath:indexPath];
///      } else {
///        // コンテンツセル
///        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABCD" forIndexPath:indexPath];
///        // （コンテンツを設定...）
///        return cell;
///      }
///    }
/// @param tableView 対象テーブル
/// @param indexPath 表示位置
/// @return UITableViewCell * 広告セル
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/// <p>【リストビュー】広告セルを取得する</p>
/// UICollectionViewDataSource#collectionView:cellForRowAtIndexPath:メソッド内で、
/// データソース配列のindexPath番目がAMoAdNativeViewItem型だったら、このメソッドで広告セルを取得する。
/// <p>サンプルコード</p>
///    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForRowAtIndexPath:(NSIndexPath *)indexPath
///    {
///      if ([self.ads[indexPath.row] isKindOfClass:[AMoAdNativeViewItem class]]) {
///        // 広告セル
///        AMoAdNativeViewItem *item = self.ads[indexPath.row];
///        return [item collectionView:collectionView cellForRowAtIndexPath:indexPath];
///      } else {
///        // コンテンツセル
///        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithIdentifier:@"ABCD" forIndexPath:indexPath];
///        // （コンテンツを設定...）
///        return cell;
///      }
///    }
/// @param collectionView 対象コレクション
/// @param indexPath 表示位置
/// @return UICollectionViewCell * 広告セル
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

#pragma mark - ネイティブ広告マネージャ

/// ネイティブ広告マネージャ
@interface AMoAdNativeViewManager : NSObject

#pragma mark - マネージャの取得

/// ネイティブ広告マネージャの取得する
+ (AMoAdNativeViewManager *)sharedManager;

#pragma mark - 【ネイティブ（App）】広告の準備を行なう

/// 【ネイティブ（App）】1行テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag;

/// 【ネイティブ（App）】アイコン画像＋テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param iconPreloading YES...アイコン画像をすぐに先読みする<br />NO...アイコン画像をビュー取得時に読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag iconPreloading:(BOOL)iconPreloading;

/// 【ネイティブ（App）】メイン画像＋テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param iconPreloading YES...アイコン画像をすぐに先読みする<br />NO...アイコン画像をビュー取得時に読み込む
/// @param imagePreloading YES...メイン画像をすぐに先読みする<br />NO...メイン画像をビュー取得時に読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag iconPreloading:(BOOL)iconPreloading imagePreloading:(BOOL)imagePreloading;

#pragma mark - 【リストビュー】広告の準備を行なう

/// 【リストビュー】1行テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param defaultBeginIndex 広告の開始位置（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
/// @param defaultInterval 広告の表示間隔（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval;

/// 【リストビュー】アイコン画像＋テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param defaultBeginIndex 広告の開始位置（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
/// @param defaultInterval 広告の表示間隔（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
/// @param iconPreloading YES...アイコン画像をすぐに先読みする<br />NO...アイコン画像をビュー取得時に読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval iconPreloading:(BOOL)iconPreloading;

/// 【リストビュー】メイン画像＋テキスト広告の準備を行なう
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param defaultBeginIndex 広告の開始位置（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
/// @param defaultInterval 広告の表示間隔（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
/// @param iconPreloading YES...アイコン画像をすぐに先読みする<br />NO...アイコン画像をビュー取得時に読み込む
/// @param imagePreloading YES...メイン画像をすぐに先読みする<br />NO...メイン画像をビュー取得時に読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval iconPreloading:(BOOL)iconPreloading imagePreloading:(BOOL)imagePreloading;

#pragma mark - 【リストビュー】データソース配列を作成する

/// 【リストビュー】データソース配列に広告を挿入する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param originalArray コンテンツデータの配列
/// @param updateAd YES...既にoriginalArrayに入っている広告内容を更新する<br />広告の追加のみ（既に配列に入っている広告は更新されない）
/// @return NSArray * コンテンツデータの配列に広告を挿入した配列
- (NSArray *)arrayWithSid:(NSString *)sid tag:(NSString *)tag originalArray:(NSArray *)originalArray updateAd:(BOOL)updateAd;

#pragma mark - 【リストビュー】テーブル

/// 【リストビュー】テーブル（UITableView）に広告テンプレート（nibName）を登録する
/// @param tableView 広告セルを含んだテーブル型のリストを表示する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param nibName 広告セル用のリソース名
- (void)registerTableView:(UITableView *)tableView sid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName;

#pragma mark - 【リストビュー】コレクション

/// 【リストビュー】コレクション（UICollectionView）に広告テンプレート（nibName）を登録する
/// @param collectionView 広告セルを含んだコレクション型のリストを表示する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
/// @param nibName 広告セル用のリソース名
- (void)registerCollectionView:(UICollectionView *)collectionView sid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName;

#pragma mark - 【ネイティブ（App）】ビュー

/// 【ネイティブ（App）】広告ビューを取得する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param nibName 広告ビュー用のリソース名
/// @param onFailure 広告に失敗した時のコールバック関数
/// @return UIView * 広告ビュー
- (UIView *)viewWithSid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName onFailure:(void (^)(NSString *sid, NSString *tag, UIView *view))onFailure;

/// 【ネイティブ（App）】既存の広告ビューに広告をレンダリングする
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
/// @param UIView * 広告ビュー
/// @param onFailure 広告に失敗した時のコールバック関数
- (void)renderAdWithSid:(NSString *)sid tag:(NSString *)tag view:(UIView *)view onFailure:(void (^)(NSString *sid, NSString *tag, UIView *view))onFailure;

/// 【ネイティブ（App）】広告ビューの内容を更新する
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
- (void)updateAdWithSid:(NSString *)sid tag:(NSString *)tag;

/// 【ネイティブ（App）】広告ビューの内容をクリアする
/// @param sid 管理画面から取得した64文字の英数字
/// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
- (void)clearAdWithSid:(NSString *)sid tag:(NSString *)tag;

@end
