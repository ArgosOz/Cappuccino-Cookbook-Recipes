/*
 * AppController.j
 * Swap-Views-Animation
 *
 * Created by Argos Oz on May 26, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;
    @outlet CPView              _myView;    
    @outlet CPView              _nameView;
    @outlet CPView              _emailView;
            CPString            _currentView;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 9) + 54;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    _currentView = @"nameView";
    [_myView addSubview:_nameView];
    [_emailView setFrameOrigin:CGPointMake(-[_emailView frameSize].width, [_emailView frameOrigin].y)];
    [_myView addSubview:_emailView];
}



- (IBAction) swapViews:(id)sender
{
    var slideInView;
    var slideOutView;

    if([_currentView isEqualToString:@"nameView"] == YES){        
        slideInView = _emailView;
        slideOutView = _nameView;
        _currentView = @"emailView";
    } else {
        slideInView = _nameView;
        slideOutView = _emailView;
        _currentView = @"nameView";
    }

    
    [slideInView setFrameOrigin:CGPointMake([_myView frameOrigin].x - [slideInView  frameSize].width, [slideInView frameOrigin].y)];
    
    var slideOutToThisPoint = CGPointMake([_myView frameSize].width + 18.0, [slideOutView frameOrigin].y);
    var slideInToThisPoint = CGPointMake([slideOutView frameOrigin].x, [slideInView frameOrigin].y);

    var duration = 0.63
    var controlsPoints = [0.42, 0, 0.58, 1]
    var timingFunction = [CAMediaTimingFunction functionWithControlPoints:controlsPoints[0] :controlsPoints[1] :controlsPoints[2] :controlsPoints[3]]

    var message = @"SLIDE OUT animation is done.";
    

    [CPAnimationContext runAnimationGroup:function(context)
    {
        [context setDuration:duration];
        [context setTimingFunction:timingFunction];

        [[slideOutView animator] setFrameOrigin:slideOutToThisPoint];
        [[slideOutView animator] setAlphaValue:0];

        [slideInView setAlphaValue:100];
        [[slideInView animator] setFrameOrigin:slideInToThisPoint];


    } completionHandler:[self completionHandler:message]];
}

- (Function) completionHandler:(CPString)message
{
    var s = new Date();
    return function()
    {
        var e = new Date() - s;
        console.info([self className] + " " + message + " It took about " + e + " ms");

    };
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
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;

    var TEST_APP1 = 2;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Swap-Views-Animation";
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
