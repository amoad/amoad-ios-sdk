//
//  InfeedViewController.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/02.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "InfeedViewController.h"
#import "AMoAdSdk/AMoAdInfeed.h"

@interface UserItem : NSObject
@property (nonatomic,readwrite,assign) NSInteger index;
@property (nonatomic,readwrite,strong) NSURL *iconUrl;
@property (nonatomic,readwrite,copy) NSString *text1;
@property (nonatomic,readwrite,copy) NSString *text2;
@property (nonatomic,readwrite,copy) NSString *text3;
@property (nonatomic,readwrite,strong) AMoAdItem *adItem;
@end
@implementation UserItem
- (instancetype)initWithAMoAd:(AMoAdItem *)adItem {
    self = [super init];
    if (self) {
        self.index = -1;
        self.iconUrl = [NSURL URLWithString:adItem.iconUrl];
        self.text1 = adItem.serviceName;
        self.text2 = adItem.titleShort;
        self.text3 = adItem.titleLong;
        self.adItem = adItem;
    }
    return self;
}
@end

@interface InfeedViewController() <UITableViewDataSource, UITableViewDelegate>
@property NSArray<UserItem *> *items;
@property int itemNo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString *const kUserTableViewCell = @"UserTableViewCell";
@implementation InfeedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [AMoAdInfeed setNetworkTimeoutMillis:5000];
    [self initTableView];
    [self addItems];
}

- (void)addItems {
    [self addItems:nil];
}

- (void)addItems:(void(^)()) completion {
    [self loadItems:^(NSArray<UserItem *> *newItems) {
        if(newItems.count > 0) {
            self.items = [self.items arrayByAddingObjectsFromArray:newItems];
            [self.tableView reloadData];
        }
        if (completion){
            completion();
        }
    }];
}

- (void)addItemIfNeeded:(NSIndexPath *) indexPath {
    if (indexPath.row >= self.items.count - 1) {
        [self addItems];
    }
}

- (NSArray<UserItem *> *)mergeAd:(NSArray<UserItem *> *) userItems adList:(AMoAdList *) adList {
    NSMutableArray<UserItem *> *merged = [[NSMutableArray alloc] initWithArray:userItems];
    int adIndex = 0;
    for (int i = 0;i < userItems.count;i++) {
        if (i == adList.beginIndex || (i > adList.beginIndex && (i - adList.beginIndex) % adList.interval == 0)) {
            UserItem *item = [[UserItem alloc]initWithAMoAd:adList.ads[adIndex]];
            adIndex += 1;
            [merged insertObject:item atIndex:i];
        }
        if (adIndex >= adList.ads.count) {
            break;
        }
    }
    return merged;
}

- (void)loadItems:(void (^)(NSArray<UserItem *> *items)) completion {
    //use background thread
    dispatch_async(dispatch_queue_create("com.amoad.queue.UserItems", nil), ^{
        NSArray<UserItem *> *newUserItems = [self createItems];
        if(newUserItems.count > 0) {

            [AMoAdInfeed loadWithSid:self.sid completion:^(AMoAdList *adList, AMoAdResult result) {
                NSArray<UserItem *> *mergedItems;
                if (result == AMoAdResultSuccess && adList.ads.count != 0) {
                    mergedItems = [self mergeAd:newUserItems adList:adList];
                } else {
                    mergedItems = newUserItems;
                }
                //user main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(mergedItems);
                });
            }];
        }
    });
}

- (void)loadImage:(NSURL *)url completion:(void (^)(UIImage *image))completion {
    dispatch_async(dispatch_queue_create("com.amoad.sample.IconLoadQueue", nil), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *image = nil;
            if (!error && response && data) {
                image = [UIImage imageWithData:data];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
            
        }];
        [dataTask resume];
    });
}

- (NSArray<UserItem *> *)createItems{
    int start = self.itemNo;
    int end = self.itemNo + 10;
    NSMutableArray<UserItem*> *items = [[NSMutableArray<UserItem*> alloc]init];
    for (int i = start; i < end; i++) {
        UserItem *item = [[UserItem alloc]init];
        item.index = i - 1;
        item.text1 = [NSString stringWithFormat:@"タイトル[%d]", i];
        item.text2 = [NSString stringWithFormat:@"本文１[%d]", i];
        item.text3 = [NSString stringWithFormat:@"本文２[%d]", i];
        [items addObject:item];
    }
    self.itemNo = end;
    return items;
}

- (void)initTableView {
    self.items = [[NSArray alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:kUserTableViewCell bundle:nil] forCellReuseIdentifier:kUserTableViewCell];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)onRefresh:(UIRefreshControl *) refreshControl {
    [refreshControl beginRefreshing];
    self.itemNo = 1;
    self.items = [[NSArray alloc]init];
    [self addItems:^{
        [refreshControl endRefreshing];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)NSIndexPath {
    return 116;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserItem *item = self.items[indexPath.row];
    if (item.adItem) {
        [item.adItem onClick];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserTableViewCell forIndexPath:indexPath];
    UIImageView *iconView = (UIImageView *)[cell viewWithTag:10];
    UILabel *label1 = (UILabel *)[cell viewWithTag:20];
    UILabel *label2 = (UILabel *)[cell viewWithTag:30];
    UILabel *label3 = (UILabel *)[cell viewWithTag:40];
    
    // データを表示する
    UserItem *item = self.items[indexPath.row];
    label1.text = item.text1;
    label2.text = item.text2;
    label3.text = item.text3;
    iconView.image = nil;
    
    if (item.adItem) {
        [self loadImage:item.iconUrl completion:^(UIImage *icon) {
            if ([label1.text isEqualToString:item.text1] &&
                [label2.text isEqualToString:item.text2] &&
                [label3.text isEqualToString:item.text3] &&
                iconView.image == nil) {  // リサイクルされていないか確認する
                iconView.image = icon;
            }
        }];
    } else {
        NSString *resoucePath = [[NSBundle mainBundle] pathForResource:@"item" ofType:@"png"];
        iconView.image = [[UIImage alloc]initWithContentsOfFile:resoucePath];
    }

    [AMoAdInfeed setViewabilityTrackingCell:cell adItem:item.adItem];
    [self addItemIfNeeded:indexPath];
    return cell;
}

@end

