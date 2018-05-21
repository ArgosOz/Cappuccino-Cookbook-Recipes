/*
 * AppController.j
 * CPAlert-Basics
 *
 * Created by Argos Oz on May 20, 2018.
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
    // [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 263)];
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}

- (IBAction) showAlerts:(id)sender
{

    var anAlert = [CPAlert alertWithMessageText:@"This is a modal alert!"
                            defaultButton:@"OK"
                            alternateButton:@"Cancel"
                            otherButton:nil
                            informativeTextWithFormat:@"Something important has happened!"];

    [anAlert setDelegate:self];
    [anAlert runModal];


}

- (void) alertDidEnd:(CPAlert)alert returnCode:(int)returnCode
{
    var buttonName;
    switch(returnCode){
        case 0:
            buttonName = "OK";
            break;
        case 1:
            buttonName = "Cancel";
            break;
    }
    console.info(buttonName, "button is clicked. Am I right?");


    var anAlert = [CPAlert alertWithMessageText:@"This a sheet modal..."
                            defaultButton:@"Default Button"
                            alternateButton:@"Cancel"
                            otherButton:@"Other Button"
                            informativeTextWithFormat:@"I know what you did!"];

    [anAlert beginSheetModalForWindow:theWindow
                        modalDelegate:self
                        didEndSelector:@selector(sheetModalEnded:returnCode:contextInfo:)
                        contextInfo:@"This is the context info."];


}

- (void) sheetModalEnded:(CPAlert)anAlert returnCode:(CPInteger)returnCode contextInfo:(id)contextInfo
{
    console.info(contextInfo, "It's coming from the modal sheet.");
}


- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;
    var TEST_APP1 = 2;

    var DASH = 999;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPAlert-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_outline_view.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPAlert";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=CPAlertTest";
            break;
    }
    window.open(url, openNewTab);
}

@end
