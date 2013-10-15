#import "MICurrentResultsViewController.h"
#import "MINavigationController.h"
#import "MIGameResult.h"
#import "MICalendarCell.h"
#import "MISqlLiteQuery.h"

@interface MICurrentResultsViewController ()

@property (nonatomic, strong) NSMutableArray *gameResults;
@property (nonatomic, strong) MISqlLiteQuery *query;

@end

@implementation MICurrentResultsViewController

NSString *currentSeason = @"2013/14";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.query = [[MISqlLiteQuery alloc] init];
	self.title = NSLocalizedString(@"Rezultati", nil);
    
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
    self.gameResults = [self.query getGameResultsFor:currentSeason];
}

#pragma mark -
#pragma mark UITableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    return [self createViewForTableViewSectionWithLabel:tableView withLabel:currentSeason];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.gameResults count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    [cell unhideScoreLabels];
    
    MIGameResult *gameResult = self.gameResults[indexPath.row];
    cell.homeClubLabel.text = gameResult.homeClub.shortName;
    cell.guestClubLabel.text = gameResult.guestClub.shortName;
    cell.homeClubImageView.image = [UIImage imageNamed:gameResult.homeClub.imageName];
    cell.guestClubImageView.image = [UIImage imageNamed:gameResult.guestClub.imageName];
    cell.matchDateTimeLabel.text = [gameResult getDateAsString];
    cell.homeGoalsLabel.text = [[gameResult homeGoals] stringValue];
    cell.guestGoalsLabel.text = [[gameResult guestGoals] stringValue];
    
    return cell;
}


- (UIView *)createViewForTableViewSectionWithLabel:(UITableView *)tableView withLabel:(NSString *)label
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.212 green:0.392 blue:0.545 alpha:1.000];
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 0, 0)];
    sectionLabel.text = label;
    sectionLabel.font = [UIFont systemFontOfSize:14];
    sectionLabel.textColor = [UIColor whiteColor];
    sectionLabel.backgroundColor = [UIColor clearColor];
    [sectionLabel sizeToFit];
    [view addSubview:sectionLabel];
    return view;
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
@end
