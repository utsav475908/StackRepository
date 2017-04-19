// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMBarBackButtonItem : UIBarButtonItem


- (instancetype)initWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
- (instancetype)initWithTarget:(id)target action:(SEL)action;


@end
