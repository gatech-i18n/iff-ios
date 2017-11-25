#import <UIKit/UIKit.h>

@class IFFProfile;

@interface NamecardCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *rejectButton;

@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) NSString *accepted;

- (NamecardCell *)initWithProfile:(IFFProfile *)userProfile;

- (void)configureDetails:(IFFProfile *)profile;

@end
