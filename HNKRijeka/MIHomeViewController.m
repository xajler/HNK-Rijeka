#import "MIHomeViewController.h"
#import "MINavigationController.h"
#import "MICurrentCalendarCell.h"
#import "MICalendarItem.h"
#import "MICalendarCell.h"

@interface MIHomeViewController ()

@property (nonatomic, strong) NSMutableArray *calendarItems;

@end

@implementation MIHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//self.title = @"Home Controller";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(MINavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
   // [self setCalendarItems];
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
    return 2;
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
        
        MICalendarItem *calendarItem = [[MICalendarItem alloc] init];
        calendarItem.homeClubName = @"Rijeka";
        calendarItem.guestClubName = @"Slaven Belupo";
        calendarItem.homeClubImage = [UIImage imageNamed:@"rijeka.png"];
        calendarItem.guestClubImage = [UIImage imageNamed:@"slaven_belupo.png"];
        calendarItem.matchDate = [NSDate date];
        cell.homeClubLabel.text = [calendarItem homeClubName];
        cell.guestClubLabel.text = [calendarItem guestClubName];
        cell.homeClubImageView.image = [calendarItem homeClubImage];
        cell.guestClubImageView.image = [calendarItem guestClubImage];
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
        
        MICalendarItem *calendarItem = [[MICalendarItem alloc] init];
        calendarItem.homeClubName = @"Lokomotiva";
        calendarItem.guestClubName = @"Rijeka";
        calendarItem.homeClubImage = [UIImage imageNamed:@"lokomotiva.png"];
        calendarItem.guestClubImage = [UIImage imageNamed:@"rijeka.png"];
        calendarItem.matchDate = [NSDate date];
        cell.homeClubLabel.text = [calendarItem homeClubName];
        cell.guestClubLabel.text = [calendarItem guestClubName];
        cell.homeClubImageView.image = [calendarItem homeClubImage];
        cell.guestClubImageView.image = [calendarItem guestClubImage];
        cell.matchDateTimeLabel.text = [calendarItem getMatchDateAsString];
        return cell;
    }
}

-(void)setCalendarItems
{
    MICalendarItem *calendarItem = [[MICalendarItem alloc] init];
    calendarItem.homeClubName = @"HNK Rijeka";
    calendarItem.guestClubName = @"HNK Hajduk";
    calendarItem.homeClubImage = [UIImage imageNamed:@"rijeka.png"];
    calendarItem.guestClubImage = [UIImage imageNamed:@"hajduk.png"];
    calendarItem.matchDate = [NSDate date];
    
    [self.calendarItems addObject:calendarItem];
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
@end
