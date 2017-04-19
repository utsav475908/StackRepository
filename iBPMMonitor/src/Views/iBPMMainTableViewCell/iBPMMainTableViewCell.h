// *************************************************************************************************
// # MARK: Imports


#import "iBPMTableViewCell.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMMainTableViewCell : iBPMTableViewCell


// *************************************************************************************************
// # MARK: Public Properties


@property (weak, nonatomic) IBOutlet UILabel *DomainLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


// *************************************************************************************************
// # MARK: Public Interfaces


- (void)setStatus:(NSString *)status;


@end
