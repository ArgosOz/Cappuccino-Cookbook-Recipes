/*
 * AppController.j
 * Key-Value-Coding-Basics
 *
 * Created by Argos Oz on May 29, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


/*
We can update the count variable by calling the setValue:forKey 
method rather than calling the setCount: method directly.

Notice ___count variable with 3 underscores.
We'll synthesize it with the @accessors directive. 
count and setCount: methods will be automatically created
at runtime.
 */
@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow;      
    @outlet CPButton    _button;
            CPInteger   ___count @accessors(property=count);    
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
}


- (IBAction) buttonClicked:(id)sender
{
    [self setValue:[CPNumber numberWithInt:99] forKey:@"count"];
}



- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    // var CLASS_REFERENCE = 1;

    var TEST_APP1 = 2;
    var TEST_APP2 = 3;


    // var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Key-Value-Coding-Basics";
            break;
        // case CLASS_REFERENCE:
        //     url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_timer.html";
        //     break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueCoding/";
            break;
        // case DASH:
        //     url = "dash://cappuccino:CPTimer";
        //     openNewTab = "_self";
        //     break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=ContinuouslyUpdatesValueBinding";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/?t=MultipleValueBindings";
            break;          
    }
    window.open(url, openNewTab);
}

@end
