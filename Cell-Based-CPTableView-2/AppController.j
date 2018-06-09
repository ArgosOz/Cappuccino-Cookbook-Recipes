/*
 * AppController.j
 * Cell-Based-CPTableView-2
 *
 * Created by Argos Oz on June 9, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


@import "TableViewController.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;
    		CPWindowController  _stepsWindowController;
}


- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 14) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    [_stepsWindowController showWindow:self];    
    
}



- (void) awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}



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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Cell-Based-CPTableView-2";
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

@end
