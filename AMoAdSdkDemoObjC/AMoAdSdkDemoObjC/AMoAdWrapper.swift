//
//  AMoAdWrapper.swift
//  SampleApp
//
//  Copyright © 2019 AMoAd. All rights reserved.
//

import Foundation
import UIKit
import AMoAd

// MARK:- Enums

///// 広告サイズ
@objc public enum AMoAdBannerSizeW : Int {
  case B320x50
  case B320x100
  case B300x250
  case B728x90
  case B300x100
  
  fileprivate var convert: AMoAdBannerSize {
    switch self {
      case .B320x50:
        return .B320x50
      case .B320x100:
        return .B320x100
      case .B300x250:
        return .B300x250
      case .B728x90:
        return .B728x90
      case .B300x100:
        return .B300x100
    }
  }
}

///// 広告サイズの調整
@objc public enum AMoAdAdjustModeW : Int {
  case fixed
  case responsive
  
  fileprivate var convert: AMoAdAdjustMode {
    switch self {
      case .fixed:
        return .fixed
      case .responsive:
        return .responsive
    }
  }
  
  fileprivate static func convert(_ value: AMoAdAdjustMode) -> AMoAdAdjustModeW {
    switch value {
      case .fixed:
        return .fixed
      case .responsive:
        return .responsive
    }
  }
}

/// クリック時トランジション
@objc public enum AMoAdClickTransitionW : Int {
  
  /// トランジション「なし」
  case none
  /// トランジション「ジャンプ」
  case jump
  
  fileprivate var convert: AMoAdClickTransition {
    switch self {
      case .none:
        return .none
      case .jump:
        return .jump
    }
  }
  
  fileprivate static func convert(_ value: AMoAdClickTransition) -> AMoAdClickTransitionW {
    switch value {
      case .none:
        return .none
      case .jump:
        return .jump
    }
  }
}

/// 水平方向の広告表示位置
@objc public enum AMoAdHorizontalAlignW : Int {
  case none
  case left
  case center
  case right
  
  fileprivate var convert: AMoAdHorizontalAlign {
    switch self {
      case .none:
        return .none
      case .left:
        return .left
      case .center:
        return .center
      case .right:
        return .right
    }
  }
  
  fileprivate static func convert(_ value: AMoAdHorizontalAlign) -> AMoAdHorizontalAlignW {
    switch value {
      case .none:
        return .none
      case .left:
        return .left
      case .center:
        return .center
      case .right:
        return .right
    }
  }
}

/// 垂直方向の広告表示位置
@objc public enum AMoAdVerticalAlignW : Int {
  case none
  case top
  case middle
  case bottom
  
  fileprivate var convert: AMoAdVerticalAlign {
    switch self {
      case .none:
        return .none
      case .top:
        return .top
      case .middle:
        return .middle
      case .bottom:
        return .bottom
    }
  }
  
  fileprivate static func convert(_ value: AMoAdVerticalAlign) -> AMoAdVerticalAlignW {
    switch value {
      case .none:
        return .none
      case .top:
        return .top
      case .middle:
        return .middle
      case .bottom:
        return .bottom
    }
  }
}

/// 広告受信結果
@objc public enum AMoAdResultW : Int {
  /// 成功
  case success
  /// 失敗
  case failure
  /// 配信する広告が無い
  case empty
  
  fileprivate static func convert(_ value: AMoAdResult) -> AMoAdResultW {
    switch value {
      case .success:
        return .success
      case .failure:
        return .failure
      case .empty:
        return .empty
    }
  }
}

@objc public enum AMoAdInterstitialResultW : Int {
  /// クリックされた
  case click
  /// 閉じるボタンが押された
  case close
  /// インタースティシャル広告が表示中（重複して開かない）
  case duplicated
  /// アプリから閉じられた
  case closeFromApp
  /// 受信に失敗した
  case failure
  
  fileprivate static func convert(_ value: AMoAdInterstitialResult) -> AMoAdInterstitialResultW {
    switch value {
      case .click:
        return .click
      case .close:
        return .close
      case .duplicated:
        return .duplicated
      case .closeFromApp:
        return .closeFromApp
      case .failure:
        return .failure
    }
  }
}

// MARK: - ディスプレイ広告
/// 広告を表示するViewクラス
@objc public class AMoAdViewW : UIView {
  fileprivate var amoadView: AMoAdView
  
  /// AMoAd Webサイトで発行されるID（必須）
  @objc public var sid: String? {
    get {
      return self.amoadView.sid
    }
    set {
      self.amoadView.sid = newValue
    }
  }
  
  @objc public var image: UIImage? {
    get {
      return self.amoadView.image
    }
    set {
      self.amoadView.image = newValue
    }
  }
  
  /// デリゲート
  fileprivate var amoadDelegator: AMoAdViewDelegator
  @objc weak public var delegate: (NSObject & AMoAdViewDelegateW)? {
    didSet {
      self.amoadDelegator.target = self.delegate
    }
  }
  
  /// ローテーション時トランジション
  @objc public var rotateTransition: UIView.AnimationTransition {
    get {
      return self.amoadView.rotateTransition
    }
    set {
      self.amoadView.rotateTransition = newValue
    }
  }
  
