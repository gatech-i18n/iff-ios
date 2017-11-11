#import "NamecardCell.h"

@implementation NamecardCell

-(void)layoutSubviews
{
    [self cardSetup];
    [self imageSetup];
}

-(void)cardSetup
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
    self.buttonView.frame = CGRectMake(10, 143, 300, 36);
    self.buttonView.layer.shadowRadius = 5;
    self.buttonView.layer.shadowOpacity = 0.2;
    
}

-(void)imageSetup
{
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFit;
    _profileImage.backgroundColor = [UIColor whiteColor];
}


@end

