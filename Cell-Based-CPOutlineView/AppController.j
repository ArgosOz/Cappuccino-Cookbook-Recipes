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
    [_stepsWindowController setPathPrefix:@"../../"];
    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
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