  /// クリック時トランジション
  @objc public var clickTransition: AMoAdClickTransitionW {
    get {
      return AMoAdClickTransitionW.convert(self.amoadView.clickTransition)
    }
    set {
      self.amoadView.clickTransition = newValue.convert
    }
  }
  
  /// 水平方向の広告表示位置
  @objc public var horizontalAlign: AMoAdHorizontalAlignW {
    get {
      return AMoAdHorizontalAlignW.convert(self.amoadView.horizontalAlign)
    }
    set {
      self.amoadView.horizontalAlign = newValue.convert
    }
  }
  
  /// 垂直方向の広告表示位置
  @objc public var verticalAlign: AMoAdVerticalAlignW {
    get {
      return AMoAdVerticalAlignW.convert(self.amoadView.verticalAlign)
    }
    set {
      self.amoadView.verticalAlign = newValue.convert
    }
  }
  
  /// 広告サイズの調整
  @objc public var adjustMode: AMoAdAdjustModeW {
    get {
      return AMoAdAdjustModeW.convert(self.amoadView.adjustMode)
    }
    set {
      self.amoadView.adjustMode = newValue.convert
    }
  }
  
  /// タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
  @objc public var networkTimeoutMillis: Int {
    get {
      return self.amoadView.networkTimeoutMillis
    }
    set {
      self.amoadView.networkTimeoutMillis = newValue
    }
  }
  
