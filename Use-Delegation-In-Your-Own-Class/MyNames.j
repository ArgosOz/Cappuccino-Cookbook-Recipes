/* 
Create a Protocol that describes the methods that a delegate can (or should) implement.
*/
@protocol MyNamesDelegate <CPObject>

    /* @required */
    /* - (void)walk; */

    @optional
    - (BOOL) shouldDeleteName:(CPString)name;

@end




@implementation MyNames : CPObject
{
    CPArray                     _array;
    id <MyNamesDelegate>        _delegate @accessors(property=delegate);

}

- (id) init {
     self = [super init];
     if (self != nil) {
        _array = [[CPMutableArray alloc] init];
        [_array addObject:@"Thor"];
        [_array addObject:@"Hulk"];
        [_array addObject:@"Iron Man"];
        [_array addObject:@"Ant-Man"];
        [_array addObject:@"Spider-Man"];
     }
     return self;
}



- (void) deleteName:(CPString)aName
{
    if([_array containsObject:aName] == YES){
        // check that if the delegate has been set
        if(_delegate != nil){
            // call respondsToSelector: to determine
            // if the delegate has implemented the method
            if([_delegate respondsToSelector:@selector(shouldDeleteName:)] == YES){
                // call the shouldDeleteName: method 
                // on the delegate class...                
                if([_delegate shouldDeleteName:aName] == YES){
                    console.info("FROM MyNames.j : ", aName, "has been deleted.");
                    [_array removeObject:aName];
                }
            }
        }
    }
}

@end
