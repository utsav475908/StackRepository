// *************************************************************************************************
// # MARK: Imports


#import <UIKit/UIKit.h>


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMHistoryViewController : UIViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMHistoryViewController *)newViewController;


// *************************************************************************************************
// # MARK: Public Properties

@property (strong, nonatomic) NSArray *historyArray;
@property (strong, nonatomic) NSString *domainName;

@end
