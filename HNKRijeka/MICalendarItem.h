#import <Foundation/Foundation.h>
#import "MIClub.h"

@interface MICalendarItem : NSObject

@property (strong, atomic) NSNumber *id;
@property (strong, atomic) MIClub *homeClub;
@property (strong, atomic) MIClub *guestClub;
@property (strong, atomic) NSDate *matchDate;

-(NSString *)getMatchDateAsString;

@end
