/*
 * AppController.j
 * Basic-XML-HTML-Parsing
 *
 * Created by Argos Oz on May 30, 2018.
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
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 10) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    console.info("\n\n");
    console.info("Download the xml file below and place it in your project's Resources folder.");    
    console.info([[CPBundle mainBundle] pathForResource:@"marvel.xml"]);
    console.info("\n\n");



    var path = [[CPBundle mainBundle] pathForResource:@"marvel.xml"];
    var request = [CPURLRequest requestWithURL:path];
    var connection = [CPURLConnection connectionWithRequest:request delegate:self];

}


- (void) connection:(CPURLConnection)connection didReceiveData:(CPString)dataString
{
    if (!dataString)
        return;

    console.info("\n\n");
    console.info("This is the xml:");
    console.info("\n");
    console.info(dataString);
    console.info("\n\n");
    
    var parser = new DOMParser();
    var xmlDoc = parser.parseFromString(dataString, "text/xml");
    
    console.info("\n\n");
    console.info("This is the parsed data:");
    console.info("\n");
    var names = xmlDoc.getElementsByTagName("name");
    for(var i=0; i<names.length; i++){

         console.info("NAME: %s, TYPE: %s", names.item(i).innerHTML.trim(), names.item(i).getAttribute("type"));

    }
    console.info("\n\n");

}



- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}




- (IBAction) openLinkInNewTab:(id)sender
{
    var GITHUB_REPO = 0;
    var CLASS_REFERENCE = 1;

    // var TEST_APP1 = 2;


    // var DASH = 999;
    // var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Basic-XML-HTML-Parsing";
            break;
        case CLASS_REFERENCE:
            url = "https://developer.mozilla.org/en-US/docs/Web/API/DOMParser";
            break;
        // case APPLE_REFERENCE:
        //     url = "https://developer.apple.com/documentation/foundation/nskeyedunarchiver?language=objc";
        //     break;
        // case DASH:
        //     url = "dash://cappuccino:CPKeyedUnarchiver";
        //     openNewTab = "_self";
        //     break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/?t=KeyViewLoopTest";
        //     break;
    }
    window.open(url, openNewTab);
}

@end
