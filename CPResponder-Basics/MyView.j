@import <AppKit/CPView.j>
@import <AppKit/CPBezierPath.j>
/*
In order for MyView to receive keyboard events, 
it must be the first responder 
in the responder chain of the application. 

By implementing the acceptsFirstResponder: method 
and returning YES from it, 
MyView will be ready to handle 
keyboard events in the keyDown: method. 

The CPEvent passed to the keyDown: method 
contains several properties that can be examined. 
*/
@implementation MyView : CPView
{
    CPImage     _leftImage;
    CPImage     _middleImage;
    CPImage     _rightImage;

    CPColor     _fillColor;
}

// Initialize a new CPView object using a rectangle.
// Load 3 images.
// Since image loading is asynchronous we need to set delegates 
// and receive imageDidLoad: messages here.
- (id) initWithFrame:(CGRect)aFrame
{

    self =[super initWithFrame:aFrame];

    _fillColor = [CPColor whiteColor];

    _leftImage = [[CPImage alloc] 
                    initWithContentsOfFile:@"Resources/left.png"];

    _middleImage = [[CPImage alloc] 
                    initWithContentsOfFile:@"Resources/middle.png"];

    _rightImage = [[CPImage alloc] 
                    initWithContentsOfFile:@"Resources/right.png"];

    [_leftImage setDelegate:self];
    [_middleImage setDelegate:self];
    [_rightImage setDelegate:self];

    return self;
}

// This is where we reveive imageDidLoad messages.
// We call setNeedsDisplay: to notify Cappuccino runtime 
// that contents of our view need to be redrawn.
// setNeedsDisplay: makes a note of the redraw request 
// and returns immediately. Subsequently Cappuccino will call 
// drawRect: method when it's appropriate.
- (void)imageDidLoad:(CPImage)anImage
{
    [self setNeedsDisplay:YES];
}


// In order to receive keyboard events from here, 
// We must accept first responder status.
- (BOOL) acceptsFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    console.info("becomeFirstResponder method of MyView has responded YES.");
    return YES;
}


- (BOOL)resignFirstResponder
{
    console.info("resignFirstResponder method of MyView has responded YES.");
    return YES;
}

- (void) keyDown:(CPEvent)theEvent
{
    var letter = [theEvent characters];
    switch(letter){
        case @"y":
            _fillColor = [CPColor yellowColor];
            break;
        case @"r":
            _fillColor = [CPColor redColor];
            break;
        case @"g":
            _fillColor = [CPColor greenColor];
            break;
        case @"b":
            _fillColor = [CPColor blueColor];
            break;
        default:
            _fillColor = [CPColor whiteColor];
    }

    [self setNeedsDisplay:YES];
}

// Here we tell Cappuccino what to draw and how...
// First we draw a bezier path around the frame rectangle.
// Then we place 3 images on it.
- (void) drawRect:(CGRect)dirtyRect{
    
    // Draw a rounded rectangle
    var bezierPath = [CPBezierPath 
            bezierPathWithRoundedRect:
                [self bounds] xRadius:8.0 yRadius:8.0];

    [_fillColor setFill];
    [CPBezierPath fillRect:[self bounds]];

    [[CPColor grayColor] setStroke];
    [bezierPath stroke];



    // Get the drawing context for the images...
    var context = [[CPGraphicsContext currentContext] graphicsPort];



    // Draw _leftImage
    // Begin with creating a rectangle to put the image in...
    var aRect = CGRectMake(
        0, // x
        0, // y
        [_leftImage size].width, // width
        [_leftImage size].height // height
    );
    // Place the image in the rectangle
    CGContextDrawImage(context, aRect, _leftImage);



    // Draw _middleImage
    // _middleImage will tile along the rectangle.
    // Sum of left and right image widths...
    var sumOfWidths = 
        [_leftImage size].width + [_rightImage size].width;
    // Create a rectangle...
    aRect = CGRectMake(
        [_leftImage size].width, // x
        0, // y
        [self bounds].size.width - sumOfWidths, // width
        [_leftImage size].height // height
    );
    // Tile _middleImage
    var aFillColor = [CPColor colorWithPatternImage:_middleImage];
    CGContextSetFillColor(context, aFillColor);
    CGContextFillRect(context, aRect);



    // Draw _rightImage
    var x = [self bounds].size.width - [_rightImage size].width;
    aRect = CGRectMake(
        x, 
        0, // y
        [_rightImage size].width, // width
        [_rightImage size].height); // height

    CGContextDrawImage(context, aRect, _rightImage);

}

@end
