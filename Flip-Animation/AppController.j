/*
 * AppController.j
 * Flip-Animation
 *
 * Created by Argos Oz on May 29, 2018.
 * Copyright 2018, Army of Me, Inc. All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>


var FRONT = 1;
var BACK = -1;
var FACE_SWITCHER = -1;

@implementation AppController : CPObject
{
    @outlet CPWindow        theWindow;
    @outlet CPImageView     _myView; 
    @outlet CPButton        _flipButton;
            // I'm going to need these initial numbers in re-flip phase.
            float           _initialWidth;
            float           _initialHeight;
            float           _initialX;
            
            int             _counter;
            int             _face;

            // It's cheaper to cache images and then swap them when necessary.
            CPImage          _imageCacheNormal;
            CPImage          _imageCachedFlippedHorizontally;

            CPWindowController  _stepsWindowController;
}

- (void) applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 10) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];


    console.info("\n\n");
    console.info("Download the image below and place it in your project's Resources folder.");    
    console.info([[CPBundle mainBundle] pathForResource:@"ireland-1985088__340.jpg"]);
    console.info("\n\n");



    _face = 1;

    _initialX = [_myView frameOrigin].x;
    _initialWidth = [_myView frameSize].width;
    _initialHeight = [_myView frameSize].height;
    _imageCacheNormal = [_myView image];
    [_imageCacheNormal setDelegate:self];
}

- (void) imageDidLoad:(CPImage)anImage
{    
    _imageCachedFlippedHorizontally = [[CPImage alloc] initWithData:[_imageCacheNormal flipHorizontally:_myView]]; 
}


- (IBAction) buttonClicked:(id)sender {
    _counter = 0;
    [_flipButton setEnabled:NO];
    [self flipImage];
}


- (void) flipImage
{
    var targetPoint = CGPointMake(0,[_myView frameOrigin].y);

    var targetWidth;

    if(_counter > 0){ // means we're automatically re-flipping.
        targetPoint.x = _initialX;
        targetWidth = _initialWidth;
    } else { // means we're flipping right after the button click.
        targetPoint.x = _initialWidth / 2;
        targetWidth = 0.0;
    }
    var duration = 0.36;
    var controlsPoints  = [0, 0, 1, 1];
    var timingFunction = [CAMediaTimingFunction functionWithControlPoints:controlsPoints[0] :controlsPoints[1] :controlsPoints[2] :controlsPoints[3]];

    

	var animationCompletedDictionary = @{
			@"message" 		: @"SLIDE OUT Animation is done.",
		}
    [animationCompletedDictionary setObject:1 forKey:@"movementDirection"];
	
    [CPAnimationContext runAnimationGroup:function(context)
    {
        [context setDuration:duration];
        [context setTimingFunction:timingFunction];
        [animationCompletedDictionary setObject:context
                                         forKey:@"animationContext"];

        [[_myView animator] setFrameOrigin:targetPoint];
        var targetFrameSize = CGSizeMake(targetWidth,[_myView frameSize].height);
        [[_myView animator] setFrameSize:targetFrameSize];


    } completionHandler:[self completionHandler:animationCompletedDictionary]]
}



- (Function) completionHandler:(CPString)aDict
{
    _counter++;

    var s = new Date();
    return function()
    {
        var e = new Date() - s

        if(_counter < 2)
            [CPTimer scheduledTimerWithTimeInterval:.09 target:self selector:@selector(reFlip:) userInfo:aDict repeats:NO];
        else
            [_flipButton setEnabled:YES];
    };
}

- (void) reFlip:(id)userInfo
{
   _face *= FACE_SWITCHER;
   switch(_face){
        case FRONT:
            [_myView setImage:_imageCacheNormal];
            break;
        case BACK:
            [_myView setImage:_imageCachedFlippedHorizontally];
            break;
    }

    [self flipImage];
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
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/Swap-Views-Animation";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_animation_context.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/appkit/nsanimationcontext?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPAnimationContext";
            openNewTab = "_self";
            break;
        case TEST_APP1:
            url = "https://cappuccino-testbook.5apps.com/?t=CPAnimatablePropertyContainerTest";
            break;
    }
    window.open(url, openNewTab);
}

@end




// CPImage category to flip the image horizontally.
@implementation CPImage (ImageManipulation)

- (CPData) flipHorizontally:(CPImageView)containerView
{

    var dataURL;
    if (CPFeatureIsCompatible(CPHTMLCanvasFeature))
    {
        var canvas = document.createElement("canvas");
        var ctx = canvas.getContext("2d");

        // We need natural width and height of the image
        // to calculate horizontal flip
        canvas.width = containerView._DOMImageElement.naturalWidth;
        canvas.height = containerView._DOMImageElement.naturalHeight;


        ctx.translate(0, 0);
        // flips matrix horizontally
        ctx.scale(-1,1);

        // CPImageView was modeled on Cocoa 
        // and Cocoa has no notion of DOM... but browsers have.
        // since containerView is an instance of CPImageView, 
        // we have a _DOMImageElement variable. 
        ctx.drawImage(containerView._DOMImageElement, -containerView._DOMImageElement.naturalWidth, 0);

        // Extract canvas content as dataURL
        dataURL = canvas.toDataURL("image/png");
    }
    else
        return nil;

    // Remove "data:image/png;base64,"
    var base64 = dataURL.replace(/^data:image\/png;base64,/, "");
    // return as CPData
    return [CPData dataWithBase64:base64];

}

@end
