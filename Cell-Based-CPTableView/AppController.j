/*
 * AppController.j
 * 0101-CPTableView
 *
 * Created by You on April 14, 2018.
 * Copyright 2018, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

// StepsWindow lives in the StepsWindow.cib file.
// We control it with StepsWindowController.
// So you need to import the StepsWindowController here...
// and define a class variable in the class definition.
// and then initialize it with StepsWindow.cib
// This will let you move and reuse UI and related code in between different application easily.
@import <MBSteps/StepsWindowController.j>


@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet CPTableView         _tableView;
            CPMutableArray      _tableDataArray;
            CPWindowController  _stepsWindowController; // StepsWindowController class variable.
}

- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
    // The table's data source. 
    // Each row in the table will be a NSDictionary with two
	// items, one for each column.
	_tableDataArray = [[CPMutableArray alloc] init];
	
	// Row 1
    var dictionary = [CPMutableDictionary dictionary];
	[dictionary setObject:@"Spider-Man" forKey:@"movie"];
	[dictionary setObject:@"2002" forKey:@"releasedate"];

	[_tableDataArray addObject:dictionary];
    
	// You can also create a dictionary using the syntax below.
    // For more information see Objective-J 2.0 section at
    // http://www.cappuccino-project.org/learn/objective-j.html    
    // Row 2
	dictionary = @{
        @"movie": @"Iron-Man",
        @"releasedate": @"2008"
    }    
	[_tableDataArray addObject:dictionary];
	
    // Row 3
	dictionary = @{
        @"movie": @"Thor",
        @"releasedate": @"2011"
    }
	[_tableDataArray addObject:dictionary];
    // Following rows...
	dictionary = @{
        @"movie": @"Avengers: Infinity War",
        @"releasedate": @"2018"
    }
	[_tableDataArray addObject:dictionary];
	dictionary = @{
        @"movie": @"Guardians of the Galaxy",
        @"releasedate": @"2014"
    }
	[_tableDataArray addObject:dictionary];
	dictionary = @{
        @"movie": @"Black Panther",
        @"releasedate": @"2018"
    }
	[_tableDataArray addObject:dictionary];
	dictionary = @{
        @"movie": @"Ant-Man",
        @"releasedate": @"2015"
    }
	[_tableDataArray addObject:dictionary];
	dictionary = @{
        @"movie": @"The Incredible Hulk",
        @"releasedate": @"2008"
    }
	[_tableDataArray addObject:dictionary];

		
	[_tableView reloadData];

    _stepsWindowController = [StepsWindowController alloc];
    [_stepsWindowController setPathPrefix:@"../../"];
    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 11) * 1.2;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];
}


- (void) awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}




// ┌───────────────────────────────────────────────────────┐
// │                                                       │
// │                                                       │██
// │                        Actions                        │██
// │                                                       │██
// │                                                       │██
// └───────────────────────────────────────────────────────┘██
//   █████████████████████████████████████████████████████████
//   █████████████████████████████████████████████████████████



- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;
    var DASH = 999;
    var APPLE_REFERENCE = 981;
    // ----------------------
    var CPTableViewGroupRows = 2;
    var BorderTableTest = 3;
    var ColumnResize = 4;
    var ColumnSizing2 = 5;
    var DataView = 6;
    var DelegateSelectionTest = 7;
    var DragAndDrop = 8;
    var Editing = 9;
    var EditingControls = 10;
    var GroupRowTest = 11;
    var HeaderCornerView = 12;
    var OldTest = 13;
    var TableBindings = 14;
    var TableCibTest = 15;
    var TestTableColumn = 16;
    var VariableRows = 17;
    var ViewBasedCib = 18;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Cell-Based-CPTableView";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_table_view.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nstableview?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPTableView";
            openNewTab = "_self";
            break;
        case CPTableViewGroupRows:
            url = "https://cappuccino-testbook.5apps.com/#CPTableViewGroupRows";
            break;
        case BorderTableTest:
            url = "https://cappuccino-testbook.5apps.com/#BorderTableTest";
            break;
        case ColumnResize:
            url = "https://cappuccino-testbook.5apps.com/#ColumnResize";
            break;
        case ColumnSizing2:
            url = "https://cappuccino-testbook.5apps.com/#ColumnSizing2";
            break;
        case DataView:
            url = "https://cappuccino-testbook.5apps.com/#DataView";
            break;
        case DelegateSelectionTest:
            url = "https://cappuccino-testbook.5apps.com/#DelegateSelectionTest";
            break;
        case DragAndDrop:
            url = "https://cappuccino-testbook.5apps.com/#DragAndDrop";
            break;
        case Editing:
            url = "https://cappuccino-testbook.5apps.com/#Editing";
            break;
        case EditingControls:
            url = "https://cappuccino-testbook.5apps.com/#EditingControls";
            break;
        case GroupRowTest:
            url = "https://cappuccino-testbook.5apps.com/#GroupRowTest";
            break;
        case HeaderCornerView:
            url = "https://cappuccino-testbook.5apps.com/#HeaderCornerView";
            break;
        case OldTest:
            url = "https://cappuccino-testbook.5apps.com/#OldTest";
            break;
        case TableBindings:
            url = "https://cappuccino-testbook.5apps.com/#TableBindings";
            break;
        case TableCibTest:
            url = "https://cappuccino-testbook.5apps.com/#TableCibTest";
            break;
        case TestTableColumn:
            url = "https://cappuccino-testbook.5apps.com/#TestTableColumn";
            break;
        case VariableRows:
            url = "https://cappuccino-testbook.5apps.com/#VariableRows";
            break;
        case ViewBasedCib:
            url = "https://cappuccino-testbook.5apps.com/#ViewBasedCib";
            break;
    }
    window.open(url, openNewTab);
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
	return [_tableDataArray count];
}


- (id) tableView:(CPTableView)table objectValueForTableColumn:(CPTableColumn)column row:(CPInteger)rowIndex
{
    var rowData = [_tableDataArray objectAtIndex:rowIndex];
    return [rowData valueForKey:[column identifier]];

}



@end
