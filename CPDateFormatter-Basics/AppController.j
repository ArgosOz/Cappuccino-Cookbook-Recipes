/*
 * AppController.j
 * CPDateFormatter-Basics
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
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 180)];


    var formatter = [[CPDateFormatter alloc] init];

    [formatter setTimeStyle:CPDateFormatterFullStyle];
    [formatter setDateStyle:CPDateFormatterFullStyle];
    /* CPLog(@"Full Style  :  %@", [formatter stringFromDate:[CPDate date]]); */
    console.info(@"Full Style  :  %s", [formatter stringFromDate:[CPDate date]]);

    
    [formatter setTimeStyle:CPDateFormatterLongStyle];
    [formatter setDateStyle:CPDateFormatterLongStyle];
    console.info(@"Long Style  :  %s", [formatter stringFromDate:[CPDate date]]);

    [formatter setTimeStyle:CPDateFormatterMediumStyle];
    [formatter setDateStyle:CPDateFormatterMediumStyle];
    console.info(@"Medium Style:  %s", [formatter stringFromDate:[CPDate date]]);

    [formatter setTimeStyle:CPDateFormatterShortStyle];
    [formatter setDateStyle:CPDateFormatterShortStyle];
    console.info(@"Short Style :  %s", [formatter stringFromDate:[CPDate date]]);

    [formatter setTimeStyle:CPDateFormatterNoStyle];
    [formatter setDateStyle:CPDateFormatterFullStyle];
    console.info(@"No Time     :  %s", [formatter stringFromDate:[CPDate date]]);

    [formatter setTimeStyle:CPDateFormatterFullStyle];
    [formatter setDateStyle:CPDateFormatterNoStyle];
    console.info(@"No Date     :  %s", [formatter stringFromDate:[CPDate date]]);

    [formatter setTimeStyle:CPDateFormatterNoStyle];
    [formatter setDateStyle:CPDateFormatterFullStyle];
    [formatter setDoesRelativeDateFormatting:YES];
    console.info(@"Relative    :  %s", [formatter stringFromDate:[CPDate date]]);
    
    [formatter setDateStyle:CPDateFormatterShortStyle];
    var date = [formatter dateFromString:@"9/10/2018"];
    console.info(@"Date String :  %s", [date description]);

    console.info("\n\n");
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
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPDateFormatter-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_date_formatter.html";
            break;
        case DASH:
            url = "dash://cappuccino:CPDateFormatter";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=CPDateFormatterTest";
            break;
    }
    window.open(url, openNewTab);
}

@end
