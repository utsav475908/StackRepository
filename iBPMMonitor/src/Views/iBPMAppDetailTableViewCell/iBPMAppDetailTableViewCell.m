// *************************************************************************************************
// # MARK: Imports


#import "iBPMAppDetailTableViewCell.h"

#import "iBPMAppModel.h"
#import "iBPMMainTableViewCell.h"
#import "iBPMSideDrawerTableViewCell.h"
#import "iBPMSideDrawerSectionHeaderView.h"
#import "UIView+Fold.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMAppDetailTableViewCell () <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailContainerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;


@end



// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMAppDetailTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.withDetails = NO;
    self.detailContainerViewHeightConstraint.constant = 0;

    [self _setup];
}

// *************************************************************************************************
// # MARK: Setters


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setWithDetails:(BOOL)withDetails {
    _withDetails = withDetails;
    
    if (withDetails) {
        self.detailContainerViewHeightConstraint.priority = 250;
    } else {
        self.detailContainerViewHeightConstraint.priority = 999;
    }
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)animateOpen {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.detailContainerView foldOpenWithTransparency:YES
                                   withCompletionBlock:^{
        self.contentView.backgroundColor = originalBackgroundColor;
    }];
}


- (void)animateClosed {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.detailContainerView foldClosedWithTransparency:YES withCompletionBlock:^{
        self.contentView.backgroundColor = originalBackgroundColor;
    }];
}


- (void)setStatus:(NSString *)status {
    self.statusLabel.text = status;
    UIColor *statusColor = [iBPMColorUtils statusLabelBackgroundColor:status];
    [self.statusLabel setBackgroundColor:statusColor];
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.hosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AppDetailTableCell";
    
    UITableViewCell *cell
        = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[iBPMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    if (indexPath.row < self.hosts.count) {
        [cell.textLabel setText:[self.hosts[indexPath.row] uppercaseString]];
    }
    return cell;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Hosts";
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    iBPMSideDrawerSectionHeaderView * headerView;
    headerView = [[iBPMSideDrawerSectionHeaderView alloc]
                  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 56.0)];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [headerView setTitle:[tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
    
    return headerView;
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_setup {
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.detailContainerView.layer.backgroundColor
        = [[UIColor iBPMLogoBlueColor] colorWithAlphaComponent:0.3].CGColor;
    self.titleContainer.layer.backgroundColor
        = [iBPMColorUtils mainTableViewCellBackgroundColor].CGColor;
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
    [self._tableView setBackgroundColor:[iBPMColorUtils mainTableViewCellBackgroundColor]];
    [self.statusLabel setAutoresizingMask:
        UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
    [self.appNameLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:23.f]];
    [self.appNameLabel setTextColor:[iBPMColorUtils domainLabelTextColor]];
    [self.timeLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:12.f]];
    [self.timeLabel setTextColor:[iBPMColorUtils dateTimeLabelTextColor]];
    [self.statusLabel setTextColor:[iBPMColorUtils statusLabelTextColor]];
    [self.statusLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:14.f]];
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.layer.cornerRadius = 6.0;
}


@end
