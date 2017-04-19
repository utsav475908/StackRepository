// *************************************************************************************************
// # MARK: Imports


#import "iBPMMonitorViewController.h"

#import "iBPMDataProviderManager.h"
#import "iBPMDomainModel.h"
#import "iBPMDomainViewController.h"
#import "iBPMMainTableViewCell.h"
#import "iBPMNavigationController.h"
#import "iBPMSideDrawerTableViewCell.h"
#import "iBPMDrawerBarButtonItem.h"
#import "NSString+Extensions.h"
#import "UIColor+Extensions.h"
#import "UIViewController+MMDrawerController.h"


// *************************************************************************************************
// # MARK: Constants


#define kMonitorViewControllerNibName @"iBPMMonitorViewController"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMMonitorViewController () <UITableViewDataSource, UITableViewDelegate>


// *************************************************************************************************
// # MARK: IBOutlets


@property (weak, nonatomic) IBOutlet UITableView *_tableView;


// *************************************************************************************************
// # MARK: Private Properties


@property (strong, nonatomic) NSDictionary *_domains;
@property (strong, nonatomic) NSArray *_domainNames;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMMonitorViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMMonitorViewController *)newViewController {
    iBPMMonitorViewController *viewController
        = [[iBPMMonitorViewController alloc] initWithNibName:kMonitorViewControllerNibName
                                               bundle:nil];
    
    return viewController;
}


// *************************************************************************************************
// # MARK: View Controller Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self._tableView setBackgroundColor:[iBPMColorUtils mainTableViewBackgroundColor]];
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
    [self _loadTableViewData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_loadTableViewData {
    NSString *lifeCycle = [iBPMStateManager sharedManager].currentLifeCycle;
    [MBProgressHUD showWaitIndicator:self.view];
    [[iBPMDataProviderManager dataProvider]
        getDomainsIn:lifeCycle
             success:^(id results) {
                 self._domains = results[lifeCycle];
                 self._domainNames
                    = [self._domains.allKeys
                       sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                 [self._tableView reloadData];
                 [MBProgressHUD hideWaitIndicator:self.view];
             } failure:^(NSArray *errors) {
                 [MBProgressHUD hideWaitIndicator:self.view];
    }];
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self._domainNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"mianViewTableCell";
    iBPMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"iBPMMainTableViewCell" bundle:nil]
        forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    NSString *domainName = self._domainNames[indexPath.row];
    iBPMDomainModel *domain = self._domains[domainName];
    cell.DomainLabel.text = domainName;
    cell.timeLabel.text = domain.dateTime;
    [cell setStatus:domain.status];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.frame = CGRectMake(-CGRectGetWidth(cell.bounds)/2,
                            cell.frame.origin.y,
                            CGRectGetWidth(cell.bounds),
                            CGRectGetHeight(cell.bounds));
    cell.alpha = 0.f;
    [UIView animateWithDuration:0.25f
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         cell.alpha = 1.f;
                         cell.frame = CGRectMake(0.f,
                                                 cell.frame.origin.y,
                                                 CGRectGetWidth(cell.bounds),
                                                 CGRectGetHeight(cell.bounds));
                     }
                     completion:nil];
}


// *************************************************************************************************
// # MARK: Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iBPMDomainViewController *domainViewController = [iBPMDomainViewController newViewController];
    domainViewController.currentDomain = self._domains[self._domainNames[indexPath.row]];
    [self.navigationController pushViewController:domainViewController animated:YES];
    [tableView selectRowAtIndexPath:indexPath
                           animated:NO
                     scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0;
}


@end
