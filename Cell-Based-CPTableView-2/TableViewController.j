@import "Superhero.j"

@implementation TableViewController : CPObject <CPTableViewDataSource>
{
    @outlet CPTableView     _tableView;
            CPMutableArray  _list;
}

- (id) init
{
    self = [super init];
    if(self){
        _list = [[CPMutableArray alloc] init];
    }
    return self;
}

- (CPInteger) numberOfRowsInTableView:(CPTableView)tableView
{
    return [_list count];
}

- (id) tableView:(CPTableView)tableView objectValueForTableColumn:(CPTableColumn)tableColumn row:(CPInteger)row
{
    var superhero = [_list objectAtIndex:row];
    var identifier = [tableColumn identifier];
    return [superhero valueForKey:identifier];
}

- (void) tableView:(CPTableView)tableView setObjectValue:(id)object forTableColumn:(CPTableColumn)tableColumn row:(CPInteger)row
{
    var superhero = [_list objectAtIndex:row];
    var identifier = [tableColumn identifier];
    [superhero setValue:object forKey:identifier];
}

- (IBAction) addButtonClicked:(id)sender
{
    [_list addObject:[[Superhero alloc] init]];
    [_tableView reloadData];
}

- (IBAction) removeButtonClicked:(id)sender
{
    var row = [_tableView selectedRow];
    if(row > -1){
        [_list removeObjectAtIndex:row];
        [_tableView reloadData];
    }
}

@end
