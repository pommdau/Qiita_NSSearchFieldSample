//  AppDelegate.m
//  NSSearchTableSample

#import "AppDelegate.h"
#import "Function.h"

@interface AppDelegate ()
@property NSArray *allPokemonNames; // 全てのポケモン名
@property NSArray *pokemonNames;    // テーブルビューに表示するポケモン名
@property (weak) IBOutlet NSSearchField *searchField;   // 検索窓
@property (weak) IBOutlet NSTableView   *tableView;
@property (weak) IBOutlet NSWindow      *window;
@end

@implementation AppDelegate

- (void)awakeFromNib {
    [self loadPokemonNames];    // テーブルビューに表示するデータを作成する
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

// テキストからポケモン名のデータを取得する
// またテーブルビューに表示するデータを作成する
- (void)loadPokemonNames {
    NSURL *pokemonList = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"PokemonList"];
    NSMutableArray *pokemonNames = [NSMutableArray arrayWithArray:[Function loadFile:pokemonList]];
    _allPokemonNames = [NSArray arrayWithArray:pokemonNames];
    [self fontSearchFieldIsChanged:nil];
}

#pragma mark - NSSearch Field Method
// 検索窓のテキストに変更があった場合に呼ばれる
- (IBAction)fontSearchFieldIsChanged:(id)sender {
    _pokemonNames = [self createListWithSearchWord:_searchField.stringValue list:_allPokemonNames];
    [_tableView reloadData];
}

/**
 @brief 対象文字列の含まれる要素の配列を作成する
 @parama word 検索する文字列（※ひらがな・カタカナを区別しない）
 @param oldList 検索対象の配列
 @return 対象文字列が含まれる要素の配列
 */
- (NSArray *)createListWithSearchWord:(NSString *)word list:(NSArray<NSString *> *)oldList {
    NSString *searchWord = [word stringByApplyingTransform:NSStringTransformHiraganaToKatakana reverse:NO];  // ひらがなをカタカナに変換（検索時の統一のため）
    searchWord = [searchWord uppercaseString];  // 大文字へキャスト
    if (searchWord.length == 0) {
        return oldList; // 検索文字列がない場合は、元の配列をそのまま返す
    }
    NSMutableArray *newList = [NSMutableArray array];
    [oldList enumerateObjectsUsingBlock:^(NSString *element, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fixedElement = [element stringByApplyingTransform:NSStringTransformHiraganaToKatakana reverse:NO]; // 日本語フォント名（ひらがなをカタカナに変換）
        fixedElement = [fixedElement uppercaseString];  // 大文字へキャスト
        
        NSRange searchResult = [fixedElement rangeOfString:searchWord];
        if (searchResult.location != NSNotFound) {
            [newList addObject:element];  // 対象文字列が含まれる場合
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
