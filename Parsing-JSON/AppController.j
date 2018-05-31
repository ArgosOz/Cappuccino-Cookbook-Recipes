/*
 * AppController.j
 * Parsing-JSON
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
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 10) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    console.info("\n\n");
    console.info("Download the JSON file below and place it in your project's Resources folder.");    
    console.info([[CPBundle mainBundle] pathForResource:@"marvel.json"]);
    console.info("\n\n");



    var path = [[CPBundle mainBundle] pathForResource:@"marvel.json"];
    var request = [CPURLRequest requestWithURL:path];
    var connection = [CPURLConnection connectionWithRequest:request delegate:self];

}


- (void) connection:(CPURLConnection)connection didReceiveData:(CPString)dataString
{
    if (!dataString)
        return;

    console.info("\n\n");
    console.info("This is the JSON file:");
    console.info("\n");
    console.info(dataString);
    console.info("\n\n");
        
    var jsonObject = [[CPData dataWithString:dataString] JSONObject];
    
    console.info("\n\n");
    console.info("This is the parsed data:");
    console.info("\n");
    var names = jsonObject.names;
    for(var i=0; i<names.length; i++){

         console.info("NAME: %s, TYPE: %s", names[i].name, names[i].type);

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


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Parsing-JSON";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_data.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nsdata?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPData";
            openNewTab = "_self";
            break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/#KeyViewLoopTest";
        //     break;
    }
    window.open(url, openNewTab);
}

@end

