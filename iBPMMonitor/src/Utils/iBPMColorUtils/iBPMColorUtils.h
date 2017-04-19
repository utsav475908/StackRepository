// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMColorUtils : NSObject


// *************************************************************************************************
// # MARK:  Sidebar Colors


+ (UIColor *)sidebarNavigationBarColor;
+ (UIColor *)sidebarNavigationBarTitleColor;
+ (UIColor *)sidebarTableViewBackgroundColor;
+ (UIColor *)sidebarViewBackgroundColor;
+ (UIColor *)sideDrawerSectionHeaderColor;
+ (UIColor *)sideDrawerSectionHeaderLineColor;
+ (UIColor *)sidebarTableViewCellBackgroundColor;
+ (UIColor *)sidebarTableViewCellTextColor;
+ (UIColor *)sidebarSectionHeaderTextColor;


// *************************************************************************************************
// # MARK: Navigation Bar Colors


+ (UIColor *)navigationBarBackgroundColor;
+ (UIColor *)navigationBarMenuButtonColor;
+ (UIColor *)navigationBarMenuButtonHighlightColor;
+ (UIColor *)navigationBarTitleColor ;


// *************************************************************************************************
// # MARK: Table Cell Colors


+ (UIColor *)tableCellBackgroundSelectedColor;
+ (UIColor *)tableCellBorderColor;
+ (UIColor *)tableCellTitleColor;


// *************************************************************************************************
// # MARK: Font Colors


+ (UIColor *)loginButtonTitleColor;


// *************************************************************************************************
// # MARK: Label Colors


+ (UIColor *)dateTimeLabelTextColor;
+ (UIColor *)domainLabelTextColor;
+ (UIColor *)domainTableViewCellTextColor;
+ (UIColor *)statusLabelTextColor;
+ (UIColor *)statusLabelBackgroundColor:(NSString *)status;

// *************************************************************************************************
// # MARK:  Main Table View Colors


+ (UIColor *)mainTableViewBackgroundColor;
+ (UIColor *)mainTableViewCellBackgroundColor;


@end
