// *************************************************************************************************
// # MARK: Imports

#import "NSString+Extensions.h"

#import "UIColor+Extensions.h"
#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation NSString (Extensions)


- (NSAttributedString *)getAttributedTextForNavigationBarTitle {    
    NSDictionary *navBarTitleDict
        = @{NSForegroundColorAttributeName:[iBPMColorUtils navigationBarTitleColor],
            NSFontAttributeName:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:18.0f]};
    
    NSMutableAttributedString *string
        = [[NSMutableAttributedString alloc] initWithString:self attributes: navBarTitleDict];

    return string;
}


@end
