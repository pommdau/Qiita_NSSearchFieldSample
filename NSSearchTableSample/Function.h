//  Function.h
//  NSSearchTableSample

#import <Foundation/Foundation.h>

@interface Function : NSObject
+ (NSArray *)loadFile:(NSURL *)sourceUrl; // テキストファイルを読み込んで内容を配列で返す
@end