  /// フレームを指定して初期化する
  @objc override public init(frame: CGRect) {
    self.amoadView = AMoAdView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    self.amoadDelegator = AMoAdViewDelegator()
    super.init(frame: frame)
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// 初期表示画像・ハイライト画像を指定して初期化する
  @objc public init(image: UIImage?, highlightedImage: UIImage?, adjustMode: AMoAdAdjustModeW) {
    self.amoadView = AMoAdView(image: image, highlightedImage: highlightedImage, adjustMode: adjustMode.convert)
    self.amoadDelegator = AMoAdViewDelegator()
    super.init(frame: .zero)
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// Xib/storyboardから初期化時に呼ばれる
  @objc required public init?(coder aDecoder: NSCoder) {
    guard let adView = AMoAdView(coder: aDecoder) else { return nil }
    self.amoadView = adView
    self.amoadDelegator = AMoAdViewDelegator()
    super.init(coder: aDecoder)
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// CGRectZeroで初期化する
  @objc public convenience init() {
    self.init(frame: .zero)
    self.amoadView = AMoAdView()
    self.amoadDelegator = AMoAdViewDelegator()
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// 初期表示画像を指定して初期化する（広告サイズ調整：固定）
  @objc public convenience init(image: UIImage?) {
    self.init(frame: .zero)
    self.amoadView = AMoAdView(image: image)
    self.amoadDelegator = AMoAdViewDelegator()
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// 初期表示画像・ハイライト画像を指定して初期化する（広告サイズ調整：固定）
  @objc public convenience init(image: UIImage?, highlightedImage: UIImage?) {
    self.init(frame: .zero)
    self.amoadView = AMoAdView(image: image, highlightedImage: highlightedImage)
    self.amoadDelegator = AMoAdViewDelegator()
    self.amoadView.delegate = self.amoadDelegator
    self.addSubview(self.amoadView)
  }
  
  /// 広告を表示する
  @objc public func show() {
    self.amoadView.show()
  }
  
  /// 広告を非表示にする
  @objc public func hide() {
    self.amoadView.hide()
  }
  
  /// クリック時にカスタムURLスキームをハンドリングする
  @objc public func setClickCustomScheme(scheme: String, handler: @escaping (String) -> ()) {
    self.amoadView.setClickCustomScheme(scheme: scheme, handler: handler)
  }
  
  /// クリック時に複数のカスタムURLスキームをハンドリングする
  @objc public func setClickCustomSchemes(schemes: [String], handler: @escaping (String) -> ()) {
    self.amoadView.setClickCustomSchemes(schemes: schemes, handler: handler)
  }
  
  /// クリック時に全てのLPへの遷移をハンドリングする
  /// Safari view controller を使う場合以外は、openURLでSafariを起動すること
  @objc public func setClickCustomHandler(handler: @escaping (String) -> ()) {
    self.amoadView.setClickCustomHandler(handler: handler)
  }
}

/// インタースティシャル広告I/F
@objc public class AMoAdInterstitialW : NSObject {
  
  /// インタースティシャル広告の登録を行なう
  ///
  /// - Parameter sid: 管理画面から取得した64文字の英数字
  @objc public static func registerAd(sid: String) {
    AMoAdInterstitial.registerAd(sid: sid)
  }
  
  /// タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - millis: タイムアウト時間（ミリ秒）
  @objc public static func setNetworkTimeout(sid: String, millis: Int) {
    AMoAdInterstitial.setNetworkTimeout(sid: sid, millis: millis)
  }
  
  /// Portraitパネル画像（310x380で表示される）を設定する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - image: パネル画像
  @objc public static func setPortraitPanel(sid: String, image: UIImage?) {
    AMoAdInterstitial.setPortraitPanel(sid: sid, image: image)
  }
  
  /// Landscapeパネル画像（380x310で表示される）を設定する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - image: パネル画像
  @objc public static func setLandscapePanel(sid: String, image: UIImage?) {
    AMoAdInterstitial.setLandscapePanel(sid: sid, image: image)
  }
  
  /// リンクボタン画像（280x50で表示される）を設定する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - image: リンクボタン画像
  ///   - highlighted: リンクボタン画像（押下時）
  @objc public static func setLinkButton(sid: String, image: UIImage?, highlighted: UIImage?) {
    AMoAdInterstitial.setLinkButton(sid: sid, image: image, highlighted: highlighted)
  }
  
  /// 閉じるボタン画像（40x40で表示される）を設定する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - image: 閉じるボタン画像
  ///   - highlighted: 閉じるボタン画像（押下時）
  @objc public static func setCloseButton(sid: String, image: UIImage?, highlighted: UIImage?) {
    AMoAdInterstitial.setCloseButton(sid: sid, image: image, highlighted: highlighted)
  }
  
  /// showAdを呼んだ後、自動で次の広告をロード（loadAd）するかどうか：デフォルトはYES
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - isAutoReload: showAdを呼んだ後、自動で次の広告をロード（loadAd）するかどうか
  @objc public static func setAutoReload(sid: String, isAutoReload: Bool) {
    AMoAdInterstitial.setAutoReload(sid: sid, isAutoReload: isAutoReload)
  }
  
  /// インタースティシャル広告のロードを行なう
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - completion: 広告受信完了コールバック
  @objc public static func loadAd(sid: String, completion: ((String, AMoAdResultW, Error?) -> ())?) {
    AMoAdInterstitial.loadAd(sid: sid) { (id, result, error) in
      completion?(id, AMoAdResultW.convert(result), error)
    }
  }
  
  /// インタースティシャル広告がプリロードされているかどうかを返す
  ///
  /// - Parameter sid: 管理画面から取得した64文字の英数字
  /// - Returns: インタースティシャル広告がプリロードされているかどうか
  @objc public static func isLoadedAd(sid: String) -> Bool {
    return AMoAdInterstitial.isLoadedAd(sid: sid)
  }
  
  /// インタースティシャル広告を表示する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - completion: インタースティシャル終了コールバック
  @objc public static func showAd(sid: String, completion: ((String, AMoAdInterstitialResultW, Error?) -> ())?) {
    AMoAdInterstitial.showAd(sid: sid) { (id, result, error) in
      completion?(id, AMoAdInterstitialResultW.convert(result), error)
    }
  }
  
  /// インタースティシャル広告を閉じる
  ///
  /// - Parameter sid: 管理画面から取得した64文字の英数字
  @objc public static func closeAd(sid: String) {
    AMoAdInterstitial.closeAd(sid: sid)
  }
}

/// AMoAdViewデリゲートプロトコル
@objc public protocol AMoAdViewDelegateW : AnyObject {
  
  /// 正常に広告を受信した
  @objc optional func amoadViewDidReceiveAd(view: AMoAdViewW)
  
  /// 広告の取得に失敗した
  @objc optional func amoadViewDidFailToReceiveAd(error: Error)
  
  /// 空の広告を受信した
  @objc optional func amoadViewDidReceiveEmptyAd(view: AMoAdViewW)
  
  /// 広告がクリックされた
  @objc optional func amoadViewDidClick(view: AMoAdViewW)
  
  /// 広告がクリックされた後、戻ってくる
  @objc optional func amoadViewWillClickBack(view: AMoAdViewW)
  
  /// 広告がクリックされた後、戻ってきた
  @objc optional func amoadViewDidClickBack(view: AMoAdViewW)
}

// MARK: - ネイティブ広告

/// 広告分析情報
@objc public class AMoAdAnalyticsW: NSObject {
  fileprivate var analytics: AMoAdAnalytics
  
  @objc public var publisherParam: [String : String]? {
    get {
      return self.analytics.publisherParam
    }
    set {
      self.analytics.publisherParam = newValue
    }
  }
  
  @objc public init(reportId: String) {
    self.analytics = AMoAdAnalytics(reportId: reportId)
  }
}

/// 広告描画情報
@objc public class AMoAdNativeViewCoderW : NSObject {
  fileprivate let coder: AMoAdNativeViewCoder
  
  /// タイトルショートの文字属性
  @objc public var titleShortAttributes: [NSAttributedString.Key : Any]? {
    get {
      return self.coder.titleShortAttributes
    }
    set {
      self.coder.titleShortAttributes = newValue
    }
  }
  
  /// タイトルロングの文字属性
  @objc public var titleLongAttributes: [NSAttributedString.Key : Any]? {
    get {
      return self.coder.titleLongAttributes
    }
    set {
      self.coder.titleLongAttributes = newValue
    }
  }
  
  /// サービス名の文字属性
  @objc public var serviceNameAttributes: [NSAttributedString.Key : Any]? {
    get {
      return self.coder.serviceNameAttributes
    }
    set {
      self.coder.serviceNameAttributes = newValue
    }
  }
  
  /// タップ回数（デフォルト「1」、ダブルクリックの場合は「2」）
  @objc public var numberOfTapsRequired: Int {
    get {
      return self.coder.numberOfTapsRequired
    }
    set {
      self.coder.numberOfTapsRequired = newValue
    }
  }
  
  /// <p>広告描画情報を生成する</p>
  @objc override public init() {
    self.coder = AMoAdNativeViewCoder()
    super.init()
  }
}


/// 広告オブジェクト
@objc public class AMoAdItemW : NSObject {
  fileprivate var amoadItem: AMoAd.AMoAdItem
  
  /// アイコン画像URL
  @objc public var iconUrl: String? {
    get {
      self.amoadItem.iconUrl
    }
  }
  
  /// メイン画像URL
  @objc public var imageUrl: String? {
    get {
      self.amoadItem.imageUrl
    }
  }
  
  /// ショートテキスト
  @objc public var titleShort: String? {
    get {
      self.amoadItem.titleShort
    }
  }
  
  /// ロングテキスト
  @objc public var titleLong: String? {
    get {
      self.amoadItem.titleLong
    }
  }
  
  /// サービス名
  @objc public var serviceName: String? {
    get {
      self.amoadItem.serviceName
    }
  }
  
  /// 遷移先URL
  @objc public var link: String {
    get {
      self.amoadItem.link
    }
  }
  
  /// ユニット番号（広告取得数x4、キャッシュ数x2の場合、0, 1, 2, 3, 0, 1, 2, 3）
  @objc public var unitNo: Int {
    get {
      self.amoadItem.unitNo
    }
  }
  
  /// クリック時に呼び出す
  @objc public func onClick() {
    self.amoadItem.onClick()
  }
  
  /// クリック時に呼び出す（カスタムURLスキームをハンドリングする）
  /// schemesがnilの場合、全てのLPへの遷移をハンドリングする
  /// Safari view controller を使う場合以外は、openURLでSafariを起動すること
  @objc public func onClick(schemes: [String]?, handler: ((String) -> ())?) {
    self.amoadItem.onClick(schemes: schemes, handler: handler)
  }
  
  @objc override public init() {
    self.amoadItem = AMoAd.AMoAdItem()
  }
}

/// リストビュー広告オブジェクト
@objc public class AMoAdListW : NSObject {
  
  /// 広告オブジェクトの配列
  @objc public var ads: [AMoAdItemW]?
  
  /// 表示開始位置
  @objc public var beginIndex: Int
  
  /// 表示間隔
  @objc public var interval: Int
  
  fileprivate init?(list: AMoAdList?) {
    guard let list = list else { return nil }
    self.beginIndex = list.beginIndex
    self.interval = list.interval
    super.init()
    
    guard let originalAds = list.ads else { return }
    self.ads = [AMoAdItemW]()
    for item in originalAds {
      let itemw = AMoAdItemW()
      itemw.amoadItem = item
      self.ads?.append(itemw)
    }
  }
}

/// メイン動画
@objc public class AMoAdNativeMainVideoViewW : UIView {
  
  fileprivate var amoadNativeMainVideoView: AMoAdNativeMainVideoView
  
  @objc weak public var delegate: AMoAdNativeVideoAppDelegateW? {
    didSet {
      self.amoadDelegator.target = self.delegate
    }
  }
  private var amoadDelegator: AMoAdNativeVideoAppDelegator
  
  @objc required public init?(coder aDecoder: NSCoder) {
    guard let video = AMoAdNativeMainVideoView(coder: aDecoder) else { return nil }
    self.amoadNativeMainVideoView = video
    self.amoadDelegator = AMoAdNativeVideoAppDelegator()
    super.init(coder: aDecoder)
    self.amoadNativeMainVideoView.delegate = self.amoadDelegator
  }
  
  @objc override public init(frame: CGRect) {
    self.amoadNativeMainVideoView = AMoAdNativeMainVideoView(frame: frame)
    self.amoadDelegator = AMoAdNativeVideoAppDelegator()
    super.init(frame: frame)
    self.amoadNativeMainVideoView.delegate = self.amoadDelegator
  }
}

/// ネイティブ広告マネージャ
/// 共通機能
@objc public class AMoAdNativeViewManagerW : NSObject {
  
  weak fileprivate var delegate: AMoAdNativeAppDelegateW?
  private var amoadDelegator: AMoAdNativeAppDelegator?
  
  /// ネイティブ広告マネージャを取得する
  @objc public static var shared: AMoAdNativeViewManagerW {
    struct Static {
      static let instance = AMoAdNativeViewManagerW()
    }
    return Static.instance
  }
  
  /// 追跡型広告の配信（YES...配信する：デフォルト / NO...配信しない）
  @objc public var isAdvertisingTrackingEnabled: Bool {
    get {
      return AMoAdNativeViewManager.shared.isAdvertisingTrackingEnabled
    }
    set {
      AMoAdNativeViewManager.shared.isAdvertisingTrackingEnabled = newValue
    }
  }
  
  /// 広告ビューの内容を更新する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public func updateAd(sid: String, tag: String) {
    AMoAdNativeViewManager.shared.updateAd(sid: sid, tag: tag)
  }
}

/// 【ネイティブ（App）】向け
@objc extension AMoAdNativeViewManagerW {
  
  /// ネイティブ（App）広告の準備を行なう
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - iconPreloading: true...アイコン画像をすぐに先読みする<br />false...アイコン画像をビュー取得時に読み込む（1行テキスト広告の場合は無効）
  ///   - imagePreloading: true...メイン画像をすぐに先読みする<br />true...メイン画像をビュー取得時に読み込む（1行テキスト広告、アイコン画像＋テキスト広告の場合は無効）
  @objc public func prepareAd(sid: String, iconPreloading: Bool = false, imagePreloading: Bool = false) {
    AMoAdNativeViewManager.shared.prepareAd(sid: sid, iconPreloading: iconPreloading, imagePreloading: imagePreloading)
  }
  
  /// 既存の広告ビューに広告をレンダリングする
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  ///   - view: 広告ビュー
  ///   - coder: 広告描画情報
  ///   - delegate: 広告delegate
  @objc public func renderAd(sid: String, tag: String, view: UIView, coder: AMoAdNativeViewCoderW? = nil, delegate: AMoAdNativeAppDelegateW? = nil) {
    self.amoadDelegator = AMoAdNativeAppDelegator()
    self.amoadDelegator?.target = delegate
    AMoAdNativeViewManager.shared.renderAd(sid: sid, tag: tag, view: view, coder: coder?.coder, delegate: self.amoadDelegator)
  }
  
  /// 広告ビューの内容をクリアする
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます（未指定時はすべてのtagがクリア対象となります）
  @objc public func clearAd(sid: String, tag: String? = nil) {
    AMoAdNativeViewManager.shared.clearAd(sid: sid, tag: tag)
  }
}

/// 【リストビュー】向け
@objc extension AMoAdNativeViewManagerW {
  
  /// リストビュー広告の準備を行なう
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - defaultBeginIndex: 広告の開始位置（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
  ///   - defaultInterval: 広告の表示間隔（初回、サーバから取得するまでのデフォルト値：リリース時は管理画面の設定に合わせることをお勧めします）
  ///   - iconPreloading: true...アイコン画像をすぐに先読みする<br />false...アイコン画像をビュー取得時に読み込む（1行テキスト広告の場合は無効）
  ///   - imagePreloading: true...メイン画像をすぐに先読みする<br />true...メイン画像をビュー取得時に読み込む（1行テキスト広告、アイコン画像＋テキスト広告の場合は無効）
  @objc public func prepareAd(sid: String, defaultBeginIndex: Int, defaultInterval: Int, iconPreloading: Bool = false, imagePreloading: Bool = false) {
    AMoAdNativeViewManager.shared.prepareAd(sid: sid, defaultBeginIndex: defaultBeginIndex, defaultInterval: defaultInterval, iconPreloading: iconPreloading, imagePreloading: imagePreloading)
  }
  
  /// データソース配列に広告を挿入する
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
  ///   - array: originalArray コンテンツデータの配列
  /// - Returns: コンテンツデータの配列に広告を挿入した配列
  @objc public func array(sid: String, tag: String, array: [AnyObject]?) -> [AnyObject] {
    return AMoAdNativeViewManager.shared.array(sid: sid, tag: tag, array: array)
  }
  
  /// テーブル（UITableView）に広告テンプレート（nibName）を登録する（描画情報を設定する）
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
  ///   - tableView: 広告セルを含んだテーブル型のリストを表示する
  ///   - nib: 広告セル用のリソースオブジェクト
  ///   - coder: 広告描画情報
  @objc public func register(sid: String, tag: String, tableView: UITableView, nib: UINib, coder: AMoAdNativeViewCoderW? = nil) {
    AMoAdNativeViewManager.shared.register(sid: sid, tag: tag, tableView: tableView, nib: nib, coder: coder?.coder)
  }
  
  /// コレクション（UICollectionView）に広告テンプレート（nibName）を登録する（描画情報を設定する）
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のテーブル（コレクション）で使用するときの識別子<br />任意の文字列を指定できます
  ///   - collectionView: 広告セルを含んだコレクション型のリストを表示する
  ///   - nib: 広告セル用のリソースオブジェクト
  ///   - coder: 広告描画情報
  @objc public func register(sid: String, tag: String, collectionView: UICollectionView, nib: UINib, coder: AMoAdNativeViewCoderW? = nil) {
    AMoAdNativeViewManager.shared.register(sid: sid, tag: tag, collectionView: collectionView, nib: nib, coder: coder?.coder)
  }
}

/// プリロール広告I/F
@objc public class AMoAdNativePreRollW : NSObject {
  
  /// プリロール広告の準備を行なう
  ///
  /// - Parameter sid: 管理画面から取得した64文字の英数字
  @objc public static func prepareAd(sid: String) {
    AMoAdNativePreRoll.prepareAd(sid: sid)
  }
  
  /// 既存のビューにプリロール広告をレンダリングする
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  ///   - view: 広告を描画するビュー
  ///   - analytics: 広告分析情報
  ///   - isFullscreenClickable: Linkボタンだけでなく全画面のタップを有効にするか
  ///   - completion: 広告受信完了コールバック関数
  @objc public static func renderAd(sid: String, tag: String, view: UIView, analytics: AMoAdAnalyticsW?, isFullscreenClickable: Bool, completion: ((String, String, UIView, AMoAdResultW) -> ())?) {
    AMoAdNativePreRoll.renderAd(sid: sid,
                                tag: tag,
                                view: view,
                                analytics: analytics?.analytics,
                                isFullscreenClickable: isFullscreenClickable) { (id, tag, v, result) in
                                  completion?(id, tag, v, AMoAdResultW.convert(result))
    }
  }
  
  /// ビューのサイズが変わったとき再レイアウトする
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - tag: 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func layoutAd(sid: String, tag: String) {
    AMoAdNativePreRoll.layoutAd(sid: sid, tag: tag)
  }
}

/// ネイティブHTML広告
@objc public class AMoAdNativeW : NSObject {
  
  /// 広告をロードする
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  ///   - frame 広告の表示位置・サイズ
  ///   - completion 広告リクエスト結果を受け取るクロージャー
  @objc public static func load(sid: String, tag: String, frame: CGRect, completion: ((String, String, AMoAdResultW) -> ())?) {
    AMoAdNative.load(sid: sid, tag: tag, frame: frame) { (id, tag, result) in
      completion?(id, tag, AMoAdResultW.convert(result))
    }
  }
  
  /// 広告Viewを取得する（親ビューにaddしてください）
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// - Returns: 広告View
  @objc public static func view(sid: String, tag: String) -> UIView? {
    return AMoAdNative.view(sid: sid, tag: tag)
  }
  
  /// 広告Viewを削除する（親ビューからのremoveは行いません）
  /// 親ビューからremoveする方法：
  /// [[AMoAdNative viewWithSid:kSid tag:kTag] removeFromSuperview]
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func disposeView(sid: String, tag: String) {
    AMoAdNative.disposeView(sid: sid, tag: tag)
  }
  
  /// すべての広告Viewを削除する（親ビューからのremoveは行いません）
  @objc public static func disposeAllView() {
    AMoAdNative.disposeAllView()
  }
  
  /// 広告をリロード（別の広告に更新）する
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func reload(sid: String, tag: String) {
    AMoAdNative.reload(sid: sid, tag: tag)
  }
  
  /// 広告Viewを表示する
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func show(sid: String, tag: String) {
    AMoAdNative.show(sid: sid, tag: tag)
  }
  
  /// 広告Viewを非表示にする
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func hide(sid: String, tag: String) {
    AMoAdNative.hide(sid: sid, tag: tag)
  }
  
  /// ローテーションを開始する
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  ///   - seconds ローテーション間隔（秒）
  @objc public static func startRotation(sid: String, tag: String, seconds: Int) {
    AMoAdNative.startRotation(sid: sid, tag: tag, seconds: seconds)
  }
  
  /// ローテーションを終了する
  ///
  /// - Parameters:
  ///   - sid 管理画面から取得した64文字の英数字
  ///   - tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  @objc public static func stopRotation(sid: String, tag: String) {
    AMoAdNative.stopRotation(sid: sid, tag: tag)
  }
}

/// ネイティブリスト広告
@objc public class AMoAdInfeedW : NSObject {
  
  @objc public static func setNetworkTimeoutMillis(millis: Int) {
    AMoAdInfeed.setNetworkTimeoutMillis(millis: millis)
  }
  
  /// 広告をロードする
  ///
  /// - Parameters:
  ///   - sid: 管理画面から取得した64文字の英数字
  ///   - completion: 広告オブジェクト配列と結果を受け取るクロージャー
    @objc public static func load(sid: String, completion: @escaping (AMoAdResultW, AMoAdListW?) -> ()) {
      AMoAdInfeed.load(sid: sid) { (result, list) in
        completion(AMoAdResultW.convert(result), AMoAdListW(list: list))
      }
    }
  
  /// 広告表示時に呼び出す: 表示されたCellを追跡しImpression（Viewable Impression）を送信する
  ///
  /// - Parameters:
  ///   - cell: 広告を表示するTableViewCell, CollectionViewCell, View
  ///   - adItem: 表示する広告のオブジェクト（広告でない場合はnil）
  @objc public static func setViewabilityTrackingCell(cell: UIView, adItem: AMoAdItemW?) {
    AMoAdInfeed.setViewabilityTrackingCell(cell: cell, adItem: adItem?.amoadItem)
  }
}

/// インタースティシャル動画広告
@objc public class AMoAdInterstitialVideoW : NSObject {
  fileprivate var amoadInterstitialVideo: AMoAdInterstitialVideo!
  
  fileprivate var amoadDelegator: AMoAdInterstitialVideoDelegator
  @objc weak public var delegate: AMoAdInterstitialVideoDelegateW? {
    didSet {
      self.amoadDelegator.target = self.delegate
    }
  }
  
  
  /// 広告のロードが完了していれば true
  @objc public var isLoaded: Bool {
    get {
      return self.amoadInterstitialVideo.isLoaded
    }
  }
  
  /// 動画の再生中にユーザが×ボタンをタップして広告を閉じることを許可するか
  @objc public var isCancellable: Bool {
    get {
      return self.amoadInterstitialVideo.isCancellable
    }
    set {
      self.amoadInterstitialVideo.isCancellable = newValue
    }
  }
  
  private override init() {
    self.amoadDelegator = AMoAdInterstitialVideoDelegator()
    super.init()
    self.amoadDelegator.interstitial = self
  }
  
  @objc public static func shared(sid: String, tag: String) -> AMoAdInterstitialVideoW {
    struct Static {
      static var instance = AMoAdInterstitialVideoW()
    }
    Static.instance.amoadInterstitialVideo = AMoAdInterstitialVideo.shared(sid: sid, tag: tag)
    
    return Static.instance
  }
  
  /// 広告をロードする
  @objc public func load() {
    self.amoadInterstitialVideo.load()
  }
  
  /// 広告を表示する
  @objc public func show() {
    self.amoadInterstitialVideo.show()
  }
  
  /// 広告を閉じる
  @objc public func dismiss() {
    self.amoadInterstitialVideo.dismiss()
  }
}

/// 【ネイティブ（App）】デリゲート
@objc public protocol AMoAdNativeAppDelegateW: class {
  
  /// 広告受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  @objc optional func amoadNativeDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResultW)
  
  /// アイコン受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  @objc optional func amoadNativeIconDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResultW)
  
  /// メイン画像受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  @objc optional func amoadNativeImageDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResultW)
  
  /// 広告クリック時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  @objc optional func amoadNativeDidClick(sid: String, tag: String, view: UIView)
}

/// インタースティシャルAfiOデレゲート
@objc public protocol AMoAdInterstitialVideoDelegateW: class {
  
  /// 広告のロードが完了した
  @objc optional func amoadInterstitialVideoDidLoadAd(amoadInterstitialVideo: AMoAdInterstitialVideoW, result: AMoAdResultW)
  
  /// 動画の再生を開始した
  @objc optional func amoadInterstitialVideoDidStart(amoadInterstitialVideo: AMoAdInterstitialVideoW)
  
  /// 動画を最後まで再生完了した
  @objc optional func amoadInterstitialVideoDidComplete(amoadInterstitialVideo: AMoAdInterstitialVideoW)
  
  /// 動画の再生に失敗した
  @objc optional func amoadInterstitialVideoDidFailToPlay(amoadInterstitialVideo: AMoAdInterstitialVideoW)
  
  /// 広告を表示した
  @objc optional func amoadInterstitialVideoDidShow(amoadInterstitialVideo: AMoAdInterstitialVideoW)
  
  /// 広告を閉じた
  @objc optional func amoadInterstitialVideoWillDismiss(amoadInterstitialVideo: AMoAdInterstitialVideoW)
  
  /// 広告をクリックした
  @objc optional func amoadInterstitialVideoDidClickAd(amoadInterstitialVideo: AMoAdInterstitialVideoW)
}


/// メイン動画デレゲート
@objc public protocol AMoAdNativeVideoAppDelegateW {
  @objc func amoadNativeVideoDidStart(view: UIView)
  @objc func amoadNativeVideoDidComplete(view: UIView)
  @objc func amoadNativeVideoDidFailToPlay(view: UIView)
}


// MARK:- Internal delegators

/// ディスプレイ広告
fileprivate class AMoAdViewDelegator: NSObject & AMoAdViewDelegate {
  weak var target: AMoAdViewDelegateW?
  weak var view: AMoAdViewW?

  /// 正常に広告を受信した
  func amoadViewDidReceiveAd(view: AMoAdView) {
    self.target?.amoadViewDidReceiveAd?(view: self.view!)
  }
  
  /// 広告の取得に失敗した
  func amoadViewDidFailToReceiveAd(error: Error) {
    self.target?.amoadViewDidFailToReceiveAd?(error: error)
  }
  
  /// 空の広告を受信した
  func amoadViewDidReceiveEmptyAd(view: AMoAdView) {
    self.target?.amoadViewDidReceiveEmptyAd?(view: self.view!)
  }
  
  /// 広告がクリックされた
  func amoadViewDidClick(view: AMoAdView) {
    self.target?.amoadViewDidClick?(view: self.view!)
  }
  
  /// 広告がクリックされた後、戻ってくる
  func amoadViewWillClickBack(view: AMoAdView) {
    self.target?.amoadViewWillClickBack?(view: self.view!)
  }
  
  /// 広告がクリックされた後、戻ってきた
  func amoadViewDidClickBack(view: AMoAdView) {
    self.target?.amoadViewDidClickBack?(view: self.view!)
  }
}

/// ネイティブ広告
fileprivate class AMoAdNativeAppDelegator: AMoAdNativeAppDelegate {
  weak var target: AMoAdNativeAppDelegateW?
  /// 広告受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  func amoadNativeDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    target?.amoadNativeDidReceive?(sid: sid, tag: tag, view: view, state: AMoAdResultW.convert(state))
  }
  
  /// アイコン受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  func amoadNativeIconDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    target?.amoadNativeIconDidReceive?(sid: sid, tag: tag, view: view, state: AMoAdResultW.convert(state))
  }
  
  /// メイン画像受信時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  /// @param state 広告受信結果
  func amoadNativeImageDidReceive(sid: String, tag: String, view: UIView, state: AMoAdResult) {
    target?.amoadNativeImageDidReceive?(sid: sid, tag: tag, view: view, state: AMoAdResultW.convert(state))
  }
  
  /// 広告クリック時に呼び出される
  /// @param sid 管理画面から取得した64文字の英数字
  /// @param tag 同じsidを複数のビューで使用するときの識別子<br />任意の文字列を指定できます
  /// @param view 広告ビュー
  func amoadNativeDidClick(sid: String, tag: String, view: UIView) {
    target?.amoadNativeDidClick?(sid: sid, tag: tag, view: view)
  }
}

/// インタースティシャルAfiOデレゲート
fileprivate class AMoAdInterstitialVideoDelegator: AMoAdInterstitialVideoDelegate {
  weak var target: AMoAdInterstitialVideoDelegateW?
  weak var interstitial: AMoAdInterstitialVideoW?
  
  /// 広告のロードが完了した
  func amoadInterstitialVideoDidLoadAd(amoadInterstitialVideo: AMoAdInterstitialVideo, result: AMoAdResult) {
    self.target?.amoadInterstitialVideoDidLoadAd?(amoadInterstitialVideo: self.interstitial!, result: AMoAdResultW.convert(result))
  }
  
  /// 動画の再生を開始した
  func amoadInterstitialVideoDidStart(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoDidStart?(amoadInterstitialVideo: self.interstitial!)
  }
  
  /// 動画を最後まで再生完了した
  func amoadInterstitialVideoDidComplete(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoDidComplete?(amoadInterstitialVideo: self.interstitial!)
  }
  
  /// 動画の再生に失敗した
  func amoadInterstitialVideoDidFailToPlay(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoDidFailToPlay?(amoadInterstitialVideo: self.interstitial!)
  }
  
  /// 広告を表示した
  func amoadInterstitialVideoDidShow(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoDidShow?(amoadInterstitialVideo: self.interstitial!)
  }
  
  /// 広告を閉じた
  func amoadInterstitialVideoWillDismiss(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoWillDismiss?(amoadInterstitialVideo: self.interstitial!)
  }
  
  /// 広告をクリックした
  func amoadInterstitialVideoDidClickAd(amoadInterstitialVideo: AMoAdInterstitialVideo) {
    self.target?.amoadInterstitialVideoDidClickAd?(amoadInterstitialVideo: self.interstitial!)
  }
}

/// メイン動画
fileprivate class AMoAdNativeVideoAppDelegator : AMoAdNativeVideoAppDelegate {
  weak var target: AMoAdNativeVideoAppDelegateW?
  
  public func amoadNativeVideoDidStart(view: UIView) {
    self.target?.amoadNativeVideoDidStart(view: view)
  }
  
  @objc public func amoadNativeVideoDidComplete(view: UIView) {
    self.target?.amoadNativeVideoDidComplete(view: view)
  }
  
  @objc public func amoadNativeVideoDidFailToPlay(view: UIView) {
    self.target?.amoadNativeVideoDidFailToPlay(view: view)
  }
}

// ロガー
@objc public class AMoAdLoggerW : NSObject {
  @objc public enum LogLevel : Int {
    case fatal
    case error
    case warn
    case info
    case debug
    case trace
  }
  
