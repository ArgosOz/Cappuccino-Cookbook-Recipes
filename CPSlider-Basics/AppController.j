/*
 * AppController.j
 * CPSlider-Basics
 *
 * Created by Argos Oz on June 9, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;

    @outlet CPTextField     	_label;
    @outlet CPSlider        	_slider;

            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 11) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    [_slider setIntValue:25];
    [_label setIntValue:[_slider intValue]];    
}

- (IBAction) sliderChange:(id)sender
{
    [_label setIntValue:[_slider intValue]];
}

- (void)awakeFromCib
{
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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPSlider-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_slider.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsslider?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPSlider";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#ContinuouslyUpdatesValueBinding";
            break;
    }
    window.open(url, openNewTab);
}

@end
