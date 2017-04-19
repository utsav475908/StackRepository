// *************************************************************************************************
// # MARK: Imports


#import "ContextMenuCell.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface ContextMenuCell ()


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation ContextMenuCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.masksToBounds = YES;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (UIView*)animatedIcon {
    
    return self.menuImageView;
}


- (UIView *)animatedContent {
    
    return self.menuTitleLabel;
}


@end
