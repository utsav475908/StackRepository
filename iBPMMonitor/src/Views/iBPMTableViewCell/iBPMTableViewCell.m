// *************************************************************************************************
// # MARK: Imports


#import "iBPMTableViewCell.h"

#import "iBPMDisclosureIndicator.h"
#import "iBPMCustomCheckmark.h"


// *************************************************************************************************
// # MARK: Implementation - MMTableViewCell


@implementation iBPMTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryCheckmarkColor:[UIColor whiteColor]];
        [self setDisclosureIndicatorColor:[UIColor whiteColor]];
        [self updateContentForNewContentSize];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    [super setAccessoryType:accessoryType];
    
    if(accessoryType == UITableViewCellAccessoryCheckmark) {
        iBPMCustomCheckmark * customCheckmark
            = [[iBPMCustomCheckmark alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        [customCheckmark setColor:self.accessoryCheckmarkColor];
        [self setAccessoryView:customCheckmark];
    } else if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        iBPMDisclosureIndicator * di
            = [[iBPMDisclosureIndicator alloc] initWithFrame:CGRectMake(0, 0, 10, 14)];
        [di setColor:self.disclosureIndicatorColor];
        [self setAccessoryView:di];
    } else {
        [self setAccessoryView:nil];
    }
}


-(void)prepareForReuse {
    [super prepareForReuse];
    [self updateContentForNewContentSize];
}


-(void)updateContentForNewContentSize {
    
}


@end
