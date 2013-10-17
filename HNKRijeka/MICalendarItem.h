#import <Foundation/Foundation.h>
#import "MIClub.h"

@interface MICalendarItem : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) MIClub *homeClub;
@property (strong, nonatomic) MIClub *guestClub;
@property (strong, nonatomic) NSDate *matchDate;

-(NSString *)getMatchDateAsString;

@end
