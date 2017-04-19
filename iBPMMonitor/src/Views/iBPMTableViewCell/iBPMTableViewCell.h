// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMTableViewCell: UITableViewCell


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic, strong) UIColor * accessoryCheckmarkColor;
@property (nonatomic, strong) UIColor * disclosureIndicatorColor;


// *************************************************************************************************
// # MARK: Public Methods


-(void)updateContentForNewContentSize;


@end
