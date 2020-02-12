//
//  InfeedViewController.m
//  AMoAdSdkDemo
//
//  Created by AMoAd on 2018/10/09.
//  Copyright © 2018年 CA Wise Inc. All rights reserved.
//

#import "InfeedViewController.h"
#import <AMoAd/AMoAdInfeed.h>
#import <AMoAd/AMoAdLogger.h>

#pragma mark - 画像ロードUtility

@interface ImageLoader : NSObject
@end

@implementation ImageLoader

// ユーザーデータと広告で同じ画像ロードの仕組みを使う
+ (void)loadImage:(NSURL *)url completion:(void (^)(UIImage *image))completion {
    static dispatch_queue_t imageLoadQueue;
    imageLoadQueue = dispatch_queue_create("com.amoad.sample.IconLoadQueue", NULL);
    
    dispatch_async(imageLoadQueue, ^{
        UIImage *image = nil;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (!error && response && data) {
            image = [UIImage imageWithData:data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    });
}

@end

#pragma mark - ユーザーデータ例

@interface UserItem : NSObject
@property (nonatomic,readwrite,assign) NSInteger index;
@property (nonatomic,readwrite,strong) NSURL *iconUrl;
@property (nonatomic,readwrite,copy) NSString *text1;
@property (nonatomic,readwrite,copy) NSString *text2;
@property (nonatomic,readwrite,copy) NSString *text3;
@property (nonatomic,readwrite,strong) AMoAdItem *adItem;
@end

@implementation UserItem
// AMoAdItem -> UserItem 変換
- (instancetype)initWithAMoAd:(AMoAdItem *)amoad {
    self = [super init];
    if (self) {
        self.index = -1;
        self.iconUrl = [NSURL URLWithString:amoad.iconUrl];
        self.text1 = amoad.serviceName;
        self.text2 = amoad.titleShort;
        self.text3 = amoad.titleLong;
        self.adItem = amoad;
    }
    return self;
}

// ネットワークまたはローカルキャッシュからユーザーデータを読み込む
+ (void)loadUserItem:(NSInteger)count completion:(void (^)(NSArray<UserItem *> *userItems))completion {
    static dispatch_queue_t userItemLoadQueue;
    userItemLoadQueue = dispatch_queue_create("com.amoad.sample.UserItemLoadQueue", NULL);
    
    dispatch_async(userItemLoadQueue, ^{
        NSDate* localNow = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
        NSMutableArray<UserItem *> *userItems = [[NSMutableArray alloc] initWithCapacity:count];
        static NSInteger dataCount = 0;
        for (NSInteger i = 0; i < count; i++) {
            UserItem *ud = [[UserItem alloc] init];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"png"];
            ud.index = dataCount;
            ud.iconUrl = [NSURL fileURLWithPath:filePath];
            ud.text1 = [NSString stringWithFormat:@"タイトル%ld", (long)dataCount];
            ud.text2 = [NSString stringWithFormat:@"サブタイトル%ld", (long)dataCount];
            ud.text3 = [NSString stringWithFormat:@"%@", localNow];
            dataCount++;
            [userItems addObject:ud];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(userItems);
        });
    });
}

+ (UIImage *)setNumber:(NSInteger)number toImage:(UIImage *)image {
    NSString *text = [NSString stringWithFormat:@"%ld", (long)number];
    
    UIFont *font = [UIFont boldSystemFontOfSize:32];
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect: imageRect];
    
    CGRect textRect  = CGRectMake(5, 5, image.size.width - 5, image.size.height - 5);
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    NSDictionary *textFontAttributes =
    @{
      NSFontAttributeName: font,
      NSForegroundColorAttributeName: [UIColor whiteColor],
      NSParagraphStyleAttributeName: textStyle
      };
    NSMutableAttributedString *attrText =
    [[NSMutableAttributedString alloc] initWithString:text attributes:textFontAttributes];
    [attrText drawInRect:textRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

#pragma mark - InfeedViewController

@interface InfeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,readwrite,weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *adCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adView;
@property (nonatomic,readwrite,strong) AMoAdItem *adItem;
@property (nonatomic,readwrite,strong) NSArray<UserItem *> *dataArray;
@end

static NSString *const kSid1 = @"管理画面から発行されるSIDを設定してください"; // Infeed
static NSString *const kSid2 = @"管理画面から発行されるSIDを設定してください"; // Top banner (Infeed)

static const NSInteger kDataCount = 20;

@implementation InfeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [SDK Logger] ログ出力を設定する
    [AMoAdLogger sharedLogger].logging = YES;
    [AMoAdLogger sharedLogger].trace = YES;


    // [SDK] タイムアウト時間（ミリ秒）を設定する：デフォルトは30,000ミリ秒
    [AMoAdInfeed setNetworkTimeoutMillis:5000];
    
    // [SDK] テストのため広告リクエストサーバのURLを指定する
    //[AMoAdInfeed setAdRequestUrl:@"http://test-server.net/n/v1/"];
    
    // Top banner 初期表示を非表示にする
    self.adView.hidden = YES;
    
    
    // Top banner クリック処理を設定する
    self.adView.userInteractionEnabled = YES;
    [self.adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTopBannerTouch:)]];
    
    // [SDK Top banner]
    [AMoAdInfeed loadWithSid:kSid2 completion:^(AMoAdList *adList, AMoAdResult result) {
        if (result == AMoAdResultSuccess && adList.ads.count >= 1) {
            self.adItem = adList.ads[0];
            NSURL *url = [NSURL URLWithString:self.adItem.imageUrl];
            [ImageLoader loadImage:url completion:^(UIImage *image) {
                self.adView.image = image;
                self.adView.hidden = NO;
                [AMoAdInfeed setViewabilityTrackingCell:self.adView adItem:self.adItem];
            }];
        }
    }];
    
    // ユーザーCell
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCellId"];
    
    // PullToRefresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self onRefresh:refreshControl];
}

