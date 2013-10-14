#import <UIKit/UIKit.h>

@interface MICurrentCalendarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *homeClubLabel;
@property (weak, nonatomic) IBOutlet UILabel *guestClubLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeClubImageView;
@property (weak, nonatomic) IBOutlet UIImageView *guestClubImageView;
@property (weak, nonatomic) IBOutlet UILabel *matchDateTimeLabel;

@end
