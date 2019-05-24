//
//  Function.m
//  NSSearchTableSample
//
//  Created by HIROKI IKEUCHI on 2019/05/24.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "Function.h"

@implementation Function
/**
 @brief     テキストファイルを読み込んで内容を配列で返す
 @param     sourceUrl テキストファイルのパスURL
 @return    行区切りの配列
 */
+ (NSArray *)loadFile:(NSURL *)sourceUrl {
    NSError  *loadError = nil;
    // ファイルの生データ
    NSString *source = [[NSString alloc] initWithContentsOfURL:sourceUrl
                                                      encoding:NSUTF8StringEncoding
                                                         error:&loadError];
    if (loadError) {
        NSLog(@"%@", [loadError localizedDescription]);
        return [NSArray array];
    }
    NSMutableArray *contents = [NSMutableArray array];     // return value
    [source enumerateLinesUsingBlock:^(NSString *line, BOOL * _Nonnull stop) {
        [contents addObject:line];
    }];
    return contents;
}
@end
