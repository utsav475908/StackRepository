// *************************************************************************************************
// # MARK: Imports


#import "iBPMLoginViewController.h"

#import "iBPMAuthenticationManager.h"
#import "iBPMDataProviderManager.h"
#import "iBPMDataProvider+PostProcessor.h"
#import "iBPMDomainViewController.h"
#import "iBPMDrawerVisualStateManager.h"
#import "iBPMMonitorViewController.h"
#import "iBPMNavigationController.h"
#import "iBPMSidebarViewController.h"
#import "iBPMStatusViewController.h"
#import "UIAlertController+Extension.h"
#import "UITextField+Extension.h"
#import "UIColor+Extensions.h"
#import "MBProgressHUD.h"
#import "MMDrawerController.h"


// *************************************************************************************************
// # MARK: Constants


#define kOffsetForKeyboard 180.0
#define kMaximumLeftDrawerWidth 300.0

#define kUserNamePlaceHolder NSLocalizedString(@"Username", nil)
#define kPasswordPlaceHolder NSLocalizedString(@"Password", nil)


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMLoginViewController ()


// *************************************************************************************************
// # MARK: IBOutlets


@property (weak, nonatomic) IBOutlet UITextField *_passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *_userNameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTextFieldBottomConstraint;


// *************************************************************************************************
// # MARK: Private Properties


@property (strong, nonatomic) MMDrawerController *_drawerController;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMLoginViewController


// *************************************************************************************************
// # MARK: View Controller Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.loginButton setEnabled:true];
    [self _setupTextField];
    [self _addGestureRecognizer];
    [self _setupSideBar];
    [self.loginButton setTitleColor:[iBPMColorUtils loginButtonTitleColor]
                           forState:UIControlStateNormal];
    
#warning TODO - Remove these 2 lines at the end
    self._userNameTextField.text = @"qzhan2";
    self._passwordTextField.text = @"Hello1234!";    
    [iBPMStateManager sharedManager].currentLifeCycle = @"prod";
    [iBPMStateManager sharedManager].currentApp = monitorApp;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardWillShow {
    if (self.view.frame.origin.y >= 0) {
        [self _setViewMovedUp:YES];
    }
}


-(void)keyboardWillHide {
    if (self.view.frame.origin.y < 0) {
        [self _setViewMovedUp:NO];
    }
}


// *************************************************************************************************
// # MARK: IBAction


- (IBAction)loginButtonDidPress:(id)sender {
    [MBProgressHUD showWaitIndicator:self.view];
    [[iBPMDataProviderManager dataProvider] loginWithUserID:self._userNameTextField.text
                                                       password:self._passwordTextField.text
                                                        success:^(id results) {
        if ([[iBPMAuthenticationManager sharedManager] isAuthenticated]) {
            [self sendDeviceTokenToServer];
            [MBProgressHUD hideWaitIndicator:self.view];
            [self _showMainScreen];
        } else {
            [MBProgressHUD hideWaitIndicator:self.view];
            [UIAlertController showAlertFor:self withTitle:@"" message:@"Incorrect username or password"];
        }
    } failure:^(NSArray *errors) {
        NSLog(@"error: %@", errors);
    }];
}


// *************************************************************************************************
// # MARK: Public Methods


// *************************************************************************************************
// # MARK: textField Delegate


