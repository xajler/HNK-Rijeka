#import <Foundation/Foundation.h>

@interface MICalendarItem : NSObject

@property (nonatomic, strong) NSString *homeClubName;

@property (nonatomic, strong) NSString *guestClubName;

@property (nonatomic, strong) UIImage *homeClubImage;

@property (nonatomic, strong) UIImage *guestClubImage;

@property (nonatomic, strong) NSDate *matchDate;

-(NSString *)getMatchDateAsString;

@end
