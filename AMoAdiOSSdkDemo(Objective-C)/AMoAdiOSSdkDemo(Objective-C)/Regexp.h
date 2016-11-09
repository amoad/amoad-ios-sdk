//
//  Regexp.h
//  AMoAdiOSSdkDemo(Object-C)
//
//  Created by AMoAd on 2016/09/06.
//  Copyright © 2016年 AMoAd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regexp : NSObject
- (id)init:(NSString *)pattern;
- (Boolean)isMatch:(NSString *)input;
@end
