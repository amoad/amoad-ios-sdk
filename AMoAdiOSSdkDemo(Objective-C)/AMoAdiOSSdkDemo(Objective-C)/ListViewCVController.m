//
//  ListViewCVViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/20.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "ListViewCVController.h"
#import "AMoAdNativeView.h"

@interface ListViewCVController () <UICollectionViewDataSource, UICollectionViewDelegate, AMoAdNativeListViewDelegate>
@property int itemNo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray* items;
@end

@implementation ListViewCVController
static NSString *kUserCollectionViewCell = @"UserCollectionViewCell";
static NSString *kAdCollectionViewCell = @"AdCollectionViewCell";
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
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kUserCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kUserCollectionViewCell];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
}
- (void)initAd {
    self.itemNo = 1;
    [[AMoAdNativeViewManager sharedManager] prepareAdWithSid:self.sid defaultBeginIndex:kBeginIndex defaultInterval:kInterval iconPreloading:true];
    [[AMoAdNativeViewManager sharedManager] registerCollectionView:self.collectionView sid:self.sid tag:kTag nibName:kAdCollectionViewCell];
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
    [self.collectionView reloadData];
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

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)NSIndexPath {
    return 116;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    // データを表示する
    NSObject *item = self.items[indexPath.row];
    if([item isKindOfClass:AMoAdNativeViewItem.self]) {
        AMoAdNativeViewItem *adItem = (AMoAdNativeViewItem *)item;
        cell = [adItem collectionView:collectionView cellForItemAtIndexPath:indexPath delegate:self];
    } else {
        NSString *userItem = (NSString *)item;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserCollectionViewCell forIndexPath:indexPath];
        UIImageView *iconView = (UIImageView *)[cell viewWithTag:10];
        UILabel *label1 = (UILabel *)[cell viewWithTag:11];
        iconView.image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"item" ofType:@"png"]];
        label1.text = userItem;
    }
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
