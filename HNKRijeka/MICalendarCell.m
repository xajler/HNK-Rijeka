#import "MICalendarCell.h"

@implementation MICalendarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)unhideScoreLabels
{
    [self.homeGoalsLabel setHidden:NO];
    [self.guestGoalsLabel setHidden:NO];
    [self.scoreSeparatorLabel setHidden:NO];
}

@end
