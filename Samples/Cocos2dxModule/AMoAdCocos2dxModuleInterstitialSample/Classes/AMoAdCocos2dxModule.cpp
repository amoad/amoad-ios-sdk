//
//  AMoAdCocos2dxModule.cpp
//
//  Created by AMoAd on 2015/07/16.
//
#include "AMoAdCocos2dxModule.h"
#include <jni.h>
#include "platform/android/jni/JniHelper.h"

#define AMOAD_COCOS2DX_MODULE_CLASS_NAME "com/amoad/cocos2dx/AMoAdCocos2dxModule"

void AMoAdCocos2dxModule::registerInlineAd(const char *cSid, AMoAdCocos2dxModule::AdSize adSize,
  AMoAdCocos2dxModule::HorizontalAlign hAlign, AMoAdCocos2dxModule::VerticalAlign vAlign,
  AMoAdCocos2dxModule::AdjustMode adjustMode, int x/* = 0*/, int y/* = 0*/, int timeoutMillis)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "registerInlineAd", "(Ljava/lang/String;IIIIIII)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, int(adSize), int(hAlign), int(vAlign), int(adjustMode), x, y, timeoutMillis);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setDefaultImageName(const char *cSid, const char *cImageName)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setDefaultImageName", "(Ljava/lang/String;Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jstring imageName = jniMethodInfo.env->NewStringUTF(cImageName);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, imageName);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(imageName);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setRotateTransition(const char *cSid, AMoAdCocos2dxModule::RotateTransition rotateTrans)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setRotateTransition", "(Ljava/lang/String;I)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, int(rotateTrans));
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setClickTransition(const char *cSid, AMoAdCocos2dxModule::ClickTransition clickTrans)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setClickTransition", "(Ljava/lang/String;I)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, int(clickTrans));
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::show(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "show", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::hide(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "hide", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::dispose(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "dispose", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}


void AMoAdCocos2dxModule::registerInterstitialAd(const char *cSid, int timeoutMillis)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "registerInterstitialAd", "(Ljava/lang/String;I)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, timeoutMillis);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialDisplayClickable(const char *cSid, const bool clickable)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialDisplayClickable", "(Ljava/lang/String;Z)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, clickable);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialDialogShown(const char *cSid, const bool shown)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialDialogShown", "(Ljava/lang/String;Z)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, shown);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialPortraitPanel(const char *cSid, const char *cImageName)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialPortraitPanel", "(Ljava/lang/String;Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jstring imageName = jniMethodInfo.env->NewStringUTF(cImageName);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, imageName);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(imageName);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialLandscapePanel(const char *cSid, const char *cImageName)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialLandscapePanel", "(Ljava/lang/String;Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jstring imageName = jniMethodInfo.env->NewStringUTF(cImageName);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, imageName);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(imageName);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialLinkButton(const char *cSid, const char *cImageName, const char *cHighlighted)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialLinkButton", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jstring imageName = jniMethodInfo.env->NewStringUTF(cImageName);
    jstring highlighted = jniMethodInfo.env->NewStringUTF(cHighlighted);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, imageName, highlighted);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(imageName);
    jniMethodInfo.env->DeleteLocalRef(highlighted);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialCloseButton(const char *cSid, const char *cImageName, const char *cHighlighted)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialCloseButton", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jstring imageName = jniMethodInfo.env->NewStringUTF(cImageName);
    jstring highlighted = jniMethodInfo.env->NewStringUTF(cHighlighted);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, imageName, highlighted);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(imageName);
    jniMethodInfo.env->DeleteLocalRef(highlighted);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::showInterstitialAd(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "showInterstitialAd", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::closeInterstitialAd(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "closeInterstitialAd", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::setInterstitialAutoReload(const char *cSid, const bool autoReload)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "setInterstitialAutoReload", "(Ljava/lang/String;Z)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid, autoReload);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

void AMoAdCocos2dxModule::loadInterstitialAd(const char *cSid)
{
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "loadInterstitialAd", "(Ljava/lang/String;)V")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jniMethodInfo.env->CallStaticVoidMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
}

bool AMoAdCocos2dxModule::isLoadedInterstitialAd(const char *cSid)
{
  bool ret = false;
  cocos2d::JniMethodInfo jniMethodInfo;
  if (cocos2d::JniHelper::getStaticMethodInfo(jniMethodInfo, AMOAD_COCOS2DX_MODULE_CLASS_NAME, "isLoadedInterstitialAd", "(Ljava/lang/String;)Z")) {
    jstring sid = jniMethodInfo.env->NewStringUTF(cSid);
    jboolean isLoaded = (jboolean)jniMethodInfo.env->CallStaticBooleanMethod(jniMethodInfo.classID, jniMethodInfo.methodID, sid);
    ret = (isLoaded == JNI_TRUE);
    jniMethodInfo.env->DeleteLocalRef(sid);
    jniMethodInfo.env->DeleteLocalRef(jniMethodInfo.classID);
  }
  return ret;
}
