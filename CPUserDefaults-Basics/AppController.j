/*
 * AppController.j
 * CPUserDefaults-Basics
 *
 * Created by Argos Oz on May 22, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];
    [_stepsWindowController setPathPrefix:@"../../"];
    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 297)];
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

    var TEST_APP1 = 2;
    var TEST_APP2 = 3;
    var TEST_APP3 = 4;

    var DASH = 999;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPImageView-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_image_view.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPImageView";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=CPImageViewTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/?t=CPImageViewbindingsTest";
            break;
        case TEST_APP3:
            url = "https://cappuccino-testbook.5apps.com/?t=CPImageViewAlignmentScaling";
            break;
    }
    window.open(url, openNewTab);
}

@end
