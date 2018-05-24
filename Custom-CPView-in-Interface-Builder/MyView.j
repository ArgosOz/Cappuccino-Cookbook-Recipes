@import <AppKit/CPView.j>
@import <AppKit/CPBezierPath.j>


@implementation MyView : CPView
{

    CPImage     _leftImage;
    CPImage     _middleImage;
    CPImage     _rightImage;
}

- (void) drawRect:(CGRect)dirtyRect{
    
    var bezierPath = [CPBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:8.0 yRadius:8.0];

    [[CPColor whiteColor] setFill];
    [CPBezierPath fillRect:[self bounds]];

    [[CPColor grayColor] setStroke];
    [bezierPath stroke];


    var context = [[CPGraphicsContext currentContext] graphicsPort];

    var aRect = CGRectMake(0, 0, [_leftImage size].width, [_leftImage size].height);
    CGContextDrawImage(context, aRect, _leftImage);

    aRect = CGRectMake([_leftImage size].width, 0,[self bounds].size.width - ([_leftImage size].width + [_rightImage size].width), [_leftImage size].height);
    var aFillColor = [CPColor colorWithPatternImage:_middleImage];
    CGContextSetFillColor(context, aFillColor);
    CGContextFillRect(context, aRect);

    aRect = CGRectMake([self bounds].size.width - [_rightImage size].width, 0, [_rightImage size].width, [_rightImage size].height);
    CGContextDrawImage(context, aRect, _rightImage);

}

- (void)imageDidLoad:(CPImage)anImage
{
    [self setNeedsDisplay:YES];
}



- (id) initWithFrame:(CGRect)aFrame
{

    self =[super initWithFrame:aFrame];

    _leftImage = [[CPImage alloc] initWithContentsOfFile:@"Resources/left.png"];
    _middleImage = [[CPImage alloc] initWithContentsOfFile:@"Resources/middle.png"];
    _rightImage = [[CPImage alloc] initWithContentsOfFile:@"Resources/right.png"];

    [_leftImage setDelegate:self];
    [_middleImage setDelegate:self];
    [_rightImage setDelegate:self];
    /* _rootLayer = [CALayer layer]; */

    /* [self setWantsLayer:YES]; */
    /* [self setLayer:_rootLayer]; */

    /* [_rootLayer setBackgroundColor:[CPColor blackColor]]; */

    /* _myLayer = [MyLayer alloc] initWithMyView */

    /* [_rootLayer setNeedsDisplay]; */

    return self;
}



@end
