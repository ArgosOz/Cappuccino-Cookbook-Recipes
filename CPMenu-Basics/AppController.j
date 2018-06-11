/*
 * AppController.j
 * CPMenu-Basics
 *
 * Created by Argos Oz on June 11, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    		theWindow;
    
    @outlet CPTextField     	_label;

            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 8) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    [_stepsWindowController showWindow:self]; 
}


- (IBAction) sayHello:(id)sender
{
    [_label setStringValue:@"Hello"];
}

- (IBAction) sayGoodbye:(id)sender
{
    [_label setStringValue:@"Goodbye"];
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
    var TEST_APP2 = 3;
    var TEST_APP3 = 4;
    var TEST_APP4 = 5;
    var TEST_APP5 = 6;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPMenu-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_menu.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsmenu?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPMenu";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPMenuTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/#CPMenuEnabledBindingsTest";
            break;
        case TEST_APP3:
            url = "https://cappuccino-testbook.5apps.com/#CPMenuKeyEquivalents";
            break;
        case TEST_APP4:
            url = "https://cappuccino-testbook.5apps.com/#CPMenuRemoveAllTest";
            break;
        case TEST_APP5:
            url = "https://cappuccino-testbook.5apps.com/#UndoRedoWithMenuUpdate";
            break;
    }
    window.open(url, openNewTab);
}

@end
