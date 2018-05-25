
@import <AppKit/CPBox.j>


var kContextNeutral     = 0;
var kContextLargeLayer  = 1;
var kContextSmallLayer  = 2;


// ┌──────────────────────────────────────────────────────────────┐
// │                                                              │
// │  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓                         │
// │  ┃                                 ┃                         │
// │  ┃                               ◀─╋──■CALayer _largeLayer   │
// │  ┃                                 ┃                         │
// │  ┃             ┌──────┐            ◀────■Border              │
// │  ┃             │██████│            ┃                         │
// │  ┃             │████◀─┼────────────╋──■CPImage               │
// │  ┃             │██████│            ┃                         │
// │  ┃             │██████│◀───────────╋──■CALayer _smallLayer   │
// │  ┃             └──────┘            ┃                         │
// │  ┃                                 ┃                         │
// │  ┃                                 ┃                         │
// │  ┃                                 ┃                         │
// │  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛                       ◀─┼──■CPView
// │                                                              │
// └──────────────────────────────────────────────────────────────┘

/* 
We will use multiple layers to draw our custom view.
*/
@implementation MyView : CPView
{
    CALayer     _largeLayer
    CALayer     _smallLayer
    CPImage     _image;

    // Since two layers share the same drawLayer:inContext: method here,
    // We need a modal system to draw different things to different layers.
    int         _currentContext;
}

- (void) awakeFromCib {
	
    _largeLayer = [CALayer layer]; // Create a layer.
    [self setWantsLayer:YES];
    [self setLayer:_largeLayer];

    [_largeLayer setBounds:[self bounds]];
    [_largeLayer setDelegate:self]; 

    _currentContext = kContextLargeLayer; 
    // setNeedsDisplay: makes a note of the redraw request 
    // and returns immediately. Subsequently Cappuccino will call 
    // drawLayer:inContext: method when it's appropriate.
    [_largeLayer setNeedsDisplay];


    // Load the image
    _image = [[CPImage alloc] initWithContentsOfFile:@"Resources/nature-1898150__340.jpg" size:CGSizeMake([self frameSize].width/2, [self frameSize].height/2)];
    
    // trigger imageDidLoad: method.
    [_image setDelegate:self]; 


    _smallLayer = [CALayer layer]; // Create a layer
    [_smallLayer setDelegate:self]; // You have to delegate out to receive drawLayer:inContext: method calls here.


    [_largeLayer addSublayer:_smallLayer];

}

- (void) imageDidLoad:(CPImage)anImage
{

    [_smallLayer setBounds:CGRectMake(0.0, 0.0, [_image size].width, [_image size].height)];
    // You can change anchor point using the commented out code below.
    // It's commented out here because default point is 0.5, 0.5.
    // Range is 0.0...1.0 by the way. 0.5 represents center.
    /* [_smallLayer setAnchorPoint:CGPointMakeZero()]; */
    [_smallLayer setPosition:CGPointMake([self boundsSize].width/2, [self boundsSize].height/2)];
    
    _currentContext = kContextSmallLayer;
    [_smallLayer setNeedsDisplay]; // calls forth drawLayer:inContext: method ASAP.
}

- (void)drawLayer:(CALayer)aLayer inContext:(CGContext)aContext
{

    switch(_currentContext){
        case kContextLargeLayer:
            // CG stands for CoreGraphics. 
            // CG of Cappucino made of a collection of functions.
            // Search for CGContext in the Dash.
            CGContextSetLineWidth(aContext, 9);
            CGContextStrokeRect(aContext, [aLayer bounds]);
            break;
        case kContextSmallLayer:
            if ([_image loadStatus] != CPImageLoadStatusCompleted){
                console.info("NO");
                [_image setDelegate:self]; // trigger imageDidLoad: method.
            } else {
                console.info("YES");
                CGContextDrawImage(aContext, [_smallLayer bounds], _image);
            }
            break;
        default:
            break;
    }

    _currentContext = kContextNeutral; // Remember to revert to neutral context.
}

@end
