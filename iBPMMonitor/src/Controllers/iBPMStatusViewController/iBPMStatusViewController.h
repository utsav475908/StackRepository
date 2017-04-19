// *************************************************************************************************
// # MARK: Imports


#import "iBPMMainViewController.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMStatusViewController : iBPMMainViewController


@property BOOL notificationFlag;


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMStatusViewController *)newViewController;
- (void)clearTableView;
//+ (void)setNotificationFlag:(BOOL)status;


@end
