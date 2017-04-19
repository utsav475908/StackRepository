// *************************************************************************************************
// # MARK: Imports


#import "iBPMMainTableViewCell.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMMainTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self _commonInit];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self _commonInit];
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


- (void)_commonInit {
    [self setAccessoryCheckmarkColor:[UIColor whiteColor]];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setAutoresizingMask:
        UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [backgroundView setBackgroundColor:[iBPMColorUtils mainTableViewCellBackgroundColor]];
    [self setBackgroundView:backgroundView];
    [self.statusLabel setAutoresizingMask:
        UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
    [self.DomainLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:23.f]];
    [self.DomainLabel setTextColor:[iBPMColorUtils domainLabelTextColor]];
    [self.timeLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:12.f]];
    [self.timeLabel setTextColor:[iBPMColorUtils dateTimeLabelTextColor]];
    [self.statusLabel setTextColor:[iBPMColorUtils statusLabelTextColor]];
    [self.statusLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:14.f]];
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.layer.cornerRadius = 6.0;
}


- (void)setStatus:(NSString *)status {
    self.statusLabel.text = status;
    UIColor *statusColor = [iBPMColorUtils statusLabelBackgroundColor:status];
    [self.statusLabel setBackgroundColor:statusColor];
    [self setDisclosureIndicatorColor:statusColor];
}


@end
