//
//  FormViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/08/31.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "FormViewController.h"
#import "DisplayViewController.h"
#import "InterstitialViewController.h"
#import "InfeedViewController.h"
#import "NativeHtmlViewController.h"
#import "ScreenViewController.h"
#import "NativeAppViewController.h"
#import "ListViewTVController.h"
#import "ListViewCVController.h"
#import "Regexp.h"

@interface FormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *sidField;
@property (weak, nonatomic) IBOutlet UILabel *errorMsg;
@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideErrorMsg];
}

- (IBAction)onSidChanged:(id)sender {
    [self hideErrorMsg];
}

- (void) showErrorMsg {
    self.errorMsg.hidden = false;
}

- (void) hideErrorMsg {
    self.errorMsg.hidden = true;
}

- (IBAction)onNextBtnClicked:(id)sender {
    if ([self validSid]) {
        [self performSegueWithIdentifier:self.nextSegue sender:nil];
    } else {
        [self showErrorMsg];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *sid = self.sidField.text;
    if ([@"display" isEqualToString:segue.identifier]){
        DisplayViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"interstitial" isEqualToString:segue.identifier]){
        InterstitialViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"infeed" isEqualToString:segue.identifier]){
        InfeedViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"nativehtml" isEqualToString:segue.identifier]){
        NativeHtmlViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"screen" isEqualToString:segue.identifier]){
        ScreenViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"nativeapp" isEqualToString:segue.identifier]){
        NativeAppViewController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"tableview" isEqualToString:segue.identifier]){
        ListViewTVController *vc = [segue destinationViewController];
        vc.sid = sid;
    } else if ([@"collectionview" isEqualToString:segue.identifier]){
        ListViewCVController *vc = [segue destinationViewController];
        vc.sid = sid;
    }
}

- (Boolean)validSid {
    NSString *sid = self.sidField.text;
    if (sid) {
        return [[[Regexp alloc]init:@"[a-f0-9]{64}"] isMatch:sid];
    }
    return false;
}

@end
