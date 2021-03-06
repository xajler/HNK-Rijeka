#import "MIMenuViewController.h"
#import "MIHomeViewController.h"
#import "MICurrentResultsViewController.h"
#import "MILeagueTableViewController.h"
#import "MIPlayerViewController.h"

@implementation MIMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 80, 80)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"hnk-rijeka-logo.png"];
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 1)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Prvenstvo 2013/14", nil)];
    }
    else if (sectionIndex == 2)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"Momčad", nil)];
    }
    else if (sectionIndex == 3)
    {
        return [self createViewForTableViewSectionWithLabel:tableView
                                                  withLabel:NSLocalizedString(@"O klubu", nil)];
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 1 || sectionIndex == 2 || sectionIndex == 3)
    {
        return 34;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        MIHomeViewController *homeViewController = [[MIHomeViewController alloc] init];
        navigationController.viewControllers = @[homeViewController];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        MICurrentResultsViewController *currentResultsViewController = [[MICurrentResultsViewController alloc] init];
        navigationController.viewControllers = @[currentResultsViewController];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        MILeagueTableViewController *leagueTableViewController = [[MILeagueTableViewController alloc] init];
        navigationController.viewControllers = @[leagueTableViewController];
    }
    else if (indexPath.section == 2 && indexPath.row ==0)
    {
        MIPlayerViewController *playersViewController = [[MIPlayerViewController alloc] init];
        navigationController.viewControllers =@[playersViewController];
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
    {
        return 1;
    }
    else if (sectionIndex == 1 || sectionIndex == 2)
    {
        return 2;
    }
    else if (sectionIndex == 3)
    {
        return 3;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        NSArray *titles = @[NSLocalizedString(@"Početna", nil)];
        cell.textLabel.text = titles[indexPath.row];
    }
    else if (indexPath.section == 1)
    {
        NSArray *titles = @[NSLocalizedString(@"Utakmice", nil),
                            NSLocalizedString(@"Tablica", nil)];
        cell.textLabel.text = titles[indexPath.row];
    }
    else if (indexPath.section == 2)
    {
        NSArray *titles = @[NSLocalizedString(@"Igrači", nil),
                            NSLocalizedString(@"Stručni stožer", nil)];
        cell.textLabel.text = titles[indexPath.row];
    }
    else if (indexPath.section == 3)
    {
        NSArray *titles = @[NSLocalizedString(@"Organizacija", nil),
                            NSLocalizedString(@"Stadion", nil),
                            NSLocalizedString(@"Povijest", nil)];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

- (UIView *)createViewForTableViewSectionWithLabel:(UITableView *)tableView withLabel:(NSString *)label
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:0.056 green:0.664 blue:0.944 alpha:1.000];//[UIColor colorWithRed:0.212 green:0.392 blue:0.545 alpha:1.000];
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    sectionLabel.text = label;
    sectionLabel.font = [UIFont systemFontOfSize:15];
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
