//
//  AMoAdLogger.h
//
//  Created by AMoAd on 2014/11/17.
//
#import <Foundation/Foundation.h>

/// ログを出力する
@interface AMoAdLogger : NSObject
/// SDKエラーをログ出力する（YES / NO:デフォルト）
@property (nonatomic,readwrite,assign) BOOL logging;

/// ログをNSLog以外に出力する場合、このブロックを設定する
@property (nonatomic,readwrite,strong) void (^onLogging)(NSString *message, NSError *error);

/// ロガー・オブジェクトを取得する
+ (AMoAdLogger *)sharedLogger;

- (void)log:(NSString * const)format param:(NSObject *)param error:(NSError *)error;
@end
