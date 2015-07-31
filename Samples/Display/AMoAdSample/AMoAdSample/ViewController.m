//
//  ViewController.m
//  AMoAdSample
//
//  Created by AMoAdGeek on 2014/09/12.
//  Copyright (c) 2014年 AMoAd, Inc. All rights reserved.
//

#import "ViewController.h"
#import "AMoAdView.h"

@interface ViewController () <AMoAdViewDelegate>
@property (weak, nonatomic) IBOutlet AMoAdView *amoadView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.amoadView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AMoAdViewDidReceiveAd:(AMoAdView *)amoadView {
    NSLog(@"正常に広告を受信した");
}

- (void)AMoAdViewDidFailToReceiveAd:(AMoAdView *)amoadView error:(NSError *)error {
    NSLog(@"広告の取得に失敗した");
}

- (void)AMoAdViewDidReceiveEmptyAd:(AMoAdView *)amoadView {
    NSLog(@"空の広告を受信した");
}

@end
