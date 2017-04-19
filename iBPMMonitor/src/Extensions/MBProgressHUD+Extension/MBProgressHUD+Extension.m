// *************************************************************************************************
// # MARK: Imports


#import "MBProgressHUD+Extension.h"


// *************************************************************************************************
// # MARK: Constants


#define LoadingText NSLocalizedString(@"Searching...", @"HUD loading title")


// *************************************************************************************************
// # MARK: Implementation


@implementation MBProgressHUD (Extension)


+ (void)hideWaitIndicator:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+ (void)showWaitIndicator:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.label.text = LoadingText;
}


@end
