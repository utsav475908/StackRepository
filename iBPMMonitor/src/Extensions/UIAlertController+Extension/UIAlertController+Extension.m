// *************************************************************************************************
// # MARK: Imports


#import "UIAlertController+Extension.h"


// *************************************************************************************************
// # MARK: Constants


#define alertText NSLocalizedString(@"Service is not available!", nil)
#define buttonTitle NSLocalizedString(@"OK", nil)
#define titleText NSLocalizedString(@"Info", nil)


// *************************************************************************************************
// # MARK: Implementation


@implementation UIAlertController (Extension)


+ (void)showAlertFor:(UIViewController *)viewController {
    UIAlertController * alert = [UIAlertController
                                   alertControllerWithTitle:titleText
                                   message:alertText
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                            actionWithTitle:buttonTitle
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                [alert dismissViewControllerAnimated:YES completion:nil];
                            }];
    [alert addAction:ok];
    [viewController presentViewController:alert animated:YES completion:nil];
}


+ (void)showAlertFor:(UIViewController *)viewController
           withTitle:(NSString *)title
             message:(NSString *)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:buttonTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [viewController presentViewController:alert animated:YES completion:nil];
}


@end
