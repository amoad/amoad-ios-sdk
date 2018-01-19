//
//  TableViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/12.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "ListViewTVController.h"
#import "AMoAdNativeView.h"

@interface ListViewTVController () <UITableViewDataSource, UITableViewDelegate, AMoAdNativeListViewDelegate>
@property int itemNo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray* items;
@end

@implementation ListViewTVController
static NSString *kUserTableViewCell = @"UserTableViewCell";
static NSString *kAdTableViewCell = @"AdTableViewCell";
static NSString *kTag = @"ad001";
static int kBeginIndex = 2;
static int kInterval = 4;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initAd];
    [self addItems];
}

- (void)initTableView {
    self.items = @[];
    self.items = [[NSArray alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:kUserTableViewCell bundle:nil] forCellReuseIdentifier:kUserTableViewCell];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}
- (void)initAd {
    self.itemNo = 1;
    [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:self.sid defaultBeginIndex:kBeginIndex defaultInterval:kInterval iconPreloading:true];
    [[AMoAdNativeViewManager sharedManager] registerTableView:self.tableView sid:self.sid tag:kTag nibName:kAdTableViewCell
     ];
}
- (void)updateAd {
    [[AMoAdNativeViewManager sharedManager] updateAdWithSid:self.sid tag:kTag];
}

- (void)onRefresh:(UIRefreshControl *)refreshControl {
    [refreshControl beginRefreshing];
    self.itemNo = 1;
    self.items = @[];
    [self updateAd];
    [self addItems];
    [refreshControl endRefreshing];
}
- (void)addItems {
    NSArray *newItems = [self createItems];
    NSArray *mergedItems = [self.items arrayByAddingObjectsFromArray:newItems];
    self.items = [[AMoAdNativeViewManager sharedManager] arrayWithSid:self.sid tag:kTag originalArray:mergedItems];
    [self.tableView reloadData];
}

- (NSArray *)createItems {
    int start = self.itemNo;
    int end = self.itemNo + 10;
    NSMutableArray *items = [[NSMutableArray alloc]init];
    for(int i = start; i < end; i++) {
        NSString *item = @"ユーザデータ-";
        [items addObject:item];
    }
    return items;
}

- (void) addItemsIfNeeded:(NSIndexPath*)indexPath {
    if(indexPath.row >= self.items.count -1) {
        [self addItems];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)NSIndexPath {
    return 116;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // データを表示する
    NSObject *item = self.items[indexPath.row];
    if([item isKindOfClass:AMoAdNativeViewItem.self]) {
        AMoAdNativeViewItem *adItem = (AMoAdNativeViewItem *)item;
        cell = [adItem tableView:tableView cellForRowAtIndexPath:indexPath delegate:self];
    } else {
        NSString *userItem = (NSString *)item;
        cell = [tableView dequeueReusableCellWithIdentifier:kUserTableViewCell forIndexPath:indexPath];
        UIImageView *iconView = (UIImageView *)[cell viewWithTag:10];
        UILabel *label1 = (UILabel *)[cell viewWithTag:11];
        iconView.image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"item" ofType:@"png"]];
        label1.text = userItem;
    }
    [self addItemsIfNeeded:indexPath];
    return cell;
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