-(void)textFieldDidBeginEditing:(UITextField *)sender {
    if ([sender isEqual:self._passwordTextField] ||[sender isEqual:self._userNameTextField]) {
        if  (self.view.frame.origin.y >= 0) {
            [self _setViewMovedUp:YES];
        }
    }
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_addGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(_dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}


- (void)_dismissKeyboard {
    [self._userNameTextField resignFirstResponder];
    [self._passwordTextField resignFirstResponder];
}


- (void)_setupTextField {
    [self._userNameTextField addBottomLine];
    [self._passwordTextField addBottomLine];
    self._userNameTextField.placeholder = kUserNamePlaceHolder;
    self._passwordTextField.placeholder = kPasswordPlaceHolder;
}


/*!
 @brief Sets the Side view bar's main screen.
 
 @discussion This method sets the attributes for the Side View Bar.
 
 To use it, simply call @code [self _setupSideBar]; @endcode
 */
- (void)_setupSideBar {
    
    BOOL stat = [[NSUserDefaults standardUserDefaults] valueForKey:@"NotificationStatusActive"];
    if (stat == true) {
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"NotificationStatusActive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *identifier = [[NSUserDefaults standardUserDefaults] valueForKey:@"NotificationIdentifier"];
        if ([identifier containsString:@"status"]) {
            iBPMStatusViewController *mainViewController = [iBPMStatusViewController newViewController];
            [mainViewController setNotificationFlag:TRUE];
            iBPMSidebarViewController *sideBarViweController = [iBPMSidebarViewController newViewController];
            iBPMNavigationController * navigationController
            = [[iBPMNavigationController alloc] initWithRootViewController:mainViewController];
            [navigationController setRestorationIdentifier:@"iBPMCenterNavigationControllerRestorationKey"];
            iBPMNavigationController * leftSideNavController
            = [[iBPMNavigationController alloc] initWithRootViewController:sideBarViweController];
            [leftSideNavController setRestorationIdentifier:@"iBPMLeftNavigationControllerRestorationKey"];
            self._drawerController = [[MMDrawerController alloc]
                                      initWithCenterViewController:navigationController
                                      leftDrawerViewController:leftSideNavController
                                      rightDrawerViewController:nil];
        }
        else if ([identifier containsString:@"monitor"]) {
            iBPMMonitorViewController *mainViewController = [iBPMMonitorViewController newViewController];
            iBPMSidebarViewController *sideBarViweController = [iBPMSidebarViewController newViewController];
            iBPMNavigationController * navigationController
            = [[iBPMNavigationController alloc] initWithRootViewController:mainViewController];
            [navigationController setRestorationIdentifier:@"iBPMCenterNavigationControllerRestorationKey"];
            iBPMNavigationController * leftSideNavController
            = [[iBPMNavigationController alloc] initWithRootViewController:sideBarViweController];
            [leftSideNavController setRestorationIdentifier:@"iBPMLeftNavigationControllerRestorationKey"];
            self._drawerController = [[MMDrawerController alloc]
                                      initWithCenterViewController:navigationController
                                      leftDrawerViewController:leftSideNavController
                                      rightDrawerViewController:nil];
        }
        else {
            iBPMMonitorViewController *mainViewController = [iBPMMonitorViewController newViewController];
            iBPMSidebarViewController *sideBarViweController = [iBPMSidebarViewController newViewController];
            iBPMNavigationController * navigationController
            = [[iBPMNavigationController alloc] initWithRootViewController:mainViewController];
            [navigationController setRestorationIdentifier:@"iBPMCenterNavigationControllerRestorationKey"];
            iBPMNavigationController * leftSideNavController
            = [[iBPMNavigationController alloc] initWithRootViewController:sideBarViweController];
            [leftSideNavController setRestorationIdentifier:@"iBPMLeftNavigationControllerRestorationKey"];
            self._drawerController = [[MMDrawerController alloc]
                                      initWithCenterViewController:navigationController
                                      leftDrawerViewController:leftSideNavController
                                      rightDrawerViewController:nil];
        }
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"NotificationIdentifier"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        iBPMMonitorViewController *mainViewController = [iBPMMonitorViewController newViewController];
        iBPMSidebarViewController *sideBarViweController = [iBPMSidebarViewController newViewController];
        iBPMNavigationController * navigationController
        = [[iBPMNavigationController alloc] initWithRootViewController:mainViewController];
        [navigationController setRestorationIdentifier:@"iBPMCenterNavigationControllerRestorationKey"];
        iBPMNavigationController * leftSideNavController
        = [[iBPMNavigationController alloc] initWithRootViewController:sideBarViweController];
        [leftSideNavController setRestorationIdentifier:@"iBPMLeftNavigationControllerRestorationKey"];
        self._drawerController = [[MMDrawerController alloc]
                                  initWithCenterViewController:navigationController
                                  leftDrawerViewController:leftSideNavController
                                  rightDrawerViewController:nil];
    }

    [self._drawerController setRestorationIdentifier:@"iBPMSidebar"];
    [self._drawerController setMaximumLeftDrawerWidth:kMaximumLeftDrawerWidth];
    [self._drawerController setMaximumRightDrawerWidth:self.view.bounds.size.width];
    [self._drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self._drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self._drawerController
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController,
                                     MMDrawerSide drawerSide,
                                     CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block
                = [[iBPMDrawerVisualStateManager sharedManager]
                   drawerVisualStateBlockForDrawerSide:drawerSide];
             block(drawerController, drawerSide, percentVisible);
         }];
}


-(void)_setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    if (movedUp) {
        rect.origin.y -= kOffsetForKeyboard;
        rect.size.height += kOffsetForKeyboard;
        self.userTextFieldBottomConstraint.constant += kOffsetForKeyboard;
    } else {
        rect.origin.y += kOffsetForKeyboard;
        rect.size.height -= kOffsetForKeyboard;
        self.userTextFieldBottomConstraint.constant -= kOffsetForKeyboard;
    }
    self.view.frame = rect;

    [UIView commitAnimations];
}


/*!
 @brief Sends the device token to the Server.
 
 @discussion This method gets the device token from NSUserDefaults and sends it to the Server.
 
 To use it, simply call @code [self sendDeviceTokenToServer]; @endcode
 */
- (void)sendDeviceTokenToServer {
    
    [[iBPMDataProviderManager dataProvider]
     sendDeviceToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"]
     success:^(id results) {
         NSLog(@"Success");
     } failure:^(NSArray *errors) {
         NSLog(@"\n\nError : %@",errors);
     }];
}


/*!
 @brief Presents the Main Screen.
 
 @discussion This method gets the main screen and presents it.
 
 To use it, simply call @code [self _showMainScreen]; @endcode
 */
- (void)_showMainScreen {
    [self presentViewController:self._drawerController
                       animated:NO
                     completion:nil];
}


@end
