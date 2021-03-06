#import "NamecardCell.h"

#import "IFFProfile.h"

@implementation NamecardCell

- (NamecardCell *)initWithProfile:(IFFProfile *)userProfile {
    self = [super init];
    if (self) {
        _nameLabel.text = userProfile.fullName;
        _countryLabel.text = userProfile.homeCountry;
        _descriptionLabel.text = userProfile.reason;
    }
    return self;
}

- (void)layoutSubviews
{
    [self cardSetup];
    [self imageSetup];
}

- (void)cardSetup
{
    [self.cardView setAlpha:1];
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.cornerRadius = 15;
    self.cardView.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    self.cardView.layer.shadowRadius = 15;
    self.cardView.layer.shadowOpacity = 0.2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    self.cardView.layer.shadowPath = path.CGPath;
    self.cardView.frame = CGRectMake(27, 243, 320, 180);
    if (_accepted) {
        [self.buttonView setHidden:YES];
    } else {
        self.buttonView.frame = CGRectMake(10, 143, 300, 36);
        self.buttonView.layer.shadowRadius = 5;
        self.buttonView.layer.shadowOpacity = 0.2;
    }
    
}

- (void)imageSetup
{
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFit;
    _profileImage.backgroundColor = [UIColor whiteColor];
}

- (void)configureDetails:(IFFProfile *)profile
{
    self.nameLabel.text = profile.fullName;
    self.countryLabel.text = profile.homeCountry;
    self.descriptionLabel.text = profile.reason;
}


@end

