//
//  AMoAdAnalytics.h
//
//  Created by AMoAd on 2015/07/17.
//
#import <Foundation/Foundation.h>

@interface AMoAdAnalytics : NSObject
@property (nonatomic,readwrite,strong) NSDictionary *publisherParam;
- (instancetype)initWithReportId:(NSString *)rid;
@end
