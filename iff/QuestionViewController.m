#import "QuestionViewController.h"

@interface QuestionViewController() {
    NSArray *_countries;
}
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _countries = @[@"United States", @"China", @"United Kindom"];
    
    self.countryPicker.dataSource = self;
    self.countryPicker.delegate = self;
    
    //_answer = [_countries objectAtIndex:[self.countryPicker selectedRowInComponent:0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _countries.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _countries[row];
}

@end