  @objc public static var logLevel: AMoAdLoggerW.LogLevel {
    get {
      switch AMoAdLogger.logLevel {
        case .fatal:
          return .fatal
        case .error:
          return .error
        case .warn:
          return .warn
        case .info:
          return .info
        case .debug:
          return .debug
        case .trace:
          return .trace
      }
    }
    set {
      switch newValue {
        case .fatal:
          AMoAdLogger.logLevel = .fatal
        case .error:
          AMoAdLogger.logLevel = .error
        case .warn:
          AMoAdLogger.logLevel = .warn
        case .info:
          AMoAdLogger.logLevel = .info
        case .debug:
          AMoAdLogger.logLevel = .debug
        case .trace:
          AMoAdLogger.logLevel = .trace
      }
    }
  }
  
  @objc public static var onTrace: ((String) -> ())? {
    get {
      return AMoAdLogger.onTrace
    }
    set {
      AMoAdLogger.onTrace = newValue
    }
  }
  
  @objc public static func fatal(file: String = #file, function: String = #function, line: Int = #line, error: Error?, message: String) {
    AMoAdLogger.fatal(error: error, message: message)
  }
  
  @objc public static func error(file: String = #file, function: String = #function, line: Int = #line, error: Error?, message: String) {
    AMoAdLogger.error(error: error, message: message)
  }
  
  @objc public static func warn(file: String = #file, function: String = #function, line: Int = #line, error: Error?, message: String) {
    AMoAdLogger.warn(error: error, message: message)
  }
  
  @objc public static func info(file: String = #file, function: String = #function, line: Int = #line, message: String) {
    AMoAdLogger.info(message: message)
  }
  
  @objc public static func debug(file: String = #file, function: String = #function, line: Int = #line, message: String) {
    AMoAdLogger.debug(message: message)
  }
  
  @objc public static func trace(file: String = #file, function: String = #function, line: Int = #line, message: String) {
    AMoAdLogger.trace(message: message)
  }
}
