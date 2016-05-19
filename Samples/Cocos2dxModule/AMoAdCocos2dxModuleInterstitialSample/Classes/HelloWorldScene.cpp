#include "HelloWorldScene.h"
#include "AMoAdCocos2dxModule.h"  // [SDK] Cocos2d-xモジュール

USING_NS_CC;

#define SID "管理画面から発行されるsidを設定してください"
#define PANEL_IMAGE_NAME "パネルに使用する画像ファイル名"

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !Layer::init() )
    {
        return false;
    }
    
    Size visibleSize = Director::getInstance()->getVisibleSize();
    Vec2 origin = Director::getInstance()->getVisibleOrigin();

    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    auto closeItem = MenuItemImage::create(
                                           "CloseNormal.png",
                                           "CloseSelected.png",
                                           CC_CALLBACK_1(HelloWorld::menuCloseCallback, this));
    
	closeItem->setPosition(Vec2(origin.x + visibleSize.width - closeItem->getContentSize().width/2 ,
                                origin.y + closeItem->getContentSize().height/2));

    // create menu, it's an autorelease object
    auto menu = Menu::create(closeItem, NULL);
    menu->setPosition(Vec2::ZERO);
    this->addChild(menu, 1);

    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label
    
    auto label = Label::createWithTTF("Cocos2dx Interstitial AD", "fonts/Marker Felt.ttf", 16);
    
    // position the label on the center of the screen
    label->setPosition(Vec2(origin.x + visibleSize.width/2,
                            origin.y + visibleSize.height - label->getContentSize().height));

    // add the label as a child to this layer
    this->addChild(label, 1);
#if 0
    // add "HelloWorld" splash screen"
    auto sprite = Sprite::create("HelloWorld.png");

    // position the sprite on the center of the screen
    sprite->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));

    // add the sprite as a child to this layer
    this->addChild(sprite, 0);
#endif

    //Register
    auto registerLabel = Label::createWithSystemFont("Register", "Arial", 9);
    auto registerBtnItem = MenuItemLabel::create(registerLabel, [this](Ref *sender){
      AMoAdCocos2dxModule::registerInterstitialAd(SID, 30 * 1000);
      //AMoAdCocos2dxModule::setInterstitialPortraitPanel(SID, PANEL_IMAGE_NAME);
    });
    registerBtnItem->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));

    //Load
    auto loadLabel = Label::createWithSystemFont("Load", "Arial", 9);
    auto loadBtnItem = MenuItemLabel::create(loadLabel, [this](Ref *sender){
      AMoAdCocos2dxModule::loadInterstitialAd(SID);
    });
    loadBtnItem->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y - 20));

    //ShowIfLoaded
    auto showLabel = Label::createWithSystemFont("Show", "Arial", 9);
    auto showBtnItem = MenuItemLabel::create(showLabel, [this](Ref *sender){
      if(AMoAdCocos2dxModule::isLoadedInterstitialAd(SID)){
        AMoAdCocos2dxModule::showInterstitialAd(SID);
      }
    });
    showBtnItem->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y - 20 - 20));

    //AutoReloadDisable
    auto disableLabel = Label::createWithSystemFont("AutoReloadDisable", "Arial", 9);
    auto disableBtnItem = MenuItemLabel::create(disableLabel, [this](Ref *sender){
      AMoAdCocos2dxModule::setInterstitialAutoReload(SID, false);
    });
    disableBtnItem->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y - 20 - 20 - 20));

    //AutoReload
    auto enableLabel = Label::createWithSystemFont("AutoReload", "Arial", 9);
    auto enableBtnItem = MenuItemLabel::create(enableLabel, [this](Ref *sender){
      AMoAdCocos2dxModule::setInterstitialAutoReload(SID, true);
    });
    enableBtnItem->setPosition(Vec2(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y - 20 - 20 - 20 - 20));

    Menu* adMenu = Menu::create(registerBtnItem, loadBtnItem, showBtnItem, disableBtnItem, enableBtnItem, NULL);
    adMenu->setPosition(Point::ZERO);
    this->addChild(adMenu);

    return true;
}


void HelloWorld::menuCloseCallback(Ref* pSender)
{
    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
