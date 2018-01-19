//
//  MainTableViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/08/31.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "MainTableViewController.h"
#import "FormViewController.h"
#import "AMoAdLogger.h"

@interface MainTableViewController ()
@property NSString *nextSegue;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMoAdLogger sharedLogger].logging = YES;
    [AMoAdLogger sharedLogger].trace = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.nextSegue = [self indexPathToNextSegue:indexPath];
    if (self.nextSegue) {
        [self performSegueWithIdentifier:@"form" sender:nil];
    }
}

- (NSString *)indexPathToNextSegue:(NSIndexPath *) indexPath {
    switch (indexPath.row) {
        case 0:
            return @"display";
        case 1:
            return @"interstitial";
        case 2:
            return @"infeed";
        case 3:
            return @"nativehtml";
        case 4:
            return @"screen";
        case 5:
            return @"nativeapp";
        case 6:
            return @"tableview";
        case 7:
            return @"collectionview";
        default:
            return nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"form" isEqualToString:segue.identifier]){
        FormViewController *vc = [segue destinationViewController];
        vc.nextSegue = self.nextSegue;
    }
}


@end
