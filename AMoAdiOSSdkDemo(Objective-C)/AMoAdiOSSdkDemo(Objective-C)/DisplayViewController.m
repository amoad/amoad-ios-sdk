//
//  DisplayViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/02.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "DisplayViewController.h"
#import "AMoAdView.h"

@interface DisplayViewController () <AMoAdViewDelegate>
@property AMoAdView *adView;
@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAd];
}

- (void) initAd {
    self.adView = [[AMoAdView alloc ]init];
    self.adView.delegate = self;
    self.adView.horizontalAlign = AMoAdHorizontalAlignCenter;
    self.adView.verticalAlign = AMoAdVerticalAlignBottom;
    self.adView.rotateTransition = AMoAdRotateTransitionFlipFromLeft;
    self.adView.clickTransition = AMoAdClickTransitionJump;
    self.adView.adjustMode = AMoAdAdjustModeResponsive;
    self.adView.sid = self.sid;
    [self.view addSubview:self.adView];
    
}
- (void) showAd {
    self.adView.hidden = false;
}
- (void) hideAd {
    self.adView.hidden = true;
}
- (IBAction)onHideBtnClicked:(id)sender {
    [self hideAd];
}
- (IBAction)onShowBtnClicked:(id)sender {
    [self showAd];
}

- (void)AMoAdViewDidReceiveAd:(AMoAdView *)amoadView {
    // 正常に広告を受信した
}

- (void)AMoAdViewDidFailToReceiveAd:(AMoAdView *)amoadView error:(NSError *)error {
    // 広告の取得に失敗した
}
- (void)AMoAdViewDidReceiveEmptyAd:(AMoAdView *)amoadView {
    // 空の広告を受信した
}

@end
