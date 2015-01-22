//
//  ViewController.m
//  AMoAdNativeListView
//
//  Created by AMoAd on 2015/01/22.
//  Copyright (c) 2015年 AMoAd, Inc. All rights reserved.
//
#import "ViewController.h"
#import "AMoAdNativeView.h" // [SDK] ネィティブ広告メインヘッダ

static NSString *const kSid = @"62056d310111552c9b3760c1d92edf92e63eee0faedb7a96c6065a969c0d297a";
static NSString *const kTag = @"IconText01";
static NSString *const kNibName = @"AdIconTextTableViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,readwrite,weak) IBOutlet UITableView *tableView;
@property (nonatomic,readwrite,strong) NSArray *tableArray;
@property (nonatomic,readwrite,assign) NSInteger contentNo;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // [SDK] prepareAd
  [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:kSid tag:kTag defaultBeginIndex:0 defaultInterval:5 iconPreloading:YES];

  // [SDK] registerTableView
  [[AMoAdNativeViewManager sharedManager] registerTableView:self.tableView sid:kSid tag:kTag nibName:kNibName];

  self.contentNo = 0;
  NSArray *originalArray = [self createContents];

  [self.tableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCell"];

  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
  [self.tableView addSubview:refreshControl];

  // [SDK] arrayWithSid
  self.tableArray = [[AMoAdNativeViewManager sharedManager] arrayWithSid:kSid tag:kTag originalArray:originalArray updateAd:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([self.tableArray[indexPath.row] isKindOfClass:[AMoAdNativeViewItem class]]) {
    // 広告セル
    AMoAdNativeViewItem *item = self.tableArray[indexPath.row];
    return [item tableView:tableView cellForRowAtIndexPath:indexPath];
  } else {
    // コンテンツセル
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    // （コンテンツを設定...）
    return cell;
  }
}

- (void)onRefresh:(UIRefreshControl *)refreshControl {
  [refreshControl beginRefreshing];

  NSArray *addingArray = [self createContents];
  NSArray *newArray = [self.tableArray arrayByAddingObjectsFromArray:addingArray];
  self.tableArray = [[AMoAdNativeViewManager sharedManager] arrayWithSid:kSid tag:kTag originalArray:newArray updateAd:YES];
  
  [refreshControl endRefreshing];
  [self.tableView reloadData];
}

- (NSArray *)createContents {
  NSMutableArray *contents = [@[] mutableCopy];
  for (NSInteger i; i < 20; i++, self.contentNo++) {
    [contents addObject:[NSString stringWithFormat:@"コンテンツ%ld", (long)self.contentNo]];
  }
  return contents;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
