#import "MIPlayerDetailViewController.h"

@implementation MIPlayerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _player.fullName;
    [self setPlyerDetailViewOutlets];
}

-(void)setPlyerDetailViewOutlets
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    if (_player.uniformNumber == [NSNumber numberWithInt:0])
    {
         _uniformNumberLabel.text = @"";
    }
    else
    {
        _uniformNumberLabel.text = [_player.uniformNumber stringValue];
    }
    
    _playerImageView.image = [UIImage imageNamed:_player.imageName];
    _positionLabel.text = _player.position;
    _dateOfBirthLabel.text = [formatter stringFromDate:_player.birthDate];
    
    if ((double)[_player.contractUntilDate timeIntervalSince1970] != 0)
    {
        _contractUntilDateLabel.text = [formatter stringFromDate:_player.contractUntilDate];
    }
    
    if (_player.height != [NSNumber numberWithInt:0])
    {
        _cmLabel.hidden = NO;
        _heightLabel.text = [_player.height stringValue];
    }
    else
    {
        _cmLabel.hidden = YES;
    }
    
    if (_player.weight != [NSNumber numberWithInt:0])
    {
        _kgLabel.hidden = NO;
        _weightLabel.text = [_player.weight stringValue];
    }
    else
    {
        _kgLabel.hidden = YES;
    }
    
    if ([_player.about length] == 0)
    {
        _aboutTextView.hidden = YES;
    }
    else
    {
        _aboutTextView.hidden = NO;
        _aboutTextView.text = _player.about;
    }
}


@end
