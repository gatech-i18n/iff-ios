#import "ProfileBasicInfoView.h"

@implementation ProfileBasicInfoView

-(void)layoutSubviews
{
    [self imageSetup];
}

-(void)imageSetup
{
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFit;
    _profileImage.backgroundColor = [UIColor whiteColor];
}
@end

