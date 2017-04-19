// *************************************************************************************************
// # MARK: Public Interface


@interface UIAlertController (Extension)


+ (void)showAlertFor:(UIViewController *)viewController;
+ (void)showAlertFor:(UIViewController *)viewController
           withTitle:(NSString *)title
             message:(NSString *)message;


@end
