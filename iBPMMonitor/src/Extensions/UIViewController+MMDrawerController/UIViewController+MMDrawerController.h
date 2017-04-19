// *************************************************************************************************
// # MARK: Imports


#import "MMDrawerController.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface UIViewController (MMDrawerController)


@property(nonatomic, strong, readonly) MMDrawerController *mm_drawerController;
@property(nonatomic, assign, readonly) CGRect mm_visibleDrawerFrame;


@end
