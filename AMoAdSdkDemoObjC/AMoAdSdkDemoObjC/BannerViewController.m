//
//  BannerViewController.m
//  AMoAdSdkDemoObjC
//
//  Copyright © 2020 CA Wise, Inc. All rights reserved.
//

#import "BannerViewController.h"
#import "AMoAdSdkDemoObjC-Swift.h"

@interface BannerViewController () <AMoAdViewDelegateW>

@property (nonatomic, retain) AMoAdViewW *amoadView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.amoadView = [[AMoAdViewW alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 320) / 2, (self.view.frame.size.height - 50) / 2, 320, 50)];
  self.amoadView.sid = @"管理画面から発行されるSIDを設定してください";
  self.amoadView.delegate = self;
  [self.view addSubview:self.amoadView];
}

- (void) amoadViewDidReceiveAdWithView:(AMoAdViewW *)view {
  NSLog(@"%@", @"amoadViewDidReceiveAdWithView");
}

- (void) amoadViewDidFailToReceiveAdWithError:(NSError *)error {
  NSLog(@"%@", @"amoadViewDidFailToReceiveAdWithError");
}

- (void) amoadViewDidReceiveEmptyAdWithView:(AMoAdViewW *)view {
  NSLog(@"%@", @"amoadViewDidReceiveEmptyAdWithView");
}

- (void) amoadViewDidClickWithView:(AMoAdViewW *)view {
  NSLog(@"%@", @"amoadViewDidClickWithView");
}

- (void) amoadViewWillClickBackWithView:(AMoAdViewW *)view {
  NSLog(@"%@", @"amoadViewWillClickBackWithView");
}

- (void) amoadViewDidClickBackWithView:(AMoAdViewW *)view {
  NSLog(@"%@", @"amoadViewDidClickBackWithView");
}

@end
