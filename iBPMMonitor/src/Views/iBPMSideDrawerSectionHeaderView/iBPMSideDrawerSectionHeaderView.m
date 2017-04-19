// *************************************************************************************************
// # MARK: Imports


#import "iBPMSideDrawerSectionHeaderView.h"

#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMSideDrawerSectionHeaderView ()


@property (nonatomic, strong) UILabel *_label;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMSideDrawerSectionHeaderView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[iBPMColorUtils sideDrawerSectionHeaderColor]];
        self._label = [[UILabel alloc] initWithFrame:CGRectMake(15,
                                                                CGRectGetMaxY(self.bounds)-28,
                                                                CGRectGetWidth(self.bounds)-30,
                                                                22)];
        [self._label setBackgroundColor:[UIColor clearColor]];
        [self._label setTextColor:[iBPMColorUtils sidebarSectionHeaderTextColor]];
        [self._label setFont:[UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:12.0]];
        [self._label setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
        [self addSubview:self._label];
        [self setClipsToBounds:NO];        
    }
    
    return self;
}


-(void)setTitle:(NSString *)title {
    _title = title;
    [self._label setText:[self.title uppercaseString]];
}


-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * lineColor = [iBPMColorUtils sideDrawerSectionHeaderLineColor];
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    //start at this point
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds)-.5);
    //draw to this point
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds)-.5);
    CGContextStrokePath(context);
}


@end
