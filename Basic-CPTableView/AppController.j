/*
 * AppController.j
 * 0101-CPTableView
 *
 * Created by You on April 14, 2018.
 * Copyright 2018, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

var GITHUB_REPO = 0

@implementation AppController : CPObject
{
    @outlet CPWindow        theWindow;
    @outlet CPTableView     tableView;
            CPMutableArray  _tableData;
}

- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
	// The tables data source. Each row in the table will be a NSDictionary with two
	// items, one for each column.
	_tableData = [[CPMutableArray alloc] init];
	
	// Row 1
    var dictionary = [CPMutableDictionary dictionary];
	[dictionary setObject:@"Spider-Man" forKey:@"movie"];
	[dictionary setObject:@"2002" forKey:@"releasedate"];

	[_tableData addObject:dictionary];
    
	// You can also create a dictionary using the syntax below.
    // For more information see Objective-J 2.0 section at
    // http://www.cappuccino-project.org/learn/objective-j.html    
    // Row 2
	dictionary = @{
        @"movie": @"Iron-Man",
        @"releasedate": @"2008"
    }    
	[_tableData addObject:dictionary];
	
    // Row 3
	dictionary = @{
        @"movie": @"Thor",
        @"releasedate": @"2011"
    }
	[_tableData addObject:dictionary];
	
		
	[tableView reloadData];
}

- (void) awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    console.info(sender);
    console.info([sender title]);
    switch([sender tag]){
        case GITHUB_REPO:
            window.open("https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Set-an-Icon-for-About-Window", "_blank");
            break;
    }
}

// ┌───────────────────────────────────────────────────────┐
// │                                                       │
// │                                                       │██
// │                 CPTableViewDataSource                 │██
// │                   Protocol methods                    │██
// │                                                       │██
// │                                                       │██
// └───────────────────────────────────────────────────────┘██
//   █████████████████████████████████████████████████████████
//   █████████████████████████████████████████████████████████

- (CPInteger) numberOfRowsInTableView:(CPTableView)table {
	return [_tableData count];
}


- (id) tableView:(CPTableView)table objectValueForTableColumn:(CPTableColumn)column row:(CPInteger)rowIndex
{

    var rowData = [_tableData objectAtIndex:rowIndex];
    return [rowData valueForKey:[column identifier]];

}



@end
