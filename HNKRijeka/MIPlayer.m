#import "MIPlayer.h"

@implementation MIPlayer

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

@end