- (void)onRefresh:(UIRefreshControl *)refreshControl {
    [refreshControl beginRefreshing];
    
    [self addUserItem:kDataCount original:@[]];
    
    [refreshControl endRefreshing];
}

- (NSArray<UserItem *> *)insertAdList:(AMoAdList *)adList userItems:(NSArray<UserItem *> *)userItems {
    NSMutableArray<UserItem *> *array = [[NSMutableArray<UserItem *> alloc] initWithArray:userItems];
    
    // 広告データを挿入する
    NSInteger adIdx = 0;
    for (NSInteger i = 0; i < userItems.count; i++) {
        if (i == adList.beginIndex || (i > adList.beginIndex && (i - adList.beginIndex) % adList.interval == 0)) {
            UserItem *ud = [[UserItem alloc] initWithAMoAd:adList.ads[adIdx++]];
            [array insertObject:ud atIndex:i];
        }
        if (adIdx >= adList.ads.count) {
            break;
        }
    }
    
    return array;
}

- (void)addUserItem:(NSInteger)count original:(NSArray<UserItem *> *)original {
    // [SDK] 広告をロードする
    //  広告データをコールバックで返す
    [AMoAdInfeed loadWithSid:kSid1 completion:^(AMoAdList *adList, AMoAdResult result) {
        [self.adCountLabel setText:[@(adList.ads.count) stringValue]];  // LOG
        [self.beginIndexLabel setText:[@(adList.beginIndex) stringValue]];  // LOG
        [self.intervalLabel setText:[@(adList.interval) stringValue]];  // LOG
        
        // ユーザーデータを取得する
        [UserItem loadUserItem:count completion:^(NSArray<UserItem *> *userItems) {
            
            if (result == AMoAdResultSuccess) {
                // 広告データを挿入する
                NSArray<UserItem *> *array = [self insertAdList:adList userItems:userItems];
                self.dataArray = [original arrayByAddingObjectsFromArray:array];
            } else {
                self.dataArray = [original arrayByAddingObjectsFromArray:userItems];
            }
            
            // テーブルを再描画する
            [self.tableView reloadData];
        }];
    }];
}

- (void)onTopBannerTouch:(UITapGestureRecognizer*)sender {
    if (self.adItem) {
        [self.adItem onClickWithHandler:^(NSString *url) {
            [self sampleClickHandler:url];
        }];
    }
}

- (void)sampleClickHandler:(NSString *)url {
    if ([UIAlertController class]) {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@""
                                            message:@"遷移して詳細を確認しますか？"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    // ユーザーCell
    cell = [tableView dequeueReusableCellWithIdentifier:@"UserCellId" forIndexPath:indexPath];
    UIImageView *iconView = (UIImageView *)[cell viewWithTag:200];
    UILabel *label1 = (UILabel *)[cell viewWithTag:100];
    UILabel *label2 = (UILabel *)[cell viewWithTag:101];
    UILabel *label3 = (UILabel *)[cell viewWithTag:102];
    
    // データを表示する
    UserItem *ud = self.dataArray[indexPath.row];
    label1.text = ud.text1;
    label2.text = ud.text2;
    label3.text = ud.text3;
    iconView.image = nil;
    
    [ImageLoader loadImage:ud.iconUrl completion:^(UIImage *icon) {
        if ([label1.text isEqualToString:ud.text1] &&
            [label2.text isEqualToString:ud.text2] &&
            [label3.text isEqualToString:ud.text3] &&
            iconView.image == nil) {  // リサイクルされていないか確認する
            if (ud.index >= 0) {
                iconView.image = [UserItem setNumber:ud.index toImage:icon];  // ユーザーアイコンに番号を付ける
            } else {
                iconView.image = icon;
            }
        } else {
            NSLog(@"画像ロード中にViewがリサイクルされた（label1: %@ -> %@）", ud.text1, label1.text);
        }
    }];
    
    // [SDK] Imp/Vimpを送信する
    [AMoAdInfeed setViewabilityTrackingCell:cell adItem:ud.adItem];
    
    // 下までスクロールしたらデータを追加する
    if (indexPath.row >= self.dataArray.count - 1) {
        [self addUserItem:kDataCount original:self.dataArray];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
    UserItem *ud = self.dataArray[indexPath.row];
    
    if (ud.adItem) {
        // [SDK] クリック時： handlerに遷移処理を委ねる
        [ud.adItem onClickWithHandler:^(NSString *url) {
            [self sampleClickHandler:url];
        }];
    }
}

@end
