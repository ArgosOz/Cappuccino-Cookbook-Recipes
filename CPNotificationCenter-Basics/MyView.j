@import <AppKit/CPView.j>

/* 
When the application has finished launching, it will send a ColorChange notification through the default notification center with the color red. 

In our custom view, which is just a white filled rectangle with a gray border, 
we add ourselves as an observer in the default notification center observing the ColorChange notification. 

We also specify that the setColor: method should be called when we receive the notification. 
In the setColor: method of our view, we pull the color out of the notification and set the color property of our view. 
We then call the setNeedsDisplay:YES method to force our view to redraw with the new color. 
*/
@implementation MyView : CPView
{
    CPColor     _color;
}

- (id)initWithFrame:(CPRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        _color = [CPColor whiteColor];
        var notificationCenter = [CPNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(handleColorChange:) name:@"ColorChange" object:nil];
    }
    return self;
}

- (void) drawRect:(CPRect)dirtyRect {
    var path = [CPBezierPath bezierPathWithRect:[self bounds]];
	[_color set];
	[path fill];
	
	[[CPColor grayColor] set];
	[path setLineWidth:3.0];
	[path stroke];	
}

- (void) handleColorChange:(CPNotification)notification {
	/* console.info(@"ColorChange notification has been received."); */
	
	var colorDictionary = [notification userInfo];
	_color = [colorDictionary objectForKey:@"fillColor"];
	
	[self setNeedsDisplay:YES];
}

@end

