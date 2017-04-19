// *************************************************************************************************
// # MARK: Imports


#import "UITextField+Extension.h"

#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation UITextField (Extensions)


- (void)addBottomLine {
    self.borderStyle = UITextBorderStyleNone;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [iBPMColorUtils loginButtonTitleColor].CGColor;
    border.frame = CGRectMake(0,
                              self.frame.size.height - borderWidth,
                              self.frame.size.width,
                              self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    
}


@end
