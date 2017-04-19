// *************************************************************************************************
// # MARK: Imports


#import "iBPMSideDrawerTableViewCell.h"

#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMSideDrawerTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setAccessoryCheckmarkColor:[UIColor whiteColor]];
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView
            setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [backgroundView setBackgroundColor:[iBPMColorUtils sidebarTableViewCellBackgroundColor]];
        [self setBackgroundView:backgroundView];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setTextColor:[iBPMColorUtils sidebarTableViewCellTextColor]];
        [self.textLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:15.0f]];
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
