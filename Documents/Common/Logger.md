# ロギング・トレース機能
## ログ出力方法

開発時にSDKのログを出力をしたい場合は、
`AMoAdLogger.h` をimportした上で下記実装を実施する。
`onLogging` ブロックを登録することでログ出力をフックしてカスタマイズできます。

```objective-c
#import "AMoAdLogger.h"

- (void)viewDidLoad {
  [AMoAdLogger sharedLogger].logging = YES;
  [AMoAdLogger sharedLogger].onLogging =
    ^(NSString *message, NSError *error) {
      NSLog(@"【ユーザ定義】%@:%@", message, error);
    };
}
```

## トレース出力方法

開発時にSDKのトレースを出力をしたい場合は、
`AMoAdLogger.h` をimportした上で下記実装を実施する。
`onTrace` ブロックを登録することでトレース出力をフックしてカスタマイズできます。

```objective-c
#import "AMoAdLogger.h"

- (void)viewDidLoad {
  [AMoAdLogger sharedLogger].trace = YES;
  [AMoAdLogger sharedLogger].onTrace =
  ^(NSString *message, NSObject *target) {
    NSLog(@"【ユーザ定義】%@:%@", message, target);
  };
}
```

targetには、そのトレースを出力しているコンテキストが渡されますが、 内容は非公開です。お問合せ対応などに使わせていただくことがあります。
