# WebView実装ガイド
WebViewの実装方法についてドキュメントを公開したいと思いますので、こちらに草案を追加していきます。

## ソースコード
### クリックのフック
#### iOS
```objc
class ViewController: UIViewController, UIWebViewDelegate {
  @IBOutlet weak var webView: UIWebView!

  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if (navigationType == .LinkClicked) {
      let url = request.URL?.standardizedURL?.absoluteString;
      if url?.rangeOfString("d.amoad.com") != nil {
        UIApplication.sharedApplication().openURL(request.URL!)
        return false
      }
    }
    return true;
  }
}
```

### Android
#### AMoAdSDK採用
```java
com.amoad.AMoAdWeb.prepareAd(context);

webView.setWebViewClient(new WebViewClient() {
  @Override
  public boolean shouldOverrideUrlLoading(WebView view, String url) {
    if (com.amoad.AMoAdWeb.shouldOverrideUrlLoading(view, url)) {
      return true;
    }
    ...
    return false;
  }

  @Override
  public void onLoadResource(WebView view, String url) {
    com.amoad.AMoAdWeb.stopLoadingIfNeeded(view, url);
  }
});
```

#### AMoAdSDK未採用
```java
webView.setWebViewClient(new WebViewClient() {
  @Override
  public boolean shouldOverrideUrlLoading(WebView view, String url) {
    if (Uri.parse(url).getHost().equals("d.amoad.com")) {
      // TODO: ブラウザへ遷移する
      return true;
    }
    ...
    return false;
  }

  @Override
  public void onLoadResource(WebView view, String url) {
    if (Uri.parse(url).getHost().equals("d.amoad.com")) {
      view.stopLoading();
      // TODO: ブラウザへ遷移する
    }
  }
});
```


#### gree/unity-webview
```objc
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSString *url = [[request URL] absoluteString];
    NSRange range = [url rangeOfString:@"d.amoad.com"];

    if (range.location != NSNotFound) {
        if (request.URL) {
            [[UIApplication sharedApplication] openURL:request.URL];
        }
        return NO;

    } else {
        return YES;

    }

}
```
