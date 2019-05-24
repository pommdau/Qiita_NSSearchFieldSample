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
@property NSArray *pokemonNames;    // テーブルビューに表示するポケモンのデータ
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)awakeFromNib {
    // 表示するデータを作成
//    _pokemons = @[@"sample1", @"sample2", @"sample3"];
    [self loadPokemonNames];
    NSLog(@"stop");
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
    _pokemonNames = [NSArray arrayWithArray:pokemonNames];
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
