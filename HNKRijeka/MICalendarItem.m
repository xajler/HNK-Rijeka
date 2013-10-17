#import "MICalendarItem.h"

@implementation MICalendarItem


-(NSString *)getMatchDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy 'u' HH:mm"];    
    
    NSString *result = [dateFormatter stringFromDate:(NSDate *) _matchDate];
    return result;
}

@end
