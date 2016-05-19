//
//  AMoAdCocos2dxModule.mm
//
//  Created by AMoAd on 2015/07/15.
//
#import "AMoAdCocos2dxModule.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AMoAdView.h"
#import "AMoAdInterstitial.h"

#pragma mark - Utilities

static NSString* string_with_cstring(const char *c) {
  return @(c);
}

static UIViewController* get_view_controller() {
  UIWindow *mainWindow = ([UIApplication sharedApplication].windows)[0];
  return mainWindow.rootViewController;
}

static AMoAdView *find_amoad_view(NSString *sid) {
  for (id view in get_view_controller().view.subviews) {
    if ([view isKindOfClass:[AMoAdView class]]) {
      AMoAdView *amoadView = (AMoAdView *)view;
      if ([amoadView.sid isEqualToString:sid]) {
        return amoadView;
      }
    }
  }
  return nil;
}


#pragma mark - Implements

@interface AMoAdView(AMoAdCocos2dxModule)
- (instancetype)initWithBannerSize:(AMoAdBannerSize)bannerSize hAlign:(AMoAdHorizontalAlign)hAlign vAlign:(AMoAdVerticalAlign)vAlign adjustMode:(AMoAdAdjustMode)adjustMode x:(CGFloat)x y:(CGFloat)y delegate:(id)delegate;
@end

void AMoAdCocos2dxModule::registerInlineAd(const char *cSid,
                                           AMoAdCocos2dxModule::AdSize adSize,
                                           AMoAdCocos2dxModule::HorizontalAlign hAlign,
                                           AMoAdCocos2dxModule::VerticalAlign vAlign,
                                           AMoAdCocos2dxModule::AdjustMode adjustMode,
                                           int x/* = 0*/,
                                           int y/* = 0*/,
                                           int timeoutMillis/* = 30*1000*/)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = [[AMoAdView alloc] initWithBannerSize:AMoAdBannerSize(adSize)
                                                        hAlign:AMoAdHorizontalAlign(hAlign)
                                                        vAlign:AMoAdVerticalAlign(vAlign)
                                                    adjustMode:AMoAdAdjustMode(adjustMode)
                                                             x:CGFloat(x)
                                                             y:CGFloat(y)
                                                      delegate:nil];
  if (amoadView) {
    UIViewController *viewController = get_view_controller();
    amoadView.networkTimeoutMillis = timeoutMillis;
    amoadView.hidden = YES;
    amoadView.sid = sid;
    [viewController.view addSubview:amoadView];
  }
}

void AMoAdCocos2dxModule::registerInterstitialAd(const char *cSid,
                                                 int timeoutMillis/* = 30*1000*/)
{
  NSString *sid = string_with_cstring(cSid);
  [AMoAdInterstitial setNetworkTimeoutWithSid:sid millis:timeoutMillis];
  [AMoAdInterstitial registerAdWithSid:sid];
}


void AMoAdCocos2dxModule::setInterstitialDisplayClickable(const char *cSid, bool cClickable)
{
  NSString *sid = string_with_cstring(cSid);
  BOOL clickable = (cClickable) ? YES : NO;
  [AMoAdInterstitial setDisplayWithSid:sid clickable:clickable];
}

void AMoAdCocos2dxModule::setInterstitialDialogShown(const char *cSid, bool cShown)
{
  NSString *sid = string_with_cstring(cSid);
  BOOL shown = (cShown) ? YES : NO;
  [AMoAdInterstitial setDialogWithSid:sid shown:shown];
}


void AMoAdCocos2dxModule::setInterstitialPortraitPanel(const char *cSid, const char *cImageName)
{
  NSString *sid = string_with_cstring(cSid);
  NSString *imageName = string_with_cstring(cImageName);
  [AMoAdInterstitial setPortraitPanelWithSid:sid image:[UIImage imageNamed:imageName]];
}

void AMoAdCocos2dxModule::setInterstitialLandscapePanel(const char *cSid, const char *cImageName)
{
  NSString *sid = string_with_cstring(cSid);
  NSString *imageName = string_with_cstring(cImageName);
  [AMoAdInterstitial setLandscapePanelWithSid:sid image:[UIImage imageNamed:imageName]];
}


void AMoAdCocos2dxModule::setInterstitialLinkButton(const char *cSid, const char *cImageName, const char *cHighlighted)
{
  NSString *sid = string_with_cstring(cSid);
  NSString *imageName = string_with_cstring(cImageName);
  NSString *highlighted = string_with_cstring(cHighlighted);
  [AMoAdInterstitial setLinkButtonWithSid:sid image:[UIImage imageNamed:imageName] highlighted:[UIImage imageNamed:highlighted]];
}

void AMoAdCocos2dxModule::setInterstitialCloseButton(const char *cSid, const char *cImageName, const char *cHighlighted)
{
  NSString *sid = string_with_cstring(cSid);
  NSString *imageName = string_with_cstring(cImageName);
  NSString *highlighted = string_with_cstring(cHighlighted);
  [AMoAdInterstitial setCloseButtonWithSid:sid image:[UIImage imageNamed:imageName] highlighted:[UIImage imageNamed:highlighted]];
}

void AMoAdCocos2dxModule::showInterstitialAd(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  [AMoAdInterstitial showAdWithSid:sid completion:nil];
}

void AMoAdCocos2dxModule::closeInterstitialAd(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  [AMoAdInterstitial closeAdWithSid:sid];
}

void AMoAdCocos2dxModule::setDefaultImageName(const char *cSid, const char *cImageName)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (cImageName) {
    NSString *imageName = string_with_cstring(cImageName);
    amoadView.image = [UIImage imageNamed:imageName];
  }
}

void AMoAdCocos2dxModule::setRotateTransition(const char *cSid, AMoAdCocos2dxModule::RotateTransition rotateTrans)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (amoadView) {
    amoadView.rotateTransition = AMoAdRotateTransition(rotateTrans);
  }
}

void AMoAdCocos2dxModule::setClickTransition(const char *cSid, AMoAdCocos2dxModule::ClickTransition clickTrans)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (amoadView) {
    amoadView.clickTransition = AMoAdClickTransition(clickTrans);
  }
}

void AMoAdCocos2dxModule::show(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (amoadView) {
    [amoadView show];
  }
}

void AMoAdCocos2dxModule::hide(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (amoadView) {
    [amoadView hide];
  }
}

void AMoAdCocos2dxModule::dispose(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  AMoAdView *amoadView = find_amoad_view(sid);
  if (amoadView) {
    [amoadView removeFromSuperview];
  }
}

void AMoAdCocos2dxModule::setInterstitialAutoReload(const char *cSid, bool autoReload)
{
  NSString *sid = string_with_cstring(cSid);
  [AMoAdInterstitial setAutoReloadWithSid:sid autoReload:autoReload];
}

void AMoAdCocos2dxModule::loadInterstitialAd(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  [AMoAdInterstitial loadAdWithSid:sid completion:nil];
}

bool AMoAdCocos2dxModule::isLoadedInterstitialAd(const char *cSid)
{
  NSString *sid = string_with_cstring(cSid);
  return [AMoAdInterstitial isLoadedAdWithSid:sid];
}
