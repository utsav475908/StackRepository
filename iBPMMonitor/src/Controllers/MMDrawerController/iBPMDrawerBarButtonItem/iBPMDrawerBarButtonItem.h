// *************************************************************************************************
// # MARK: Public Interfaces


typedef NS_ENUM(NSUInteger, iBPMNavigationBarItemStyle) {
    iBPMNavigationBarItemStyleMenu = 0,
    iBPMNavigationBarItemStylePlus = 1
};


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMDrawerBarButtonItem : UIBarButtonItem


// *************************************************************************************************
// # MARK: Init


-(instancetype)initWithTarget:(id)target action:(SEL)action style:(iBPMNavigationBarItemStyle)style;


// *************************************************************************************************
// # MARK: Public Methods


- (UIColor *)menuButtonColorForState:(UIControlState)state
    __attribute__((deprecated("Use tintColor instead")));
- (void)setMenuButtonColor:(UIColor *)color forState:(UIControlState)state
    __attribute__((deprecated("Use tintColor instead")));
- (UIColor *)shadowColorForState:(UIControlState)state
    __attribute__((deprecated("Shadow is no longer supported")));
- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state
    __attribute__((deprecated("Shadow is no longer supported")));


@end
