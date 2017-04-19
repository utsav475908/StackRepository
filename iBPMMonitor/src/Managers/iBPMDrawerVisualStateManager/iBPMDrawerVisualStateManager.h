// *************************************************************************************************
// # MARK: Imports


#import "MMDrawerVisualState.h"


// *************************************************************************************************
// # MARK: Type Definition


typedef NS_ENUM(NSInteger, MMDrawerAnimationType){
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlide,
    MMDrawerAnimationTypeSlideAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMDrawerVisualStateManager : NSObject


// *************************************************************************************************
// # MARK: Public Interfaces


@property (nonatomic,assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic,assign) MMDrawerAnimationType rightDrawerAnimationType;


// *************************************************************************************************
// # MARK: Class Methods


+ (iBPMDrawerVisualStateManager *)sharedManager;


// *************************************************************************************************
// # MARK: Public Interfaces


-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;


@end
