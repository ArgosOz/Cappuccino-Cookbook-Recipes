/*
 * AppController.j
 * CPNotificationCenter-Basics
 *
 * Created by Argos Oz on May 25, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@import "MyView.j"

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
            int                 _colorState;
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
    
    _colorState = -1;
    var callback = function(){
        _colorState *= -1;
        var currentColor = _colorState == 1 ? [CPColor redColor] : [CPColor yellowColor];
        var colorDictionary = [CPDictionary dictionaryWithObject:currentColor forKey:@"fillColor"];
        var notificationCenter = [CPNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"ColorChange" object:self userInfo:colorDictionary];
    }
    [CPTimer scheduledTimerWithTimeInterval:1.8 callback:callback repeats:YES];
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

    // var TEST_APP1 = 2;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPNotificationCenter-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_notification_center.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nsnotificationcenter?language=occ";
            break;
        case DASH:
            url = "dash://cappuccino:CPNotificationCenter";
            openNewTab = "_self";
            break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/?t=KeyViewLoopTest";
        //     break;
    }
    window.open(url, openNewTab);
}

@end
