//
//  ViewController.m
//  AMoAdNativeListViewIconText
//
//  Created by AMoAd on 2015/01/26.
//  Copyright (c) 2015年 AMoAd, Inc. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdNativeView.h"
#import "AMoAdLogger.h"

static NSString *const kSid = @"管理画面から取得したリストビュー、アイコン画像＋テキストのsidを指定してください";
static NSString *const kTag = @"Ad01";
static NSString *const kNibName = @"AdIconTextTableViewCell";
static const NSInteger kBeginIndex = 2; // アプリリリース時は管理画面と同じ値を指定することを推奨します（0以上）
static const NSInteger kInterval = 4; // アプリリリース時は管理画面と同じ値を指定することを推奨します（2以上、もしくは、0:繰り返さない）


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AMoAdNativeListViewDelegate>
@property (nonatomic,readwrite,weak) IBOutlet UITableView *tableView;
@property (nonatomic,readwrite,strong) NSArray *tableArray;
@property (nonatomic,readwrite,assign) NSInteger contentNo;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDL] ロガーの設定
  [AMoAdLogger sharedLogger].logging = YES; // YES...ログを出力する
  [AMoAdLogger sharedLogger].onLogging = ^(NSString *message, NSError *error) { // 出力方法をカスタマイズ（オプショナル）
    NSLog(@"【%@】%@:%@", [[NSBundle mainBundle] bundleIdentifier], message, error);
  };
  [AMoAdLogger sharedLogger].trace = YES; // YES...トレースを出力する
  [AMoAdLogger sharedLogger].onTrace = ^(NSString *message, NSObject *target) { // 出力方法をカスタマイズ（オプショナル）
    NSLog(@"【%@】%@:%@", [[NSBundle mainBundle] bundleIdentifier], message, target);
  };
  // [SDK] 広告準備（prepareAd）
  [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:kSid
                                         defaultBeginIndex:kBeginIndex
                                           defaultInterval:kInterval
                                            iconPreloading:YES];
  // [SDK] 広告登録（registerTableView）
  [[AMoAdNativeViewManager sharedManager] registerTableView:self.tableView sid:kSid tag:kTag nibName:kNibName];

  // コンテンツ生成
  self.contentNo = 0;
  NSArray *originalArray = [self createContents];

  [self.tableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCell"];

  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
  [self.tableView addSubview:refreshControl];

  // [SDK] 広告取得（arrayWithSid）
  self.tableArray = [[AMoAdNativeViewManager sharedManager] arrayWithSid:kSid
                                                                     tag:kTag
                                                           originalArray:originalArray];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = nil;
  if ([self.tableArray[indexPath.row] isKindOfClass:[AMoAdNativeViewItem class]]) {
    // [SDK] 広告取得（tableViewCell）
    AMoAdNativeViewItem *item = self.tableArray[indexPath.row];
    cell = [item tableView:tableView cellForRowAtIndexPath:indexPath delegate:self];
  } else {
    // コンテンツセル
    cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    [label setText:self.tableArray[indexPath.row]];
  }
  if (indexPath.row >= self.tableArray.count - 1) {
    [self onAdd];
  }
  return cell;
}

- (void)onAdd {
  // コンテンツ追加
  NSArray *addingArray = [self createContents];
  NSArray *newArray = [self.tableArray arrayByAddingObjectsFromArray:addingArray];

  // [SDK] 広告追加（array）
  self.tableArray = [[AMoAdNativeViewManager sharedManager] arrayWithSid:kSid
                                                                     tag:kTag
                                                           originalArray:newArray];
  [self.tableView reloadData];
}

- (void)onRefresh:(UIRefreshControl *)refreshControl {
  [refreshControl beginRefreshing];

  // [SDK] 広告更新（array）
  [[AMoAdNativeViewManager sharedManager] updateAdWithSid:kSid tag:kTag];

  [refreshControl endRefreshing];
  [self.tableView reloadData];
}

- (NSArray *)createContents {
  NSMutableArray *contents = [@[] mutableCopy];
  for (NSInteger i = 0; i < 20; i++, self.contentNo++) {
    [contents addObject:[NSString stringWithFormat:@"ユーザデータ（%ld）", (long)self.contentNo]];
  }
  return contents;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


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
