/*
 * AppController.j
 * Drawing-in-CPView
 *
 * Created by Argos Oz on May 22, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@import "MyView.j"

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];
    
    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 263)];

    console.info("\n\n");
    console.info("Download the images below and place them in your project's Resources folder.");
    console.info("1. left.png");
    console.info([[CPBundle mainBundle] pathForResource:@"left.png"]);
    console.info("2. middle.png");
    console.info([[CPBundle mainBundle] pathForResource:@"middle.png"]);
    console.info("3. right.png");
    console.info([[CPBundle mainBundle] pathForResource:@"right.png"]);
    console.info("\n\n");


    var aFrame = CGRectMake(10.0, 10.0, 285.0, 160.0);

    var myView = [[MyView alloc] initWithFrame:aFrame];
    [[theWindow contentView] addSubview:myView];

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

    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Drawing-in-CPView";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/class_c_p_view.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsview?language=objc";
            break;            
        case DASH:
            url = "dash://cappuccino:CPView";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPViewController";
            break;
    }
    window.open(url, openNewTab);
}

@end
