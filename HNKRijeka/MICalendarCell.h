#import <UIKit/UIKit.h>

@interface MICalendarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *homeClubLabel;

@property (weak, nonatomic) IBOutlet UILabel *guestClubLabel;

@property (weak, nonatomic) IBOutlet UILabel *matchDateTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *homeClubImageView;

@property (weak, nonatomic) IBOutlet UIImageView *guestClubImageView;

@end
