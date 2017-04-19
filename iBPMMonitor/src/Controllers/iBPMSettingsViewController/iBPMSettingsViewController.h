
// *************************************************************************************************
// # MARK: Protocol


@protocol iBPMSettingsViewControllerDelegate <NSObject>


@optional


- (void)logOutButtonDidPress;


@end


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMSettingsViewController : UIViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMSettingsViewController *)newViewController;


// *************************************************************************************************
// # MARK: MINAddRuleViewDelegate Property


@property (nonatomic, weak, readwrite) id <iBPMSettingsViewControllerDelegate> delegate;


@end
