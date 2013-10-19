#import <Foundation/Foundation.h>

@interface MIPlayer : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSNumber *uniformNumber;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *contractUntilDate;
@property (strong, nonatomic) NSString *season;
@property (strong, nonatomic) NSString *imageName;

@property (strong, nonatomic) NSString *fullName;

@end
