#import "MIGameResult.h"

@implementation MIGameResult

@synthesize id, date, homeClub, guestClub, homeGoals, guestGoals, number, season;

-(NSString *)getDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy 'u' HH:mm"];
    
    NSString *result = [dateFormatter stringFromDate:(NSDate *) date];
    return result;
}

@end
