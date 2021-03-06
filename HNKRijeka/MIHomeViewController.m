#import "MIHomeViewController.h"
#import "MINavigationController.h"
#import "MICurrentCalendarCell.h"
#import "MICalendarItem.h"
#import "MICalendarCell.h"
#import "MISqlLiteQuery.h"

@implementation MIHomeViewController

NSMutableArray *_calendarItems;
MISqlLiteQuery *_query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _query = [[MISqlLiteQuery alloc] init];
	self.title = @"HNK Rijeka";
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rijeka-logo.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-button.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(MINavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.056 green:0.664 blue:0.944 alpha:1.000];
    }

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _calendarItems = [_query getCalendarItems];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 150;
    }
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [_calendarItems count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString *cellIdentifier = @"CurrentCell";
        
        MICurrentCalendarCell *cell = (MICurrentCalendarCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CurrentCalendarCell"
                                                                     owner:self
                                                                   options:nil];
            for (id currentObject in topLevelObjects)
            {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (MICurrentCalendarCell *)currentObject;
                    break;
                }
            }
        }
        
        MICalendarItem *calendarItem = _calendarItems[indexPath.row];
        cell.homeClubLabel.text = calendarItem.homeClub.shortName;
        cell.guestClubLabel.text = calendarItem.guestClub.shortName;
        cell.homeClubImageView.image = [UIImage imageNamed:calendarItem.homeClub.imageName];
        cell.guestClubImageView.image = [UIImage imageNamed:calendarItem.guestClub.imageName];
        cell.matchDateTimeLabel.text = [calendarItem getMatchDateAsString];
        return cell;
    }
    else
    {
        NSString *cellIdentifier = @"Cell";
        
        MICalendarCell *cell = (MICalendarCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CalendarCell"
                                                                     owner:self
                                                                   options:nil];
            for (id currentObject in topLevelObjects)
            {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (MICalendarCell *)currentObject;
                    break;
                }
            }
        }
        
        MICalendarItem *calendarItem = _calendarItems[indexPath.row];
        cell.homeClubLabel.text = calendarItem.homeClub.shortName;
        cell.guestClubLabel.text = calendarItem.guestClub.shortName;
        cell.homeClubImageView.image = [UIImage imageNamed:calendarItem.homeClub.imageName];
        cell.guestClubImageView.image = [UIImage imageNamed:calendarItem.guestClub.imageName];
        cell.matchDateTimeLabel.text = [calendarItem getMatchDateAsString];
        return cell;
    }
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
@end
