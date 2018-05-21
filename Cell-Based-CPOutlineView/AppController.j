/*
 * AppController.j
 * Cell-Based-CPOutlineView
 *
 * Created by Argos Oz on May 17, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet CPOutlineView       _outlineView;
            CPMutableDictionary _outlineViewData;
            CPWindowController  _stepsWindowController; // StepsWindowController class variable.
}

- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];
    /* [_stepsWindowController setPathPrefix:@"../../"]; */
    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 288)];
    [_stepsWindowController showWindow:self];

    _outlineViewData = [[CPMutableDictionary alloc] init];

    // item 1
    var items = [CPArray arrayWithObjects:@"Spider-Man", @"Hulk", 
        @"Iron Man", @"Captain America", @"Daredevil", 
        @"Wolverine", @"Thor", nil];
    [_outlineViewData setObject:items forKey:@"Marvel"];

    // item 2
    // You can also create a dictionary using the syntax below.
    items = ["Superman", @"Batman", @"Wonder Woman", @"Joker", "Flash", "Catwoman"];
    [_outlineViewData setObject:items forKey:@"DC"];
    
    // item 3
    items = [@"The Incredibles", @"Toy Story", @"Monsters Inc.", @"Finding Nemo", @"Inside Out"];
    [_outlineViewData setObject:items forKey:@"Pixar"];

    // Let the Outline View know that the data is ready.
    [_outlineView reloadData];
}

- (void)awakeFromCib
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

    var TEST_APP1 = 2;
    var TEST_APP2 = 3;
    var TEST_APP3 = 4;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Cell-Based-CPOutlineView";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_outline_view.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPOutlineView";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=CPOutlineViewTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/?t=CPOutlineViewCibTest";
            break;
        case TEST_APP3:
            url = "https://cappuccino-testbook.5apps.com/?t=CPOutlineViewViewBasedCibTest";
            break;
    }
    window.open(url, openNewTab);
}

// ┌───────────────────────────────────────────────────────┐
// │                                                       │
// │                                                       │██
// │                CPOutlineViewDataSource                │██
// │                   Protocol methods                    │██
// │                                                       │██
// │                                                       │██
// └───────────────────────────────────────────────────────┘██
//   █████████████████████████████████████████████████████████
//   █████████████████████████████████████████████████████████

- (CPInteger) outlineView:(CPOutlineView)outlineView numberOfChildrenOfItem:(id)item
{
    if(item == nil){
        return [_outlineViewData count];
    }

    return [item count];
}

- (id) outlineView:(CPOutlineView)outlineView child:(CPInteger)childIndex ofItem:(id)item
{
    if (item == nil) {
        item = _outlineViewData;
    }

    if ([item isKindOfClass:[CPArray class]]) {
        return [item objectAtIndex:childIndex];
    }
    else if ([item isKindOfClass:[CPMutableDictionary class]]) {
		var keys = [item allKeys];
        return [item objectForKey:[keys objectAtIndex:childIndex]];
    }

    return nil;
}

- (id) outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
{
    if([item isKindOfClass:[CPString class]]){
        return item;
    } 
    else if([item isKindOfClass:[CPArray class]]){
        var keys = [_outlineViewData allKeysForObject:item];
        return [keys objectAtIndex:0];
    }
    return nil;
}

- (BOOL) outlineView:(CPOutlineView)outlineView isItemExpandable:(id)item
{
	if ([item isKindOfClass:[CPArray class]] || [item isKindOfClass:[CPMutableDictionary class]]) {
        if ([item count] > 0) {
            return YES;
		}
    }

    return NO;
}

@end
