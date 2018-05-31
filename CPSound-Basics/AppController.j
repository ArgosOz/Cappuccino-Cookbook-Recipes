/*
 * AppController.j
 * CPSound-Basics
 *
 * Created by Argos Oz on May 31, 2018.
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
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 6) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    console.info("\n\n");
    console.info("Download the wav file below and place it in your project's Resources folder.");    
    console.info([[CPBundle mainBundle] pathForResource:@"431286.wav"]);
    console.info("\n\n");

}


- (IBAction) buttonClicked:(id)sender
{
    var path = [[CPBundle mainBundle] pathForResource:@"431286" ofType:@"wav"];
    var sound = [[CPSound alloc] initWithContentsOfFile:path byReference:NO];
    [sound play];
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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPSound-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_sound.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nssound?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPSound";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPSoundTest";
            break;
    }
    window.open(url, openNewTab);
}

@end
