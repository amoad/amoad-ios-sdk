# WebViewサポート機能 実装ガイド
## 概要
UIWebViewにアドタグを貼るとき以下の機能を提供する。
1. IDFA連携
2. 広告クリックで外部ブラウザを起動する
3. ダイレクトストア（ブラウザを介さずにストアへ遷移する：対応キャンペーンのみ）

※ インフォマーカー／PR表記リンクのクリックでも外部ブラウザへ遷移します。

※ SDKを使えない場合は、[こちら](../../WebView/guide.md)の方法で広告クリックをハンドリングしてください。

## インストール
[インストールガイド](../Install/Install.asciidoc)
をご参照ください。

WebViewのみ利用する場合の必須インストールファイルは以下のものです。
* libAMoAd.a
* AMoAd.h
* AMoAdWeb.h

ログ機能を利用する場合は、AMoAdLogger.h も必要です。

## 実装

#### AMoAdWebの利用を開始する
UIWebViewオブジェクトを作る前に（viewDidLoadなどで）
AMoAdWeb クラスの prepareAd メソッドを呼んでおく。

*Objective-C*
```objc
- (void)viewDidLoad {
  [super viewDidLoad];
  [AMoAdWeb prepareAd];
}
```

*Swift*
```swift
override func viewDidLoad() {
  super.viewDidLoad()
  AMoAdWeb.prepareAd()
}
```

#### UIWebViewのデリゲートを設定する
WebViewに、UIWebViewDelegateプロトコル を設定する。

*Objective-C*
```objc
self.webView.delegate = self;
```

*Swift*
```swift
self.webView.delegate = self
```

#### デリゲートの実装
UIWebViewDelegateプロトコル の
webView:shouldStartLoadWithRequest:navigationType:
メソッドを実装して、
AMoAdWeb クラスの webView:shouldStartLoadWithRequest:navigationType:
メソッドを呼び出す。

##### 広告クリックの時の処理を行う

*Objective-C*
```objc
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if (![AMoAdWeb webView:webView shouldStartLoadWithRequest:request navigationType:navigationType]) {
    return NO;
  }
  return YES;
}
```

*Swift*
```swift
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
  if !AMoAdWeb.webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType) {
    return false;
  }
  return true;
}
```

## サンプルアプリ
### 概要
アドタグが貼られているHTMLを、以下の方法で読込み
クリック処理を行う例を示します。
* ウェブからロードする
* ファイルからロードする
* 文字列からロードする

### 一覧
* [AMoAdWebViewSample](../../Samples/WebView/AMoAdWebViewSample/) ... Objective-C言語で書かれたサンプルアプリ
* [AMoAdWebViewSwiftSample](../../Samples/WebView/AMoAdWebViewSwiftSample/) ... Swift言語で書かれたサンプルアプリ

### 使い方
#### 1 . 読込み方法を選択する

*Objective-C*
```objc
#define LOAD_FROM_URL 1     /* URLからロードする場合、1を指定する */
#define LOAD_FROM_FILE 0    /* ファイルからロードする場合、1を指定する */
#define LOAD_FROM_STRING 0  /* 文字列からロードする場合、1を指定する */
```

*Swift*
```swift
static let LOAD_FROM_URL = true // URLからロードする
static let LOAD_FROM_FILE = false // ファイルからロードする
static let LOAD_FROM_STRING = false // 文字列からロードする
```

#### 2 . 読込みデータを指定する

##### a) URLからロードする
「 http://example.com/ 」を適切なURLに置き換えてください。

*Objective-C*
```objc
NSURL *requestURL = [NSURL URLWithString:@"http://example.com/"];  // TODO: URLを指定する
NSURLRequest *req = [NSURLRequest requestWithURL:requestURL];
[self.webView loadRequest:req];
```

*Swift*
```swift
if let requestURL = NSURL(string: "http://example.com/") {  // TODO: URLを指定する
  let req = NSURLRequest(URL: requestURL)
  self.webView.loadRequest(req)
}
```

##### b) ファイルからロードする
「 index 」「 html 」を適切なリソース名に置き換えてください。

*Objective-C*
```objc
NSString *requestPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];  // TODO: index.htmlの場合
NSURL *requestURL = [NSURL URLWithString:requestPath];
NSURLRequest *req = [NSURLRequest requestWithURL:requestURL];
[self.webView loadRequest:req];
```

*Swift*
```swift
if let requestPath = NSBundle.mainBundle().pathForResource("index", ofType: "html") { // TODO: index.htmlの場合
  if let requestURL = NSURL(string: requestPath) {
    let req = NSURLRequest(URL: requestURL)
    self.webView.loadRequest(req)
  }
}
```

##### c) 文字列からロードする
文字列中の「↓ここにアドタグを貼ってください」
という箇所にアドタグを設置してください。

*Objective-C*
```objc
[self.webView loadHTMLString:@"<!DOCTYPE html> \
 <html lang='ja'> \
 <head> \
 <meta charset='utf-8'> \
 <meta name='viewport' content='width=device-width,initial-scale=1.0,user-scalable=no'> \
 <title>サンプルページ</title> \
 </head> \
 <body style='margin: 0; padding: 0'> \
 <p>↓ここにアドタグを貼ってください</p> \
 </body> \
 </html> \
 " baseURL:nil];  // TODO: HTMLを文字列で指定する
```

*Swift*
```swift
self.webView.loadHTMLString("<!DOCTYPE html>" +
  "<html lang='ja'>" +
  "<head>" +
  "<meta charset='utf-8'>" +
  "<meta name='viewport' content='width=device-width,initial-scale=1.0,user-scalable=no'>" +
  "<title>サンプルページ</title>" +
  "</head>" +
  "<body style='margin: 0; padding: 0'>" +
  "<p>↓ここにアドタグを貼ってください</p>" +
  "</body>" +
  "</html>" +
  "", baseURL:nil)  // TODO: HTMLを文字列で指定する
```
