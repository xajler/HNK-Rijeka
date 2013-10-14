#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface MIMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, readwrite, nonatomic) UINavigationController *navigationController;

@end
