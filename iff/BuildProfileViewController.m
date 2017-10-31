#import "BuildProfileViewController.h"

#import "QuestionViewController.h"

@implementation BuildProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = self;
    
    QuestionViewController *initialVC = (QuestionViewController *) [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
    [self setViewControllers:viewControllers
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *) viewControllerAtIndex:(NSUInteger)index
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:[[NSArray arrayWithObjects:
                                                                                                  @"FirstQViewController",
                                                                                                  @"SecondQViewController",
                                                                                                  @"ThirdQViewController", nil] objectAtIndex:index]];
    ((QuestionViewController *)viewController).questionIndex = index;

    return viewController;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((QuestionViewController *)viewController).questionIndex;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((QuestionViewController *)viewController).questionIndex;
    if (index == 2 || index == NSNotFound) {
        return nil;
    }
    index++;
    
    return [self viewControllerAtIndex:index];
}

@end
