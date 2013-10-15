#import "MICalendarItem.h"

@implementation MICalendarItem

@synthesize id, homeClub, guestClub, matchDate;

-(NSString *)getMatchDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy 'u' HH:mm"];    
    
    NSString *result = [dateFormatter stringFromDate:(NSDate *) matchDate];    
    return result;
}

@end
