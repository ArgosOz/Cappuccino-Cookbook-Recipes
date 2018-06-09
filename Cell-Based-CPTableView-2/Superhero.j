@implementation Superhero : CPObject
{
    CPString    _superhero @accessors(property=superhero);
    CPString    _publisher @accessors(property=publisher);
}

- (id) init
{
    self = [super init];
    if(self){
        _superhero = @"Spider-Man";
        _publisher = @"Marvel Comics";
    }

    return self;
}

@end
