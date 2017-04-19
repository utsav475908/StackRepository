// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMAppDetailTableViewCell : UITableViewCell


// *************************************************************************************************
// # MARK: IBOutlets


@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIView *detailContainerView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) NSString *proxyURL;
@property (strong, nonatomic) NSArray *hosts;


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic, assign) BOOL withDetails;


// *************************************************************************************************
// # MARK: Public Interfaces


- (void)animateOpen;
- (void)animateClosed;
- (void)setStatus:(NSString *)status;


@end
