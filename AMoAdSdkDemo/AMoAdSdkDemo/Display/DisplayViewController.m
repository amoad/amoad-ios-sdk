//
//  DisplayViewController.m
//  AMoAdSdkDemo
//

#import "DisplayViewController.h"
#import <AMoAd/AMoAdView.h>
#import <AMoAd/AMoAdLogger.h>

@interface DisplayViewController () <AMoAdViewDelegate>

@end

@implementation DisplayViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [AMoAdLogger sharedLogger].logging = YES;
  [AMoAdLogger sharedLogger].trace = YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - AMoAdViewDelegate

/// 広告の取得に失敗した
- (void)AMoAdViewDidFailToReceiveAd:(AMoAdView *)amoadView error:(NSError *)error {
  NSLog(@"広告の取得に失敗した: amoadView.sid=%@, amoadView.frame.size=%@, error=%@",
        amoadView.sid,
        NSStringFromCGSize(amoadView.frame.size),
        error);
}

/// 空の広告を受信した
- (void)AMoAdViewDidReceiveEmptyAd:(AMoAdView *)amoadView {
  NSLog(@"空の広告を受信した: amoadView.sid=%@, amoadView.frame.size=%@",
        amoadView.sid,
        NSStringFromCGSize(amoadView.frame.size));
}

/// 正常に広告を受信した
- (void)AMoAdViewDidReceiveAd:(AMoAdView *)amoadView {
  NSLog(@"正常に広告を受信した: amoadView.sid=%@, amoadView.frame.size=%@",
        amoadView.sid,
        NSStringFromCGSize(amoadView.frame.size));
}

@end
