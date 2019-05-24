//
//  Function.h
//  NSSearchTableSample
//
//  Created by HIROKI IKEUCHI on 2019/05/24.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Function : NSObject
+ (NSArray *)loadFile:(NSURL *)sourceUrl; // テキストファイルを読み込んで内容を配列で返す
@end

NS_ASSUME_NONNULL_END
