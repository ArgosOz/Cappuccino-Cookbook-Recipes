@implementation Data : CPObject
{
    CPInteger       version @accessors();
    CPDate          date @accessors();
    CPMutableArray  names @accessors();
}

- (void) encodeWithCoder:(CPCoder)encoder
{
    [encoder encodeObject:[self version] forKey:@"version"];
    [encoder encodeObject:date forKey:@"date"];
    [encoder encodeObject:names forKey:@"names"];
}

- (id) initWithCoder:(CPCoder)decoder
{
    self = [super init];
    if(self != nil){
        version = [decoder decodeObjectForKey:@"version"];
        date = [decoder decodeObjectForKey:@"date"];
        names = [[CPMutableArray alloc] initWithArray:[decoder decodeObjectForKey:@"names"]];
    }
    return self;
}

@end
