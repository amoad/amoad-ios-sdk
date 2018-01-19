//
//  CollectionViewIconTextViewController.m
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2015/04/22.
//  Copyright (c) 2015年 AMoAd. All rights reserved.
//
#import "CollectionViewIconTextViewController.h"
#import "AMoAdNativeView.h"
#import "AMoAdLogger.h"

static NSString *const kSid = @"管理画面から取得したリストビュー、アイコン画像＋テキストのsidを指定してください";
static NSString *const kTag = @"Ad01";
static NSString *const kNibName = @"AdIconTextCollectionViewCell";
static const NSInteger kBeginIndex = 2; // アプリリリース時は管理画面と同じ値を指定することを推奨します（0以上）
static const NSInteger kInterval = 4; // アプリリリース時は管理画面と同じ値を指定することを推奨します（2以上、もしくは、0:繰り返さない）

@interface CollectionViewIconTextViewController () <UICollectionViewDataSource, UICollectionViewDelegate, AMoAdNativeListViewDelegate>
@property (nonatomic,readwrite,weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic,readwrite,strong) NSArray *collectionArray;
@property (nonatomic,readwrite,assign) NSInteger contentNo;
@end

@implementation CollectionViewIconTextViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDK] 広告準備（prepareAd）
  [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:kSid defaultBeginIndex:kBeginIndex defaultInterval:kInterval iconPreloading:YES];

  // [SDK] 広告View登録（registerCollectionView）
  [[AMoAdNativeViewManager sharedManager] registerCollectionView:self.collectionView sid:kSid tag:kTag nibName:kNibName];

  // ユーザView登録、コンテンツ生成、
  [self.collectionView registerNib:[UINib nibWithNibName:@"UserCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"UserCell"];

  self.contentNo = 0;
  NSArray *originalArray = [self createContents];

  // [SDK] 広告取得（arrayWithSid）
  self.collectionArray = [[AMoAdNativeViewManager sharedManager] arrayWithSid:kSid tag:kTag originalArray:originalArray];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (NSArray *)createContents {
  NSMutableArray *contents = [@[] mutableCopy];
  for (NSInteger i = 0; i < 20; i++, self.contentNo++) {
    [contents addObject:[NSString stringWithFormat:@"ユーザデータ（%ld）", (long)self.contentNo]];
  }
  return contents;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  if ([self.collectionArray[indexPath.row] isKindOfClass:[AMoAdNativeViewItem class]]) {
    // [SDK] 広告取得（collectionViewCell）
    AMoAdNativeViewItem *item = self.collectionArray[indexPath.row];
    return [item collectionView:collectionView cellForItemAtIndexPath:indexPath delegate:self];
  } else {
    // コンテンツセル
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    [label setText:self.collectionArray[indexPath.row]];
    return cell;
  }
}



#pragma mark - AMoAdNativeListViewDelegate
- (void)amoadNativeDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view indexPath:(NSIndexPath *)indexPath state:(AMoAdResult)state {
  NSLog(@"amoadNativeDidReceive:%@ tag:%@ view:%@ indexPath:%@ state:%ld", sid, tag, view, indexPath, (long)state);
}

- (void)amoadNativeIconDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view indexPath:(NSIndexPath *)indexPath state:(AMoAdResult)state {
  NSLog(@"amoadNativeIconDidReceive:%@ tag:%@ view:%@ indexPath:%@ state:%ld", sid, tag, view, indexPath, (long)state);
}

- (void)amoadNativeImageDidReceive:(NSString *)sid tag:(NSString *)tag view:(UIView *)view indexPath:(NSIndexPath *)indexPath state:(AMoAdResult)state {
  NSLog(@"amoadNativeImageDidReceive:%@ tag:%@ view:%@ indexPath:%@ state:%ld", sid, tag, view, indexPath, (long)state);
}

- (void)amoadNativeDidClick:(NSString *)sid tag:(NSString *)tag view:(UIView *)view indexPath:(NSIndexPath *)indexPath {
  NSLog(@"amoadNativeDidClick:%@ tag:%@ view:%@ indexPath:%@", sid, tag, view, indexPath);
}

@end
