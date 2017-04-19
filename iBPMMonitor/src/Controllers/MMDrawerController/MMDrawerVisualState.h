// *************************************************************************************************
// # MARK: Imports


#import "MMDrawerController.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface MMDrawerVisualState : NSObject


// *************************************************************************************************
// # MARK: Class Methods


+ (MMDrawerControllerDrawerVisualStateBlock)slideAndScaleVisualStateBlock;
+ (MMDrawerControllerDrawerVisualStateBlock)slideVisualStateBlock;
+ (MMDrawerControllerDrawerVisualStateBlock)swingingDoorVisualStateBlock;
+ (MMDrawerControllerDrawerVisualStateBlock)parallaxVisualStateBlockWithParallaxFactor:(CGFloat)parallaxFactor;


@end
