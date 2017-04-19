// *************************************************************************************************
// # MARK: Imports


#import "iBPMDomainTableViewCell.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDomainTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setAccessoryCheckmarkColor:[UIColor whiteColor]];
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView
         setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [backgroundView setBackgroundColor:[iBPMColorUtils mainTableViewCellBackgroundColor]];
        [self setBackgroundView:backgroundView];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setTextColor:[iBPMColorUtils domainTableViewCellTextColor]];
        [self.textLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:18.0f]];
    }
    
    return self;
}


-(void)updateContentForNewContentSize{
    if([[UIFont class] respondsToSelector:@selector(preferredFontForTextStyle:)]) {
        [self.textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    } else {
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    }
}


@end
