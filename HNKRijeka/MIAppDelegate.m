#import "MIAppDelegate.h"
#import "MINavigationController.h"
#import "MIHomeViewController.h"
#import "MIMenuViewController.h"
#import "MIUnderlayNavigationBar.h"

@implementation MIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MINavigationController *navigationController = [[MINavigationController alloc] initWithRootViewController:[[MIHomeViewController alloc] init]];
    //MINavigationController *navigationController = [[MINavigationController alloc] initWithNavigationBarClass:[MIUnderlayNavigationBar class] toolbarClass:nil];
    MIMenuViewController *menuController = [[MIMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    self.window.rootViewController = frostedViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.056 green:0.664 blue:0.944 alpha:1.000]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    }
    
    
    
    return YES;
}
@end