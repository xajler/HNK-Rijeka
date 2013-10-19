#import "MIPlayerViewController.h"
#import "MIPlayer.h"
#import "MIPlayerCell.h"
#import "MISqlLiteQuery.h"
#import "MINavigationController.h"
#import "MIPlayerDetailViewController.h"

@implementation MIPlayerViewController

NSMutableArray *_goalkeepers;
NSMutableArray *_defenders;
NSMutableArray *_midfileders;
NSMutableArray *_forwarders;

MISqlLiteQuery *_query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _query = [[MISqlLiteQuery alloc] init];
	self.title = NSLocalizedString(@"Igrači", nil);
    
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
    self.tableView.tableFooterView.hidden = YES;
   // self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setPlayerPositonArrays];
}

#pragma mark -
#pragma mark UITableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Vratar", nil)];
    }
    else if (sectionIndex == 1)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Obrambeni", nil)];
    }
    else if (sectionIndex == 2)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Vezni", nil)];
    }
    else if (sectionIndex == 3)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Napadač", nil)];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIPlayerDetailViewController *playerDetailViewController = [[MIPlayerDetailViewController alloc] initWithNibName:@"PlayerDetailView"
                                                                                                              bundle:[NSBundle mainBundle]];
    MIPlayer *player;
    
    if (indexPath.section == 0)
    {
        player = _goalkeepers[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        player = _defenders[indexPath.row];
    }
    else if (indexPath.section == 2)
    {
        player = _midfileders[indexPath.row];
    }
    else if (indexPath.section == 3)
    {
        player = _forwarders[indexPath.row];
    }
    
    playerDetailViewController.player = player;
    [self.navigationController pushViewController:playerDetailViewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
    {
        return [_goalkeepers count];
    }
    else if (sectionIndex == 1)
    {
        return [_defenders count];
    }
    else if (sectionIndex == 2)
    {
       return [_midfileders count];
    }
    else if (sectionIndex == 3)
    {
        return [_forwarders count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    MIPlayerCell *cell = (MIPlayerCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PlayerCell"
                                                                 owner:self
                                                               options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (MIPlayerCell *)currentObject;
                break;
            }
        }
    }
    
    MIPlayer *player;
    
    if (indexPath.section == 0)
    {
        player = _goalkeepers[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        player = _defenders[indexPath.row];
    }
    else if (indexPath.section == 2)
    {
        player = _midfileders[indexPath.row];
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row >= 5)
        {
            return cell;
        }
        player = _forwarders[indexPath.row];
    }
    
    
    NSString *number = @"-";
    
    if (player.uniformNumber != [NSNumber numberWithInt:0])
    {
        number = [[player uniformNumber] stringValue];
    }
    
    cell.numberLabel.text = number;
    cell.playerFullNameLabel.text = player.fullName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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

-(void)setPlayerPositonArrays
{
    _goalkeepers = [_query getPlayersForSeason:MICurrentSeason andPositon:@"Vratar"];
    _defenders = [_query getPlayersForSeason:MICurrentSeason andPositon:@"Obrambeni"];
    _midfileders = [_query getPlayersForSeason:MICurrentSeason andPositon:@"Vezni"];
    _forwarders = [_query getPlayersForSeason:MICurrentSeason andPositon:@"Napadač"];
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
