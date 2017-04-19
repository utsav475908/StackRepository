// *************************************************************************************************
// # MARK: Forward Decalariton


@class  MMDrawerController;


// *************************************************************************************************
// # MARK: Constants


typedef NS_ENUM(NSInteger, MMDrawerSide){
    MMDrawerSideNone = 0,
    MMDrawerSideLeft,
    MMDrawerSideRight,
};


typedef NS_OPTIONS(NSInteger, MMOpenDrawerGestureMode) {
    MMOpenDrawerGestureModeNone                     = 0,
    MMOpenDrawerGestureModePanningNavigationBar     = 1 << 1,
    MMOpenDrawerGestureModePanningCenterView        = 1 << 2,
    MMOpenDrawerGestureModeBezelPanningCenterView   = 1 << 3,
    MMOpenDrawerGestureModeCustom                   = 1 << 4,
    MMOpenDrawerGestureModeAll                      =   MMOpenDrawerGestureModePanningNavigationBar     |
                                                        MMOpenDrawerGestureModePanningCenterView        |
                                                        MMOpenDrawerGestureModeBezelPanningCenterView   |
                                                        MMOpenDrawerGestureModeCustom,
};


typedef NS_OPTIONS(NSInteger, MMCloseDrawerGestureMode) {
    MMCloseDrawerGestureModeNone                    = 0,
    MMCloseDrawerGestureModePanningNavigationBar    = 1 << 1,
    MMCloseDrawerGestureModePanningCenterView       = 1 << 2,
    MMCloseDrawerGestureModeBezelPanningCenterView  = 1 << 3,
    MMCloseDrawerGestureModeTapNavigationBar        = 1 << 4,
    MMCloseDrawerGestureModeTapCenterView           = 1 << 5,
    MMCloseDrawerGestureModePanningDrawerView       = 1 << 6,
    MMCloseDrawerGestureModeCustom                  = 1 << 7,
    MMCloseDrawerGestureModeAll                     =   MMCloseDrawerGestureModePanningNavigationBar    |
                                                        MMCloseDrawerGestureModePanningCenterView       |
                                                        MMCloseDrawerGestureModeBezelPanningCenterView  |
                                                        MMCloseDrawerGestureModeTapNavigationBar        |
                                                        MMCloseDrawerGestureModeTapCenterView           |
                                                        MMCloseDrawerGestureModePanningDrawerView       |
                                                        MMCloseDrawerGestureModeCustom,
};


typedef NS_ENUM(NSInteger, MMDrawerOpenCenterInteractionMode) {
    MMDrawerOpenCenterInteractionModeNone,
    MMDrawerOpenCenterInteractionModeFull,
    MMDrawerOpenCenterInteractionModeNavigationBarOnly,
};


// *************************************************************************************************
// # MARK: Block Definition


typedef void(^MMDrawerControllerDrawerVisualStateBlock)
    (MMDrawerController * drawerController, MMDrawerSide drawerSide, CGFloat percentVisible);


// *************************************************************************************************
// # MARK: Public Interfaces


@interface MMDrawerController : UIViewController


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic, strong) UIViewController * centerViewController;
@property (nonatomic, strong) UIViewController * leftDrawerViewController;
@property (nonatomic, strong) UIViewController * rightDrawerViewController;
@property (nonatomic, assign) CGFloat maximumLeftDrawerWidth;
@property (nonatomic, assign) CGFloat maximumRightDrawerWidth;
@property (nonatomic, assign, readonly) CGFloat visibleLeftDrawerWidth;
@property (nonatomic, assign, readonly) CGFloat visibleRightDrawerWidth;
@property (nonatomic, assign) CGFloat animationVelocity;
@property (nonatomic, assign) BOOL shouldStretchDrawer;
@property (nonatomic, assign, readonly) MMDrawerSide openSide;
@property (nonatomic, assign) MMOpenDrawerGestureMode openDrawerGestureModeMask;
@property (nonatomic, assign) MMCloseDrawerGestureMode closeDrawerGestureModeMask;
@property (nonatomic, assign) MMDrawerOpenCenterInteractionMode centerHiddenInteractionMode;
@property (nonatomic, assign) BOOL showsShadow;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor * shadowColor;
@property (nonatomic, assign) BOOL showsStatusBarBackgroundView;
@property (nonatomic, strong) UIColor * statusBarViewBackgroundColor;
@property (nonatomic, assign) CGFloat bezelPanningCenterViewRange;
@property (nonatomic, assign) CGFloat panVelocityXAnimationThreshold;


// *************************************************************************************************
// # MARK: Init


-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController
                   leftDrawerViewController:(UIViewController *)leftDrawerViewController
                  rightDrawerViewController:(UIViewController *)rightDrawerViewController;
-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController
                   leftDrawerViewController:(UIViewController *)leftDrawerViewController;
-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController
                  rightDrawerViewController:(UIViewController *)rightDrawerViewController;


// *************************************************************************************************
// # MARK: Public Interfaces


-(void)toggleDrawerSide:(MMDrawerSide)drawerSide
               animated:(BOOL)animated
             completion:(void(^)(BOOL finished))completion;
-(void)closeDrawerAnimated:(BOOL)animated completion:(void(^)(BOOL finished))completion;
-(void)openDrawerSide:(MMDrawerSide)drawerSide
             animated:(BOOL)animated
           completion:(void(^)(BOOL finished))completion;
-(void)setCenterViewController:(UIViewController *)centerViewController
            withCloseAnimation:(BOOL)closeAnimated
                    completion:(void(^)(BOOL finished))completion;
-(void)setCenterViewController:(UIViewController *)newCenterViewController
        withFullCloseAnimation:(BOOL)fullCloseAnimated
                    completion:(void(^)(BOOL finished))completion;
-(void)setMaximumLeftDrawerWidth:(CGFloat)width animated:(BOOL)animated
                      completion:(void(^)(BOOL finished))completion;
-(void)setMaximumRightDrawerWidth:(CGFloat)width animated:(BOOL)animated
                       completion:(void(^)(BOOL finished))completion;
-(void)bouncePreviewForDrawerSide:(MMDrawerSide)drawerSide
                       completion:(void(^)(BOOL finished))completion;
-(void)bouncePreviewForDrawerSide:(MMDrawerSide)drawerSide
                         distance:(CGFloat)distance completion:(void(^)(BOOL finished))completion;
-(void)setDrawerVisualStateBlock:(void(^)(MMDrawerController * drawerController,
                                          MMDrawerSide drawerSide,
                                          CGFloat percentVisible))drawerVisualStateBlock;

-(void)setGestureCompletionBlock:(void(^)(MMDrawerController * drawerController,
                                          UIGestureRecognizer * gesture))gestureCompletionBlock;
-(void)setGestureShouldRecognizeTouchBlock:(BOOL(^)(MMDrawerController * drawerController,
                                                    UIGestureRecognizer * gesture,
                                                    UITouch * touch))gestureShouldRecognizeTouchBlock;


@end
