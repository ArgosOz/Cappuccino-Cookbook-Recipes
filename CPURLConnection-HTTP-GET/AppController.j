/*
 * AppController.j
 * CPURLConnection-HTTP-GET
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
            CPData              data;
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


    var url = [CPURL URLWithString:@"index.html"];
    var request = [CPURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    var connection = [[CPURLConnection alloc] initWithRequest:request delegate:self];

}


- (void) connection:(CPURLConnection)connection didReceiveResponse:(CPURLResponse)response
{
    console.info("\n\n");
    console.info("---------> connection:didReceiveResponse:");
    console.info("\n");
    console.info(response);
    console.info("\n\n");
}

- (void) connection:(CPURLConnection)connection didReceiveData:(CPString)dataString
{
    console.info("\n\n");
    console.info("---------> connection:didReceiveData:");
    console.info("\n");
    if (!dataString)
        return;
    console.info("Data string has been received.");
    data = [CPData dataWithString:dataString];
    console.info("\n\n");
}

- (void) connection:(CPURLConnection)connection didFailWithError:(CPException)error
{
    console.info("\n\n");
    console.info("---------> connection:didFailWithError:");
    console.info("\n");
    console.info(error);
    console.info("\n\n");
}

- (void) connectionDidFinishLoading:(CPURLConnection)connection
{
    console.info("\n\n");
    console.info("---------> connectionDidFinishLoading:");
    console.info("\n");
    console.info([data string]);
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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPURLConnection-HTTP-GET";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_u_r_l_connection.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nsurlconnection?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPURLConnection";
            openNewTab = "_self";
            break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/#KeyViewLoopTest";
        //     break;
    }
    window.open(url, openNewTab);
}

@end

