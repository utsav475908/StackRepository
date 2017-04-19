// *************************************************************************************************
// # MARK: Imports


#import "iBPMDrawerBarButtonItem.h"

#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Private Interfaces - iBPMDrawerMenuButton


@interface iBPMDrawerMenuButton : UIButton


// *************************************************************************************************
// # MARK: Private Properties


@property (nonatomic,strong) UIColor * menuButtonNormalColor;
@property (nonatomic,strong) UIColor * menuButtonHighlightedColor;
@property (nonatomic,strong) UIColor * shadowNormalColor;
@property (nonatomic,strong) UIColor * shadowHighlightedColor;


// *************************************************************************************************
// # MARK: Private Interfaces


-(UIColor *)menuButtonColorForState:(UIControlState)state;
-(void)setMenuButtonColor:(UIColor *)color forState:(UIControlState)state;
-(UIColor *)shadowColorForState:(UIControlState)state;
-(void)setShadowColor:(UIColor *)color forState:(UIControlState)state;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDrawerMenuButton


// *************************************************************************************************
// # MARK: Init


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        [self setMenuButtonNormalColor:[iBPMColorUtils navigationBarMenuButtonColor]];
        [self setMenuButtonHighlightedColor:[iBPMColorUtils navigationBarMenuButtonHighlightColor]];
        [self setShadowNormalColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
        [self setShadowHighlightedColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    }
    
    return self;
}


// *************************************************************************************************
// # MARK: Private Interfaces


- (UIColor *)menuButtonColorForState:(UIControlState)state {
    UIColor * color = nil;
    
    switch (state) {
        case UIControlStateNormal:
            color = self.menuButtonNormalColor;
            break;
        case UIControlStateHighlighted:
            color = self.menuButtonHighlightedColor;
            break;
        default:
            break;
    }
    
    return color;
}


- (void)setMenuButtonColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            [self setMenuButtonNormalColor:color];
            break;
        case UIControlStateHighlighted:
            [self setMenuButtonHighlightedColor:color];
            break;
        default:
            break;
    }
    [self setNeedsDisplay];
}


- (UIColor *)shadowColorForState:(UIControlState)state {
    UIColor * color;
    switch (state) {
        case UIControlStateNormal:
            color = self.shadowNormalColor;
            break;
        case UIControlStateHighlighted:
            color = self.shadowHighlightedColor;
            break;
        default:
            break;
    }
    return color;
}


- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            [self setShadowNormalColor:color];
            break;
        case UIControlStateHighlighted:
            [self setShadowHighlightedColor:color];
            break;
        default:
            break;
    }
    [self setNeedsDisplay];
}


// *************************************************************************************************
// # MARK: Overrides


-(void)drawRect:(CGRect)rect{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Sizes
    CGFloat buttonWidth = CGRectGetWidth(self.bounds)*.80;
    CGFloat buttonHeight = CGRectGetHeight(self.bounds)*.08;
    CGFloat xOffset = CGRectGetWidth(self.bounds)*.10;
    CGFloat yOffset = CGRectGetHeight(self.bounds)*.16;
    CGFloat cornerRadius = 1.0;
    
    //// Color Declarations
    UIColor*  buttonColor = [self menuButtonColorForState:self.state];
    
    //// Top Bun Drawing
    UIBezierPath* topBunPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xOffset, yOffset, buttonWidth, buttonHeight) cornerRadius:cornerRadius];
    CGContextSaveGState(context);
    [buttonColor setFill];
    [topBunPath fill];
    CGContextRestoreGState(context);
    
    //// Middle Drawing
    UIBezierPath* meatPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xOffset, yOffset*2 + buttonHeight, buttonWidth, buttonHeight) cornerRadius:cornerRadius];
    CGContextSaveGState(context);
    [buttonColor setFill];
    [meatPath fill];
    CGContextRestoreGState(context);
    
    //// Bottom Bun Drawing
    UIBezierPath* bottomBunPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xOffset, yOffset*3 + buttonHeight*2, buttonWidth, buttonHeight) cornerRadius:cornerRadius];
    CGContextSaveGState(context);
    [buttonColor setFill];
    [bottomBunPath fill];
    CGContextRestoreGState(context);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self setNeedsDisplay];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    [self setNeedsDisplay];
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
}


