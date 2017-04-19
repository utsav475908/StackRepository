// *************************************************************************************************
// # MARK: Imports


#import "iBPMNavigationController.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMNavigationController ()


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar
        setBarTintColor:[iBPMColorUtils navigationBarBackgroundColor]];
    NSDictionary *navBarTitleDict
        = @{NSForegroundColorAttributeName:[iBPMColorUtils navigationBarTitleColor],
            NSFontAttributeName:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:18.0f]};
    [self.navigationBar setTitleTextAttributes:navBarTitleDict];
}


@end
