// *************************************************************************************************
// # MARK: Imports


#import "YALContextMenuCell.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface ContextMenuCell : UITableViewCell <YALContextMenuCell>


@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;


@end
