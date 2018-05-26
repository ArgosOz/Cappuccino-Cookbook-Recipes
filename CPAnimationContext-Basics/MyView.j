@implementation MyView : CPView
{}

- (void)drawRect:(CPRect)dirtyRect {
	var path = [CPBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:8.0 yRadius:8.0];
	[path setClip];
	
	[[CPColor whiteColor] setFill];
	[CPBezierPath fillRect:[self bounds]];
	
	[path setLineWidth:3.0];
	
	[[CPColor grayColor] setStroke];
	[path stroke];
}

@end
