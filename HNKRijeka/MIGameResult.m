#import "MIGameResult.h"

@implementation MIGameResult

-(NSString *)getDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy 'u' HH:mm"];
    
    NSString *result = [dateFormatter stringFromDate:(NSDate *) _date];
    return result;
}

@end
