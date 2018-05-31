/*
 * AppController.j
 * CPImageView-Basics
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
    @outlet CPImageView         _imageView1;
    @outlet CPImageView         _imageView2;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];
    [_stepsWindowController setPathPrefix:@"../../"];
    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, 297)];


    // Direct way
    var image = [[CPImage alloc] initWithContentsOfFile:@"Resources/ireland-1985088__340.jpg"];
    [_imageView1 setFrameSize:CGSizeMake(401,340)];
    [_imageView1 setImage:image];
    [_imageView1 setImageScaling:CPImageScaleNone];
    [_imageView1 setImageAlignment:CPImageAlignCenter];

    // Bundle way
    image = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"nature-1898150__340.jpg"]];
    
    var targetX = [_imageView1 frameOrigin].x;
    var targetY = [_imageView1 frameOrigin].y + [_imageView1 frameSize].height + 27;

    [_imageView2 setFrameOrigin:CGPointMake(targetX, targetY)];
    [_imageView2 setFrameSize:CGSizeMake(401,340)];
    [_imageView2 setImage:image];
    [_imageView2 setImageScaling:CPImageScaleAxesIndependently];
    [_imageView2 setImageAlignment:CPImageAlignCenter];

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
    var TEST_APP2 = 3;
    var TEST_APP3 = 4;

    var DASH = 999;
    var APPLE_REFERENCE = 981;

    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPImageView-Basics";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_image_view.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsimageview?language=objc";
            break;            
        case DASH:
            url = "dash://cappuccino:CPImageView";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/#CPImageViewTest";
            break;
        case TEST_APP2:
            url = "https://cappuccino-testbook.5apps.com/#CPImageViewbindingsTest";
            break;
        case TEST_APP3:
            url = "https://cappuccino-testbook.5apps.com/#CPImageViewAlignmentScaling";
            break;
    }
    window.open(url, openNewTab);
}

@end
