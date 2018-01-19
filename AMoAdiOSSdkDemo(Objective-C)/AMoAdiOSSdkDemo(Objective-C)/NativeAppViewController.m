//
//  NativeAppViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/12.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "NativeAppViewController.h"
#import "AMoAdNativeView.h"

@interface NativeAppViewController () <AMoAdNativeAppDelegate>

@end

@implementation NativeAppViewController
static NSString *const kCell = @"AdViewCell";
static NSString *const kTag = @"ad01";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAd];
}

- (void)initAd {
    UIView *templateView = [[UINib nibWithNibName:kCell bundle:nil] instantiateWithOwner:self options:nil][0];
    [templateView setFrame:CGRectMake(0, 200, 320, 100)];
    
    [[AMoAdNativeViewManager sharedManager]prepareAdWithSid:self.sid iconPreloading:true imagePreloading:true];
    [[AMoAdNativeViewManager sharedManager]renderAdWithSid:self.sid tag:kTag view:templateView delegate:self];
    
    [self.view addSubview:templateView];
}

- (void)updateAd{
    [[AMoAdNativeViewManager sharedManager] updateAdWithSid:self.sid tag:kTag];
}

- (void)clearAd {
    [[AMoAdNativeViewManager sharedManager] clearAdWithSid:self.sid tag:kTag];
}

- (IBAction)onUpdateBtnClicked:(id)sender {
    [self updateAd];
}
- (IBAction)onClearBtnClicked:(id)sender {
    [self clearAd];
}

- (void)amoadNativeDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
    NSLog(@"amoadNativeDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeIconDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
    NSLog(@"amoadNativeIconDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeImageDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view state:(AMoAdResult)state {
    NSLog(@"amoadNativeImageDidReceive:%@ tag:%@ view:%@ state:%ld", sid, tag, view, (long)state);
}

- (void)amoadNativeDidClick:(NSString *)sid tag:(NSString *)tag view:(UIView *)view {
    NSLog(@"amoadNativeDidClick:%@ tag:%@ view:%@", sid, tag, view);
}
@end
