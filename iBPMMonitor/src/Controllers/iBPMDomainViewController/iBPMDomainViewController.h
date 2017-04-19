// *************************************************************************************************
// # MARK: Forward Decalarition


@class iBPMDomainModel;


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMDomainViewController : UIViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMDomainViewController *)newViewController;


// *************************************************************************************************
// # MARK: Public Properties


@property (strong, nonatomic) iBPMDomainModel *currentDomain;


@end
