/*
 * AppController.j
 * CPDatePicker-Basics
 *
 * Created by Argos Oz on June 9, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;

    @outlet CPTextField     	_label;
    @outlet CPTextField     	_nameField;
    @outlet CPDatePicker    	_datePicker;

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

    [_datePicker setDateValue:[CPDate date]];
}

- (IBAction) buttonClicked:(id)sender
{ 
    var string = [CPString stringWithFormat:@"%@ was here at %@", [_nameField stringValue], [_datePicker dateValue]];
    [_label setStringValue:string];
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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPDatePicker-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_date_picker.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsdatepicker?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPDatePicker";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPDatePickerTest";
            break;
    }
    window.open(url, openNewTab);
}

@end
