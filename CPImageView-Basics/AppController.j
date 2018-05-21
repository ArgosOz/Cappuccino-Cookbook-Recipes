/*
 * AppController.j
 * CPImageView-Basics
 *
 * Created by Argos Oz on May 21, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
    @outlet CPImageView         _imageView1;
    @outlet CPImageView         _imageView2;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 180)];


    // Direct way
    var image = [[CPImage alloc] initWithContentsOfFile:@"Resources/duke.jpg"];
    [imageView setImage:image];
    [imageView setImageScaling:CPImageScaleAxesIndependently];
    [imageView setImageAlignment:CPImageAlignCenter];

    // Bundle way
    image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"duke2.jpg"]]
    [imageView2 setImage:image];
    [imageView2 setImageScaling:CPImageScaleAxesIndependently];
    [imageView2 setImageAlignment:CPImageAlignCenter];

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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPNumberFormatter-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_number_formatter.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPNumberFormatter";
            openNewTab = "_self";
            break;
        /* case TEST_APP1: */
        /*     url = "https://cappuccino-testbook.5apps.com/?t=CPDateFormatterTest"; */
        /*     break; */
    }
    window.open(url, openNewTab);
}

@end
