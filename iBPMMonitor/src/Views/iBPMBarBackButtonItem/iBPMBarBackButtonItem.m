// *************************************************************************************************
// # MARK: Imports


#import "iBPMBarBackButtonItem.h"

#import "iBPMBackButton.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMBarBackButtonItem ()


@property (nonatomic,strong)UIButton *button;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMBarBackButtonItem


- (instancetype)initWithTarget:(id)target action:(SEL)action {
    iBPMBackButton * buttonView = [[iBPMBackButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [buttonView addTarget:self action:@selector(touchUpInside:)
         forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:buttonView];
    if(self) {
        [self setButton:buttonView];
    }
    self.action = action;
    self.target = target;
    return self;
}


- (instancetype)initWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:imageName]
                       forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 26, 26);
    self = [self initWithCustomView:backBtn] ;
    self.action = action;
    self.target = target;
    
    return self;
}


- (void)touchUpInside:(id)sender{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.action withObject:sender];
#pragma clang diagnostic pop;
    
}


@end