// *************************************************************************************************
// # MARK: Setter Methods


-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsDisplay];
}


-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}


-(void)setTintColor:(UIColor *)tintColor{
    if([super respondsToSelector:@selector(setTintColor:)]){
        [super setTintColor:tintColor];
    }
}


-(void)tintColorDidChange{
     [self setNeedsDisplay];
}


@end


// *************************************************************************************************
// # MARK: Private Interfaces - iBPMPlusButton


@interface iBPMPlusButton : iBPMDrawerMenuButton


@end


// *************************************************************************************************
// # MARK: Implementation - iBPMPlusButton


@implementation iBPMPlusButton


-(void)drawRect:(CGRect)rect{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Three dots for the menu
    CGFloat xOffset = CGRectGetWidth(self.bounds)*.10;
    CGFloat yOffset = CGRectGetHeight(self.bounds)*.16;
    
    UIColor *dotColor = [UIColor whiteColor];
    
    [dotColor setFill];
    CGContextAddEllipseInRect(context, CGRectMake(xOffset, yOffset+2, 3.0, 3.0));
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);

    [dotColor setFill];
    CGContextAddEllipseInRect(context, CGRectMake(xOffset+5, yOffset+2, 3.0, 3.0));
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);

    [dotColor setFill];
    CGContextAddEllipseInRect(context, CGRectMake(xOffset+10, yOffset+2, 3.0, 3.0));
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
}


@end


// *************************************************************************************************
// # MARK: Private Interfaces - MMDrawerBarButtonItem


@interface iBPMDrawerBarButtonItem ()


@property (nonatomic,strong) iBPMDrawerMenuButton * buttonView;


@end


// *************************************************************************************************
// # MARK: Implementation - MMDrawerBarButtonItem


@implementation iBPMDrawerBarButtonItem


// *************************************************************************************************
// # MARK: Init


-(instancetype)initWithTarget:(id)target
                       action:(SEL)action
                        style:(iBPMNavigationBarItemStyle)style {
    iBPMDrawerMenuButton * buttonView = nil;
    if (style == iBPMNavigationBarItemStyleMenu) {
        buttonView
            = [[iBPMDrawerMenuButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    } else if (style == iBPMNavigationBarItemStylePlus) {
        buttonView
            = [[iBPMPlusButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    }
    [buttonView addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:buttonView];
    if(self){
        [self setButtonView:buttonView];
    }
    self.action = action;
    self.target = target;
    
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    // non-ideal way to get the target/action, but it works
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCoder: aDecoder];
    
    return [self initWithTarget:barButtonItem.target
                         action:barButtonItem.action
                          style:iBPMNavigationBarItemStyleMenu];
}


// *************************************************************************************************
// # MARK: Button Handlers


-(void)touchUpInside:(id)sender {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"    
    [self.target performSelector:self.action withObject:sender];
#pragma clang diagnostic pop;
    
}


// *************************************************************************************************
// # MARK: Public Methods


- (UIColor *)menuButtonColorForState:(UIControlState)state {
    
    return [self.buttonView menuButtonColorForState:state];
}


- (void)setMenuButtonColor:(UIColor *)color forState:(UIControlState)state {
    [self.buttonView setMenuButtonColor:color forState:state];
}


-(UIColor *)shadowColorForState:(UIControlState)state {
    
    return [self.buttonView shadowColorForState:state];
}


- (void)setShadowColor:(UIColor *)color forState:(UIControlState)state {
    [self.buttonView setShadowColor:color forState:state];
}


- (void)setTintColor:(UIColor *)tintColor{
    if([super respondsToSelector:@selector(setTintColor:)]) {
        [super setTintColor:tintColor];
    }
    if([self.buttonView respondsToSelector:@selector(setTintColor:)]){
        [self.buttonView setTintColor:tintColor];
    }
}


@end
