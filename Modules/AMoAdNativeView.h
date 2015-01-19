//
//  AMoAdNativeView.h
//
//  Created by AMoAd on 2014/11/25.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 広告情報<br />
/// 広告用View（ViewCell）に表示する広告の情報が入ったクラス。
@class AMoAdNativeInfo;

#pragma mark - native view tag

/// 広告用セルの指定するタグ<br />
/// Interface Builder上で、広告用View（ViewCell）の
/// Attributes Inspector -> View -> Tagに、下記のタグ番号を指定する。
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

#pragma mark - native view item

/// 広告表示項目<br />
/// リストビュー型（UITableView / UICollectionViewCell）の広告を表示するため、
/// データソースの元となる配列（NSArray）に追加される。<br />
///
/// テーブルの場合、UITableViewDataSource#tableView:cellForRowAtIndexPath:内で判定し
/// AMoAdNativeViewItemクラスのインスタンスであれば、
/// tableView:cellForRowAtIndexPath:を呼び出して戻り値をreturnする。<br />
///
/// コレクションの場合、UICollectionViewDataSource#collectionView:cellForItemAtIndexPath:から、
/// collectionView:cellForItemAtIndexPath:を呼び出して戻り値をreturnする。
@interface AMoAdNativeViewItem : NSObject

/// indexPathで指定した広告セル（UITableViewCell）を取得する
/// @param tableView 表示するテーブルビュー
/// @param indexPath 表示位置
/// @return UITableViewCell * 広告セル
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/// indexPathで指定した広告セル（UICollectionViewCell）を取得する
/// @param collectionView 表示するコレクションビュー
/// @param indexPath 表示位置
/// @return UITableViewCell * 広告セル
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

#pragma mark - native view manager

/// 広告表示管理体<br />
/// 管理画面から取得するsidと任意に決めたtagを指定して、
/// 広告の準備、配列（NSArray）への広告表示項目追加、リストビューへのXib登録、
/// 1−View型の場合のView取得／更新などを行う。<br />
/// tagは同じsidの広告を複数の場所に表示するために指定する任意の文字列である。
@interface AMoAdNativeViewManager : NSObject
+ (AMoAdNativeViewManager *)sharedManager;

#pragma mark - prepare Ad
#pragma mark nativeApp Type

/// 広告準備（表示方式: ネイティブ(App) 表示広告種類: 1行テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag;

/// 広告準備（表示方式: ネイティブ(App) 表示広告種類: アイコン画像+テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param iconPreloading 自動的にアイコンを読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag iconPreloading:(BOOL)iconPreloading;

/// 広告準備（表示方式: ネイティブ(App) 表示広告種類: メイン画像+テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param iconPreloading 自動的にアイコンを読み込む
/// @param imagePreloading 自動的にメイン画像を読み込む
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag iconPreloading:(BOOL)iconPreloading imagePreloading:(BOOL)imagePreloading;

#pragma mark listView Type

/// 広告準備（表示方式: リストビュー 表示広告種類: 1行テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param defaultBeginIndex 広告の開始位置(初回、サーバから取得するまでのデフォルト値)
/// @param defaultInterval 広告の表示間隔(初回、サーバから取得するまでのデフォルト値)
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval;

/// 広告準備（表示方式: リストビュー 表示広告種類: アイコン画像+テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param iconPreloading 自動的にアイコンを読み込む
/// @param defaultBeginIndex 広告の開始位置(初回、サーバから取得するまでのデフォルト値)
/// @param defaultInterval 広告の表示間隔(初回、サーバから取得するまでのデフォルト値)
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval iconPreloading:(BOOL)iconPreloading;

/// 広告準備（表示方式: リストビュー 表示広告種類: メイン画像+テキスト）
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param iconPreloading 自動的にアイコンを読み込む
/// @param imagePreloading 自動的にメイン画像を読み込む
/// @param defaultBeginIndex 広告の開始位置(初回、サーバから取得するまでのデフォルト値)
/// @param defaultInterval 広告の表示間隔(初回、サーバから取得するまでのデフォルト値)
- (void)prepareAdWithSid:(NSString *)sid tag:(NSString *)tag defaultBeginIndex:(NSInteger)defaultBeginIndex defaultInterval:(NSInteger)defaultInterval iconPreloading:(BOOL)iconPreloading imagePreloading:(BOOL)imagePreloading;

#pragma mark - data source array

/// データソースの配列に広告を挿入する
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param originalArray ユーザー自身のデータソース元となるNSArray
/// @param updateAd 広告を更新する
- (NSArray *)arrayWithSid:(NSString *)sid tag:(NSString *)tag originalArray:(NSArray *)originalArray updateAd:(BOOL)updateAd;

#pragma mark - table view

/// sid(およびtag)ごとにUITableViewとnibNameを管理およびテーブルに広告用セルを登録する
/// @param tableView 広告セルを含んだテーブル型のリストを表示する
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param nibName 広告セル用のリソース名
- (void)registerTableView:(UITableView *)tableView sid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName;

#pragma mark - collection view

/// sid(およびtag)ごとにUITableViewとnibNameを管理およびテーブルに広告用セルを登録する
/// @param collectionView 広告セルを含んだコレクション型のリストを表示する
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のtable（画面）で使用する場合、一意に管理する為に使用する
/// @param nibName 広告セル用のリソース名
- (void)registerCollectionView:(UICollectionView *)collectionView sid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName;

#pragma mark - view

/// sid(およびtag)で指定された広告ビューを取得する
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のビューで使用する場合、一意に管理する為に使用する
/// @param nibName 広告ビュー用のリソース名
/// @return UIView * 広告ビュー
- (UIView *)viewWithSid:(NSString *)sid tag:(NSString *)tag nibName:(NSString *)nibName;

/// sid(およびtag)で指定された広告ビューの内容を更新する
/// @param sid 管理画面から取得したID
/// @param tag 同じsidを複数のビューで使用する場合、一意に管理する為に使用する
/// @return UIView * 広告ビュー
- (void)updateAdWithSid:(NSString *)sid tag:(NSString *)tag;

@end
