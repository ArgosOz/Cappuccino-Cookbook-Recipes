/*
 * AppController.j
 * Use-Delegation-In-Your-Own-Class
 *
 * Created by Argos Oz on May 29, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "MyNames.j"

@import <MBSteps/StepsWindowController.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;
    		CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 4) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    var names = [[MyNames alloc] init];
    [names setDelegate:self];
   
    [names deleteName:@"Thor"];
}



- (BOOL) shouldDeleteName:(CPString)aName
{
    if([aName isEqualToString:@"Thor"] == YES){
        console.info("FROM AppController.j :", "Deleting name:", aName);
        return YES;
    }

    return NO;
}



- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    // var CLASS_REFERENCE = 1;

    var TEST_APP1 = 2;
    var TEST_APP2 = 3;


    // var DASH = 999;
    // var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Use-Delegation-In-Your-Own-Class";
            break;
        // case CLASS_REFERENCE:
        //     url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_animation_context.html";
        //     break;
        // case APPLE_REFERENCE:
        //     url = "https://developer.apple.com/documentation/appkit/nsanimationcontext?language=objc";
        //     break;
        // case DASH:
        //     url = "dash://cappuccino:CPAnimationContext";
        //     openNewTab = "_self";
        //     break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#DelegateSelectionTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/#CPTextViewDelegateAndNotifications";
            break;          
    }
    window.open(url, openNewTab);
}

@end
