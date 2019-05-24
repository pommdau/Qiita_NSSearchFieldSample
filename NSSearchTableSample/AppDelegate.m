//
//  AppDelegate.m
//  NSSearchTableSample
//
//  Created by HIROKI IKEUCHI on 2019/05/24.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "AppDelegate.h"
#import "Function.h"

@interface AppDelegate ()
@property NSArray *allPokemonNames; // ポケモンの名前データ
@property NSArray *pokemonNames;    // テーブルビューに表示するポケモンのデータ
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)awakeFromNib {
    // 表示するデータを作成
    [self loadPokemonNames];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)loadPokemonNames {
    NSURL *pokemonList = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"PokemonList"];
    NSMutableArray *pokemonNames = [NSMutableArray arrayWithArray:[Function loadFile:pokemonList]];
    _allPokemonNames = [NSArray arrayWithArray:pokemonNames];
    _pokemonNames = [NSArray arrayWithArray:[self createListWithSearchWord:@"" list:_allPokemonNames]];
}

#pragma mark - NSSearch Field Method
// フリーワード検索窓に変更があった場合に呼ばれる
- (IBAction)fontSearchFieldIsChanged:(id)sender {
    _pokemonNames = [self createListWithSearchWord:_searchField.stringValue list:_allPokemonNames];
    [_tableView reloadData];
}

/**
 @brief フリーワードにより絞り込んだフォントリストを作成する（ひらがな・カタカナを区別しない）
 @parama NSArray フォントリスト情報の配列
 @return フォント検索窓の検索によって絞り込まれたフォントリスト
 */
- (NSArray *)createListWithSearchWord:(NSString *)word list:(NSArray *)oldList {
    NSString *searchWord = [word stringByApplyingTransform:NSStringTransformHiraganaToKatakana reverse:NO];  // ひらがな→カタカナ
    searchWord = [searchWord uppercaseString];  // // 大文字へキャスト
    if (searchWord.length == 0) {   // 検索窓が空だったらフィルタリングを行わない
        return oldList;
    }
    NSMutableArray *newList = [NSMutableArray array];
    [oldList enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fixedElement = [element stringByApplyingTransform:NSStringTransformHiraganaToKatakana reverse:NO]; // 日本語フォント名（ひらがなはカタカナに変換）
        fixedElement = [fixedElement uppercaseString];  // 大文字へキャスト
        NSRange searchResult = [fixedElement rangeOfString:searchWord];
        if (searchResult.location != NSNotFound) {
            [newList addObject:element];  // 検索に引っかかった場合
        }
    }];
    return newList;
}

#pragma mark - NSTableView data source
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _pokemonNames.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row{
    NSString        *identifier = tableColumn.identifier;
    NSTableCellView *cellView   = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.stringValue = _pokemonNames[row];
    return cellView;
}


@end
