#import <Foundation/Foundation.h>
#import "MIClub.h"

@interface MIGameResult : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *season;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) MIClub *homeClub;
@property (strong, nonatomic) MIClub *guestClub;
@property (strong, nonatomic) NSNumber *homeGoals;
@property (strong, nonatomic) NSNumber *guestGoals;
@property (strong, nonatomic) NSNumber *number;

-(NSString *)getDateAsString;
@end
