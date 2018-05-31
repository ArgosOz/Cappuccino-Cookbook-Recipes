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
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 297)];

    
    var defaults = [CPUserDefaults standardUserDefaults];

    console.info("\n\n");
    if([defaults objectForKey:@"Marvel"]){
        console.info("Found a Marvel superhero: %s", [defaults objectForKey:@"Marvel"]);
    } else {
        console.info("Did not find any Marvel superheroes. Created a new one...");
    }

    var count = [defaults integerForKey:@"Count"];
    console.info("Current count for Marvel is %d", count);
    console.info("\n\n");
    count++;

    [defaults setInteger:count forKey:@"Count"];
    [defaults setObject:@"Spider-Man" forKey:@"Marvel"];
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
    /* var TEST_APP2 = 3; */
    /* var TEST_APP3 = 4; */

    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPUserDefaults-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_user_defaults.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nsuserdefaults?language=objc";
            break;            
        case DASH:
            url = "dash://cappuccino:CPUserDefaults";
            openNewTab = "_self";
            break;
        /* case TEST_APP1: */
        /*     url = "https://cappuccino-testbook.5apps.com/#CPImageViewTest"; */
        /*     break; */
        /* case TEST_APP2: */
        /*     url = "https://cappuccino-testbook.5apps.com/#CPImageViewbindingsTest"; */
        /*     break; */
        /* case TEST_APP3: */
        /*     url = "https://cappuccino-testbook.5apps.com/#CPImageViewAlignmentScaling"; */
        /*     break; */
    }
    window.open(url, openNewTab);
}

@end
