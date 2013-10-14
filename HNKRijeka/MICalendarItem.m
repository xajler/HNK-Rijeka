#import "MICalendarItem.h"

@implementation MICalendarItem

@synthesize homeClubName, guestClubName, homeClubImage, guestClubImage, matchDate;


-(NSString *)getMatchDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy 'u' HH:mm"];
    
    NSString *result = [dateFormatter stringFromDate:self.matchDate];
    return result;
}

@end
