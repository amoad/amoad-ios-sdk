//
//  AMoAdNativeCocos2dxModule.mm
//
//  Created by AMoAd on 2016/02/01.
//
#import "AMoAdNativeCocos2dxModule.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AMoAdNative.h"


#pragma mark - Utilities

static UIViewController* get_view_controller() {
  UIWindow *mainWindow = ([UIApplication sharedApplication].windows)[0];
  return mainWindow.rootViewController;
}


#pragma mark - Implements

void AMoAdNativeCocos2dxModule::load(const char* cSid, const char* cTag, int x, int y, int width, int height)
{
  AMoAdNativeCocos2dxModule::load(cSid, cTag, x, y, width, height, "{}");
}

void AMoAdNativeCocos2dxModule::remove(const char* cSid, const char* cTag)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [[AMoAdNative viewWithSid:sid tag:tag] removeFromSuperview];
  [AMoAdNative disposeViewWithSid:sid tag:tag];
}

void AMoAdNativeCocos2dxModule::reload(const char* cSid, const char* cTag)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [AMoAdNative reloadWithSid:sid tag:tag];
}

void AMoAdNativeCocos2dxModule::show(const char* cSid, const char* cTag)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [AMoAdNative showWithSid:sid tag:tag];
}

void AMoAdNativeCocos2dxModule::hide(const char* cSid, const char* cTag)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [AMoAdNative hideWithSid:sid tag:tag];
}

void AMoAdNativeCocos2dxModule::startRotation(const char* cSid, const char* cTag, int seconds)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [AMoAdNative startRotationWithSid:sid tag:tag seconds:seconds];
}

void AMoAdNativeCocos2dxModule::stopRotation(const char* cSid, const char* cTag)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  [AMoAdNative stopRotationWithSid:sid tag:tag];
}

void AMoAdNativeCocos2dxModule::setHtmlUrlString(const char* cHtmlUrlString)
{
  NSString *htmlUrlString = @(cHtmlUrlString);
  [AMoAdNative setHtmlUrlString:htmlUrlString];
}

void AMoAdNativeCocos2dxModule::load(const char* cSid, const char* cTag, int x, int y, int width, int height, const char* cOption)
{
  NSString *sid = @(cSid);
  NSString *tag = @(cTag);
  NSString *option = @(cOption);
  NSData *data = [option dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error = nil;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
  if (error != nil) {
    dic = @{};
  }
  CGRect frame = CGRectMake(x, y, width, height);
  [AMoAdNative loadWithSid:sid tag:tag frame:frame completion:nil option:dic];
  [AMoAdNative hideWithSid:sid tag:tag];
  [get_view_controller().view addSubview:[AMoAdNative viewWithSid:sid tag:tag]];
}
