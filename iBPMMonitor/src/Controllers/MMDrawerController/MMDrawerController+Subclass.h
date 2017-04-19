// *************************************************************************************************
// # MARK: Imports


#import "MMDrawerController.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface MMDrawerController (Subclass)


- (void)tapGestureCallback:(UITapGestureRecognizer *)tapGesture __attribute((objc_requires_super));
- (void)panGestureCallback:(UIPanGestureRecognizer *)panGesture __attribute((objc_requires_super));
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch __attribute((objc_requires_super));
- (void)prepareToPresentDrawer:(MMDrawerSide)drawer
                      animated:(BOOL)animated __attribute((objc_requires_super));
- (void)closeDrawerAnimated:(BOOL)animated
                   velocity:(CGFloat)velocity
           animationOptions:(UIViewAnimationOptions)options
                 completion:(void (^)(BOOL))completion __attribute((objc_requires_super));
- (void)openDrawerSide:(MMDrawerSide)drawerSide
              animated:(BOOL)animated
              velocity:(CGFloat)velocity
      animationOptions:(UIViewAnimationOptions)options
            completion:(void (^)(BOOL))completion __attribute((objc_requires_super));
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration __attribute((objc_requires_super));
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration __attribute((objc_requires_super));


@end
