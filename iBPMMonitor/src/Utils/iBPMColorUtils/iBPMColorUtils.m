// *************************************************************************************************
// # MARK: Imports


#import "iBPMColorUtils.h"

#import "UIColor+Extensions.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMColorUtils


// *************************************************************************************************
// # MARK:  Table View Section Header Colors


+ (UIColor *)sideDrawerSectionHeaderColor {
    
    return [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.7];
}


+ (UIColor *)sideDrawerSectionHeaderLineColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.1];
}


+ (UIColor *)sidebarSectionHeaderTextColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.7];
}


// *************************************************************************************************
// # MARK:  Sidebar Colors


+ (UIColor *)sidebarViewBackgroundColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)sidebarTableViewBackgroundColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)sidebarNavigationBarColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)sidebarTableViewCellBackgroundColor {
    
    return [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.3];
}


+ (UIColor *)sidebarTableViewCellTextColor {
    
    return [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.7];
}


// *************************************************************************************************
// # MARK:  Main Table View Colors


+ (UIColor *)mainTableViewBackgroundColor {
    
    return [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.1];
}


+ (UIColor *)mainTableViewCellBackgroundColor {
    
    return [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.1];
}


// *************************************************************************************************
// # MARK:  Navigation bar


+ (UIColor *)navigationBarBackgroundColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)navigationBarMenuButtonColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
}


+ (UIColor *)navigationBarMenuButtonHighlightColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
}


+ (UIColor *)sidebarNavigationBarTitleColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
}


+ (UIColor *)navigationBarTitleColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
}


// *************************************************************************************************
// # MARK:  Table Cell Colors

+ (UIColor *)tableCellBackgroundSelectedColor {
    
    return [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00];
}


+ (UIColor *)tableCellBorderColor {
    
    return [UIColor colorWithRed:0.682 green:0.682 blue:0.682 alpha:1.00];
}


+ (UIColor *)tableCellTitleColor {
    
    return [UIColor colorWithRed:0.592 green:0.612 blue:0.631 alpha:1.00];
    
}


// *************************************************************************************************
// # MARK: label Colors


+ (UIColor *)dateTimeLabelTextColor {
    
    return [UIColor grayColor];
}


+ (UIColor *)domainLabelTextColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)statusLabelTextColor {
    
    return [[UIColor whiteColor] colorWithAlphaComponent:0.7];
}


+ (UIColor *)statusLabelBackgroundColor:(NSString *)status {
    
    return [status isEqualToString:@"Down"] ? [UIColor iBPMRedColor] : [UIColor iBPMGreenColor];
}


+ (UIColor *)loginButtonTitleColor {
    
    return [UIColor iBPMLogoBlueColor];
}


+ (UIColor *)domainTableViewCellTextColor {
    
    return [UIColor iBPMLogoBlueColor];
}

@end
