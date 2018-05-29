/*
 * AppController.j
 * Key-Value-Path-Operators
 *
 * Created by Argos Oz on May 29, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>



@implementation AnObject : CPObject
{
    CPInteger __width @accessors(property=width);
}
@end



@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow;          
            CPInteger   ___number @accessors(property=count);    
    		CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 7) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    var anArray = [[CPMutableArray alloc] init];
    var anObject = [[AnObject alloc] init];
    [anObject setWidth:10];
    [anArray addObject:anObject];

    anObject = [[AnObject alloc] init];
    [anObject setWidth:20];
    [anArray addObject:anObject];

    anObject = [[AnObject alloc] init];
    [anObject setWidth:20];
    [anArray addObject:anObject];

    anObject = [[AnObject alloc] init];
    [anObject setWidth:40];
    [anArray addObject:anObject];

    // These are being KVC Collection Operators
    // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueCoding/CollectionOperators.html
    console.info(@"Count :", [anArray valueForKeyPath:@"@count"]);
    console.info(@"Max   :", [anArray valueForKeyPath:@"@max.width"]);
    console.info(@"Min   :", [anArray valueForKeyPath:@"@min.width"]);
    console.info(@"Sum   :", [anArray valueForKeyPath:@"@sum.width"]);
}

- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    // var CLASS_REFERENCE = 1;

    // var TEST_APP1 = 2;
    // var TEST_APP2 = 3;


    // var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Key-Value-Path-Operators";
            break;
        // case CLASS_REFERENCE:
        //     url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_timer.html";
        //     break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueCoding/CollectionOperators.html";
            break;
        // case DASH:
        //     url = "dash://cappuccino:CPTimer";
        //     openNewTab = "_self";
        //     break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/?t=ContinuouslyUpdatesValueBinding";
        //     break;
        // case TEST_APP2:
        //     url = "https://cappuccino-testbook.5apps.com/?t=MultipleValueBindings";
        //     break;          
    }
    window.open(url, openNewTab);
}

@end
