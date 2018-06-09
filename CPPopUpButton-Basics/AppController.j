/*
 * AppController.j
 * CPPopUpButton-Basics
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

    @outlet CPPopUpButton       _popUp;
    @outlet CPTextField         _textField;
    @outlet CPTextField         _label;    

            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 13) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];

    [_stepsWindowController showWindow:self]; 
}


- (IBAction) buttonClicked:(id)sender
{
    [_popUp addItemWithTitle:[_textField stringValue]];
}

- (IBAction) updateLabel:(id)sender
{
    [_label setStringValue:[_popUp titleOfSelectedItem]];
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


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPPopUpButton-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_pop_up_button.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nspopupbutton?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPPopUpButton";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPPopUpButtonTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/#CPPopUpButtonBindings";
            break;
    }
    window.open(url, openNewTab);
}

@end
