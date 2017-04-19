// *************************************************************************************************
// # MARK: Imports


#import "iBPMDomainViewController.h"

#import "iBPMAppModel.h"
#import "iBPMBarBackButtonItem.h"
#import "iBPMDataProviderManager.h"
#import "iBPMDomainModel.h"
#import "iBPMDomainTableViewCell.h"
#import "iBPMMainTableViewCell.h"
#import "iBPMMonitorViewController.h"
#import "iBPMNavigationController.h"
#import "iBPMSideDrawerSectionHeaderView.h"
#import "UIViewController+MMDrawerController.h"

#import "iBPMAppDetailTableViewCell.h"
// *************************************************************************************************
// # MARK: Constants


#define kButtonImageName @"BackButton.png"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMDomainViewController () <UITableViewDataSource, UITableViewDelegate>


// *************************************************************************************************
// # MARK: Private IBOutlets


@property (weak, nonatomic) IBOutlet UITableView *_tableView;


// *************************************************************************************************
// # MARK: Private Properties


@property (strong, nonatomic) NSArray *_headerTitles;
@property (strong, nonatomic) NSMutableSet *_expandedIndexPaths;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDomainViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMDomainViewController *)newViewController {
    iBPMDomainViewController *domainViewController
        = [[iBPMDomainViewController alloc] initWithNibName:@"iBPMDomainViewController"
                                                 bundle:nil];
    
    return domainViewController;
}


// *************************************************************************************************
// # MARK: View Controller Overrides

static NSString *kAppCellIdentifier = @"appTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([iBPMAppDetailTableViewCell class])
                                    bundle:nil];
    [self._tableView registerNib:cellNib
         forCellReuseIdentifier:kAppCellIdentifier];
    self._expandedIndexPaths = [NSMutableSet set];
    [self _setup];
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
    self._tableView.rowHeight = UITableViewAutomaticDimension;
    self._tableView.estimatedRowHeight = 50.f;
    [self _loadTableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:self.currentDomain.name];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self._expandedIndexPaths removeAllObjects];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Setter Methods


- (void)setCurrentDomain:(iBPMDomainModel *)currentDomain {
    _currentDomain = currentDomain;
    [self _loadTableView];
}


// *************************************************************************************************
// # MARK: Button Handlers


- (void)backButtonDidPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_loadTableView {
     self._headerTitles =
        [self.currentDomain.originalData.allKeys
            sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
     [self._tableView reloadData];
}


- (UITableViewCell *)_makeAppsTableCellForTableView:(UITableView *)tableView
                                              atIndexPath:(NSIndexPath *)indexPath{
    iBPMAppDetailTableViewCell *cell
        = (id)[tableView dequeueReusableCellWithIdentifier:kAppCellIdentifier];

    iBPMAppModel *appModel =self.currentDomain.appsArray[indexPath.row];
    cell.appNameLabel.text = appModel.name;
    cell.timeLabel.text = appModel.dateTime;
    cell.statusLabel.text = appModel.status;
    cell.proxyURL = appModel.proxyURL;
    cell.hosts = appModel.hosts;
    cell.withDetails = [self._expandedIndexPaths containsObject:indexPath];
    [cell setStatus:appModel.status];
    return cell;
}


- (UITableViewCell *)_makeTableCellForTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"domianTableViewCell";
    UITableViewCell *cell
        = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[iBPMDomainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    [cell.textLabel setFont:[UIFont iBPMApplicationTextThinFontWithSizeWithFontSize:18.0f]];
    
    return cell;
}


- (void)_setup {
    [self._tableView setBackgroundColor:[iBPMColorUtils mainTableViewBackgroundColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    iBPMBarBackButtonItem *backButton =
        [[iBPMBarBackButtonItem alloc] initWithImageName:kButtonImageName
                                                  target:self
                                                  action:@selector(backButtonDidPress:)];
    [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.currentDomain.originalData allKeys] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    NSString *headerTitle
        = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    if ([headerTitle isEqualToString:@"Hosts"]) {
        numberOfRows = self.currentDomain.hosts.count;
    } else if ([headerTitle isEqualToString:@"Apps"]) {
        numberOfRows = self.currentDomain.appsArray.count;
    } else {
        numberOfRows = 1;
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    NSString *sectionName
        = [tableView.dataSource tableView:tableView titleForHeaderInSection:indexPath.section];
    if ([sectionName isEqualToString:@"Apps"]) {
        cell = [self _makeAppsTableCellForTableView:tableView atIndexPath:indexPath];
    } else{
        cell = [self _makeTableCellForTableView:tableView];
        if ([sectionName isEqualToString:@"Hosts"]) {
            [cell.textLabel setText:[self.currentDomain.originalData[sectionName] objectAtIndex:indexPath.row]];
        } else {
            [cell.textLabel setText:self.currentDomain.originalData[sectionName] ];
        }
    }
    
    return cell;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self._headerTitles[section];
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
// # MARK: Table View Delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self._expandedIndexPaths containsObject:indexPath]) {
        iBPMAppDetailTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(animateClosed)]) {
            [cell animateClosed];
            [self._expandedIndexPaths removeObject:indexPath];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } else {
        [self._expandedIndexPaths addObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        iBPMAppDetailTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(animateOpen)]) {
            [cell animateOpen];

        }
    }
}


@end
