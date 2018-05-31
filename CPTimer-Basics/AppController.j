/*
 * AppController.j
 * CPTimer-Basics
 *
 * Created by Argos Oz on May 29, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;
            CPTimer             _timer;
    		CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 5) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];
}


- (IBAction) startTimer:(id)sender
{
    if(_timer != nil){
        [_timer invalidate];
    }
    _timer = [CPTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (IBAction) stopTimer:(id)sender
{
    [_timer invalidate];
    _timer = nil;
    console.info(@"Timer stopped.");
}

- (void) timerFired:(CPTimer)timer
{
    console.info(@"Timer Fired: %s", [[CPDate date] description]);
}


- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;

    // var TEST_APP1 = 2;
    // var TEST_APP2 = 3;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPTimer-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_timer.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nstimer?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPTimer";
            openNewTab = "_self";
            break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/#DelegateSelectionTest";
        //     break;
        // case TEST_APP2:
        //     url = "https://cappuccino-testbook.5apps.com/#CPTextViewDelegateAndNotifications";
        //     break;          
    }
    window.open(url, openNewTab);
}

@end
