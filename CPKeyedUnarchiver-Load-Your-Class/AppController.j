@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import <MBSteps/StepsWindowController.j>

@import "Data.j"

@implementation AppController : CPObject
{
    @outlet CPWindow            theWindow;
            CPWindowController  _stepsWindowController;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _stepsWindowController = [StepsWindowController alloc];

    [_stepsWindowController setPathPrefix:@"../../"];

    [_stepsWindowController initWithWindowCibPath:@"../../Frameworks/MBSteps/Resources/StepsWindow.cib" owner:_stepsWindowController];
    [_stepsWindowController showWindow:self];

    var currentFrameSize = [[_stepsWindowController window] frame].size;
    var newHeight = ([[_stepsWindowController tableView] rowHeight] * 10) + 63;
    [[_stepsWindowController window] setFrameSize:CGSizeMake(currentFrameSize.width, newHeight)];



    var userDefaults = [CPUserDefaults standardUserDefaults];
    var dataRawString = [userDefaults objectForKey:@"archivedData"];
    
    var data = [CPKeyedUnarchiver unarchiveObjectWithData:[CPData dataWithRawString:dataRawString]];

    console.info("\n\n");
    console.info(@"Version: ", [data version]);
    console.info(@"Date: ", [data date]);
    console.info(@"Names: ", [data names]);
    console.info("\n\n");
    
    console.info("\n\n");
    console.info("Data object has been loaded.");
    console.info("See 'CPKeyedArchiver Save Your Class' project.");    
    console.info("\n\n");

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

    // var TEST_APP1 = 2;


    var DASH = 999;
    var APPLE_REFERENCE = 981;
    var url;
    var openNewTab = "_blank";
    switch([sender tag]){
        case GITHUB_REPO:
            url = "https://github.com/ArgosOz/Cappuccino-Cookbook-Recipes/tree/master/CPKeyedUnarchiver-Load-Your-Class";
            break;
        case CLASS_REFERENCE:
            url = "http://www.cappuccino-project.org/learn/documentation/interface_c_p_keyed_unarchiver.html";
            break;
        case APPLE_REFERENCE:
            url = "https://developer.apple.com/documentation/foundation/nskeyedunarchiver?language=objc";
            break;
        case DASH:
            url = "dash://cappuccino:CPKeyedUnarchiver";
            openNewTab = "_self";
            break;
        // case TEST_APP1:
        //     url = "https://cappuccino-testbook.5apps.com/?t=KeyViewLoopTest";
        //     break;
    }
    window.open(url, openNewTab);
}

@end
