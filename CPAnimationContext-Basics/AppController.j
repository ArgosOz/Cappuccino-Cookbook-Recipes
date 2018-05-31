/*
 * AppController.j
 * CPAnimationContext-Basics
 *
 * Created by Argos Oz on May 26, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>


@import <MBSteps/StepsWindowController.j>

@import "MyView.j"

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet MyView              _myView;
            BOOL                _isSmall;
            CPWindowController  _stepsWindowController;
}

- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 9) + 54;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    _isSmall = NO;

}

- (void) awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}



- (IBAction) resizeView:(id)sender {
    var small = CPMakeRect(20, 58, 54, 54);
    var large = CPMakeRect(20, 58, 163, 96);

    // Seems like Cocoa provides default values for an animation and Cappucino does not.
    // Without the setup below, animator objects cannot produce any animation.
    var duration = 0.3;
    var controlsPoints  = [0, 0, 1, 1];
    var tf = [CAMediaTimingFunction functionWithControlPoints:controlsPoints[0] :controlsPoints[1] :controlsPoints[2] :controlsPoints[3]];

    var message1 = @"Done ";

    [[CPAnimationContext currentContext] setDuration:duration];
    [[CPAnimationContext currentContext] setTimingFunction:tf];
    [[CPAnimationContext currentContext] setCompletionHandler:[self completionHandlerFromString:message1]];

    [[_myView animator] setWantsPeriodicFrameUpdates:YES];
    if (_isSmall == YES) {
        [[_myView animator] setFrame:large];
        _isSmall = NO;
    } else {
        [[_myView animator] setFrame:small];
        _isSmall = YES;
    }
}


- (Function)completionHandlerFromString:(CPString)aMessage
{
    if (!aMessage || ![aMessage length])
        return nil;

    var s = new Date();
    return function()
    {
        var e = new Date() - s;
        CPLogConsole(aMessage + " in " + e + " ms");
    };
}



- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;

    var TEST_APP1 = 2;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPAnimationContext-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_animation_context.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsanimationcontext?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPAnimationContext";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPAnimatablePropertyContainerTest";
            break;
    }
    window.open(url, openNewTab);
}

@end
