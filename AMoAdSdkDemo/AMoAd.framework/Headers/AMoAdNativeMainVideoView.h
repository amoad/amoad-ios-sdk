//
//  AMoAdNativeMainVideoView.h
//  AMoAd
//
//  Created by AMoAd on 10/02/2017.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AMoAdNativeVideo;

@protocol AMoAdNativeVideoAppDelegate <NSObject>
/// 動画の再生を開始した
- (void)amoadNativeVideoDidStart:(UIView *)amoadNativeMainVideoView;
/// 動画を最後まで再生完了した
- (void)amoadNativeVideoDidComplete:(UIView *)amoadNativeMainVideoView;
/// 動画の再生に失敗した
- (void)amoadNativeVideoDidFailToPlay:(UIView *)amoadNativeMainVideoView NS_SWIFT_NAME(amoadNativeVideoDidFailToPlay(_:));
@end

@interface AMoAdNativeMainVideoView : UIView

@property (nonatomic, weak) id<AMoAdNativeVideoAppDelegate> delegate;

@end
