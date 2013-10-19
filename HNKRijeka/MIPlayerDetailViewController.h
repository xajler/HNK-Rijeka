#import <UIKit/UIKit.h>
#import "MIPlayer.h"

@interface MIPlayerDetailViewController : UIViewController

@property (strong, nonatomic) MIPlayer *player;

@property (weak, nonatomic) IBOutlet UILabel *uniformNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *contractUntilDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UILabel *cmLabel;
@property (weak, nonatomic) IBOutlet UILabel *kgLabel;

@end
