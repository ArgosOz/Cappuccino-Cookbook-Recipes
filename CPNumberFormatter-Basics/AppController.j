/*
 * AppController.j
 * CPNumberFormatter-Basics
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


    var formatter = [[CPNumberFormatter alloc] init];

    var number = [CPNumber numberWithDouble:1234.99];
     
    [formatter setNumberStyle:CPNumberFormatterDecimalStyle];
    /* CPLog(@"Decimal Style    : %@", [formatter stringFromNumber:number]); */
    console.info(@"Decimal Style    : %s", [formatter stringFromNumber:number]);

    number = [CPNumber numberWithDouble:.2];
    [formatter setNumberStyle:CPNumberFormatterPercentStyle];
    console.info(@"Percent Style    : %s", [formatter stringFromNumber:number]);

    number = [CPNumber numberWithDouble:200.95];
    [formatter setNumberStyle:CPNumberFormatterCurrencyStyle];
    console.info(@"Currency Style   : %s", [formatter stringFromNumber:number]);
    
    number = [CPNumber numberWithDouble:200.95];
    [formatter setNumberStyle:CPNumberFormatterScientificStyle];
    console.info(@"Scientific Style : %s", [formatter stringFromNumber:number]);
    
    number = [CPNumber numberWithDouble:200.95];
    [formatter setNumberStyle:CPNumberFormatterSpellOutStyle];
    console.info(@"Spelled Out Style: %s", [formatter stringFromNumber:number]);

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
    /* var TEST_APP1 = 2; */

    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var NSHIPSTER_REFERENCE = 972;

    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPNumberFormatter-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_number_formatter.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nsnumberformatter?language=objc";
            break;  
        case NSHIPSTER_REFERENCE:
            url = "http://nshipster.com/nsformatter/";
            break;                  
        case DASH:
            url = "dash://cappuccino:CPNumberFormatter";
            openNewTab = "_self";
            break;
        /* case TEST_APP1: */
        /*     url = "https://cappuccino-testbook.5apps.com/#CPDateFormatterTest"; */
        /*     break; */
    }
    window.open(url, openNewTab);
}

@end
