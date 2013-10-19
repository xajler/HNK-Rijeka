#import <Foundation/Foundation.h>
#import "MIClub.h"

@interface MILeagueTableItem : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *season;
@property (strong, nonatomic) NSNumber *position;
@property (strong, nonatomic) NSNumber *wins;
@property (strong, nonatomic) NSNumber *draws;
@property (strong, nonatomic) NSNumber *loses;
@property (strong, nonatomic) NSNumber *goalFor;
@property (strong, nonatomic) NSNumber *goalAgainst;
@property (strong, nonatomic) NSNumber *points;
@property (strong, nonatomic) MIClub *club;

@end
