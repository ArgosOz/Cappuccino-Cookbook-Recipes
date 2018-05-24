/*
 * AppController.j
 * CPAttributedString-Basics
 *
 * Created by Argos Oz on May 24, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet CPTextView          _textView;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 7) + 54;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    var font = [CPFont boldSystemFontOfSize:18.0];

    var attributesDict = @{
        @"CPFontAttributeName": font,
        @"CPForegroundColorAttributeName":[CPColor redColor],
    };
    var attributedString = [[CPAttributedString alloc] initWithString:@"Marvel Cinematic Universe" attributes:attributesDict];

    [_textView setObjectValue:attributedString];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;

    /* var TEST_APP1 = 2; */


    var DASH = 999;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPAttributedString-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_attributed_string.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPAttributedString";
            openNewTab = "_self";
            break;
        /* case TEST_APP1: */
        /*     url = "https://cappuccino-testbook.5apps.com/?t=KeyEquivalents"; */
        /*     break; */
    }
    window.open(url, openNewTab);
}

@end
