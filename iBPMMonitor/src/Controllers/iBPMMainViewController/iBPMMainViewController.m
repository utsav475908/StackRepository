// *************************************************************************************************
// # MARK: Imports


#import "iBPMMainViewController.h"

#import "iBPMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMMainViewController ()

@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMMainViewController


// *************************************************************************************************
// # MARK: View Controller Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Setter Methods


- (void)setNavigationBarTitle:(NSString *)navigationBarTitle {
    _navigationBarTitle = navigationBarTitle;
    [self setTitle:[self.navigationBarTitle uppercaseString]];
}

// *************************************************************************************************
// # MARK: Private Interfaces


- (void)_setup {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self _setupLeftMenuButton];
}


-(void)_setupLeftMenuButton {
    iBPMDrawerBarButtonItem *leftDrawerButton =
    [[iBPMDrawerBarButtonItem alloc] initWithTarget:self
                                             action:@selector(leftDrawerButtonPress:)
                                              style:iBPMNavigationBarItemStyleMenu];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}


// *************************************************************************************************
// # MARK: Button Action Handler


-(void)leftDrawerButtonPress:(id)sender {
    [self.mm_drawerController setShowsShadow:YES];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft
                                      animated:YES
                                    completion:nil];
}


@end
