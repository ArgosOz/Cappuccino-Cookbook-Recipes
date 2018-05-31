/*
 * AppController.j
 * CPWebView-Basics
 *
 * Created by Argos Oz on May 19, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet CPWebView           _webView;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];
    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 6) + 54;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    [_webView setMainFrameURL:@"http://www.cappuccino-project.org/"];
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
    var APPLE_REFERENCE = 981;
    
    var TEST_APP = 2;
    var TEST_APP2 = 3;
    
    var openNewTab = "_blank";
    var url;
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPSplitView-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_web_view.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/webkit/webview?language=objc";
            break;            
        case DASH:
            url = "dash://cappuccino:CPWebView";
            openNewTab = "_self";
            break;
        case TEST_APP:
            url = "https://cappuccino-testbook.5apps.com/#CPWebViewTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/#CPWebViewTest2";
            break;
    }
    window.open(url, openNewTab);
}

@end
