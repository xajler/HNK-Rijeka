#import <Foundation/Foundation.h>
#import "MIClub.h"

@interface MIGameResult : NSObject

@property (strong, atomic) NSNumber *id;
@property (strong, atomic) NSString *season;
@property (strong, atomic) NSDate *date;
@property (strong, atomic) MIClub *homeClub;
@property (strong, atomic) MIClub *guestClub;
@property (strong, atomic) NSNumber *homeGoals;
@property (strong, atomic) NSNumber *guestGoals;
@property (strong, atomic) NSNumber *number;

-(NSString *)getDateAsString;
@end
