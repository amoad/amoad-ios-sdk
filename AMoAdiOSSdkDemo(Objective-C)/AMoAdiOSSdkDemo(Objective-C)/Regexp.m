//
//  Regexp.m
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/06.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import "Regexp.h"
@interface Regexp()
@property (nonatomic) NSString *pattern;
@end
@implementation Regexp

- (instancetype)init:(NSString *)pattern {
    if (self = [super init]) {
        self.pattern = pattern;
    }
    return self;
}

- (Boolean)isMatch:(NSString *)input {
    NSError* err = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:self.pattern options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult *match = [regex firstMatchInString:input options:0 range:NSMakeRange(0, input.length)];
    if (match) {
        return true;
    }
    return false;
}
@end
