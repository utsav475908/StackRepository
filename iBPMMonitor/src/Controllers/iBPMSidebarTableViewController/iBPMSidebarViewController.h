// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMSidebarViewController : UIViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMSidebarViewController *)newViewController;


// *************************************************************************************************
// # MARK: Public Properties


@property (strong, nonatomic) NSArray *lifeCycles;


@end
