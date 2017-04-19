// *************************************************************************************************
// # MARK: Imports


#import "iBPMSettingsViewController.h"

#import "iBPMAuthenticationManager.h"
#import "iBPMBarBackButtonItem.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMSettingsViewController ()

@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMSettingsViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMSettingsViewController *)newViewController {
    iBPMSettingsViewController *settingViewController
        = [[iBPMSettingsViewController alloc] initWithNibName:@"iBPMSettingsViewController"
                                                       bundle:nil];
    
    return settingViewController;
}


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
// # MARK: Private Methods


- (void)_setup {

    [self.view setBackgroundColor:[iBPMColorUtils sidebarTableViewBackgroundColor]];
    iBPMBarBackButtonItem *backButton =
    [[iBPMBarBackButtonItem alloc] initWithImageName:@"dismissButton"
                                              target:self
                                              action:@selector(backButtonDidPress:)];
    [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
    [self setTitle:@"Settings"];
}


// *************************************************************************************************
// # MARK: Button Handlers


- (void)backButtonDidPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)logOutButtonDidPress:(id)sender {
    [[iBPMAuthenticationManager sharedManager] setAuthCookies:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(logOutButtonDidPress)])
        [self.delegate logOutButtonDidPress];
    
}


@end
