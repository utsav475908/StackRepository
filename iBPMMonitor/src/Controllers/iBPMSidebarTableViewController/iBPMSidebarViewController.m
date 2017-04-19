// *************************************************************************************************
// # MARK: Imports


#import "iBPMSidebarViewController.h"

#import "ContextMenuCell.h"
#import "iBPMDataProviderManager.h"
#import "iBPMDrawerBarButtonItem.h"
#import "iBPMMainViewController.h"
#import "iBPMMonitorViewController.h"
#import "iBPMNavigationController.h"
#import "iBPMSettingsViewController.h"
#import "iBPMSideDrawerTableViewCell.h"
#import "iBPMSideDrawerSectionHeaderView.h"
#import "iBPMStatusViewController.h"
#import "UIAlertController+Extension.h"
#import "UIImage+Extension.h"
#import "UIViewController+MMDrawerController.h"
#import "YALContextMenuTableView.h"


// *************************************************************************************************
// # MARK: Constants


static NSString *const kMenuCellIdentifier = @"rotationCell";
#define kSideBarViewControllerNibName @"iBPMSidebarViewController"
#define kLifeCycleSectionHeaderTitle NSLocalizedString(@"Life Cycle", nil)

#define kCloseButtonTitle NSLocalizedString(@"Close", nil)
#define kiBPMMonitorButtonTitle NSLocalizedString(@"iBPM Monitor", nil)
#define kiBPMStatusButtonTitle NSLocalizedString(@"iBPM Status", nil)
#define kSettingsButtonTitle NSLocalizedString(@"Settings", nil)


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMSidebarViewController () <iBPMSettingsViewControllerDelegate,
                                         UITableViewDataSource,
                                         UITableViewDelegate,
                                         YALContextMenuTableViewDelegate>


// *************************************************************************************************
// # MARK: IBOutlets


@property (weak, nonatomic) IBOutlet UITableView *_tableView;


// *************************************************************************************************
// # MARK: Private Properties


@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;
@property (strong, nonatomic) NSArray *_menuTitles;
@property (nonatomic, strong) NSArray *_menuIcons;

@property (nonatomic, strong) iBPMStatusViewController *statusViewController;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMSidebarViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMSidebarViewController *)newViewController {
    iBPMSidebarViewController *sidebarViewController
        = [[iBPMSidebarViewController alloc] initWithNibName:kSideBarViewControllerNibName
                                               bundle:nil];
    
    return sidebarViewController;
}

// *************************************************************************************************
// # MARK: View Controller Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self _setup];
    [self _loadLifeCycleTableViewData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 1;
    
    return numberOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if ([tableView isKindOfClass:[YALContextMenuTableView class]]) {
        numberOfRows = self._menuTitles.count;
    } else {
        numberOfRows = self.lifeCycles.count;
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if ([tableView isKindOfClass:[YALContextMenuTableView class]]) {
        ContextMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:kMenuCellIdentifier
                                                                forIndexPath:indexPath];
        if (menuCell) {
            menuCell.backgroundColor = [UIColor clearColor];
            menuCell.menuTitleLabel.text = self._menuTitles[indexPath.row];
            menuCell.menuImageView.image
                = [self._menuIcons[indexPath.row] scaledToSize:CGSizeMake(32, 32)];
        }
        cell = menuCell;
    } else {
        static NSString *CellIdentifier = @"sidebarTableCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[iBPMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
        [cell.textLabel setText:[self.lifeCycles[indexPath.row] uppercaseString]];
    }
    
    return cell;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    
    if (![tableView isKindOfClass:[YALContextMenuTableView class]]) {
        title = kLifeCycleSectionHeaderTitle;
    }
    
    return title;
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
// # MARK: Table view delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSInteger height = 0;
    
    if (![tableView isKindOfClass:[YALContextMenuTableView class]]) {
        height = 40.0;
    }
    
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45.0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isKindOfClass:[YALContextMenuTableView class]]) {
        [(YALContextMenuTableView *)tableView dismisWithIndexPath:indexPath];
        [self _contextTableViewidSelectRowAtIndexPath:indexPath];
    } else {
        [self _tableViewidSelectRowAtIndexPath:indexPath];
        [tableView selectRowAtIndexPath:indexPath
                               animated:NO
                         scrollPosition:UITableViewScrollPositionNone];
    }
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_contextTableViewidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self._menuTitles[indexPath.row];
    if (![title isEqualToString:kCloseButtonTitle]) {
        if ([title isEqualToString:kSettingsButtonTitle]) {
            iBPMSettingsViewController *settingsViewController
                = [iBPMSettingsViewController newViewController];
            settingsViewController.delegate = self;
            iBPMNavigationController * nav
                = [[iBPMNavigationController alloc] initWithRootViewController:settingsViewController];
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        } else if ([title isEqualToString:kiBPMMonitorButtonTitle]) {
            [self _loadLifeCycleTableViewData];
            [iBPMStateManager sharedManager].currentApp = monitorApp;
            [self setTitle:kiBPMMonitorButtonTitle];
        } else if ([title isEqualToString:kiBPMStatusButtonTitle]) {
            [self _loadStatusTableViewData];
            [iBPMStateManager sharedManager].currentApp = statusApp;
            [self setTitle:kiBPMStatusButtonTitle];
        }
    }
}


- (void)_initiateMenuOptions {
    self._menuTitles = @[kCloseButtonTitle,
                        kiBPMMonitorButtonTitle,
                        kiBPMStatusButtonTitle,
                        kSettingsButtonTitle];
    self._menuIcons = @[[UIImage imageNamed:@"closeIcon"],
                        [UIImage imageNamed:@"monitorIcon"],
                        [UIImage imageNamed:@"statusIcon"],
                        [UIImage imageNamed:@"settingsIcon"]];
}


- (void)_loadLifeCycleTableViewData {

///We can cache it in memory instead of getting it from server every time.
///For now, the life cycles are hard code.
    [[iBPMDataProviderManager dataProvider] getLifeCycles:^(id results) {
        self.lifeCycles = results;
        [self._tableView reloadData];
    } failure:^(NSArray *errors) {
        [UIAlertController showAlertFor:self];
    }];
 //   self.lifeCycles = @[@"prod"];
    [self._tableView reloadData];
}


- (void)_loadStatusTableViewData {
    self.lifeCycles = @[@"status", @"history"];
    [self._tableView reloadData];
}


- (void)_setup {
    self._tableView.dataSource = self;
    self._tableView.delegate = self;
    [self._tableView setBackgroundColor:[iBPMColorUtils sidebarTableViewBackgroundColor]];
    [self._tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view setBackgroundColor:[iBPMColorUtils sidebarViewBackgroundColor]];
    [self setTitle:kiBPMMonitorButtonTitle];
    [self.mm_drawerController setShowsShadow:YES];
    [self _setupLeftMenuButton];
    [self _initiateMenuOptions];
}


-(void)_setupLeftMenuButton {
    iBPMDrawerBarButtonItem *leftDrawerButton =
        [[iBPMDrawerBarButtonItem alloc] initWithTarget:self
                                             action:@selector(presentMenuButtonDidPress:)
                                                  style:iBPMNavigationBarItemStylePlus];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}


- (void)_tableViewidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iBPMMainViewController *mainViewController = nil;
    switch ([iBPMStateManager sharedManager].currentApp) {
        case monitorApp: {
            mainViewController = [iBPMMonitorViewController newViewController];
            [iBPMStateManager sharedManager].currentLifeCycle = self.lifeCycles[indexPath.row];
            mainViewController.navigationBarTitle = self.lifeCycles[indexPath.row];
        }
            break;
        case statusApp: {
            if (!self.statusViewController) {
                mainViewController = [iBPMStatusViewController newViewController];
                self.statusViewController = (iBPMStatusViewController *)mainViewController;
            } else {
                mainViewController = self.statusViewController;
            }
            [iBPMStateManager sharedManager].currentInfoType = self.lifeCycles[indexPath.row];
            mainViewController.navigationBarTitle = self.lifeCycles[indexPath.row];
            [((iBPMStatusViewController *)mainViewController) clearTableView];
        }
            break;
        default:
            break;
    }
    iBPMNavigationController * nav
        = [[iBPMNavigationController alloc] initWithRootViewController:mainViewController];
    [self.mm_drawerController setCenterViewController:nav
                                   withCloseAnimation:YES
                                           completion:nil];
}


// *************************************************************************************************
// # MARK: Public Methods


- (IBAction)presentMenuButtonDidPress:(id)sender {
    if (!self.contextMenuTableView) {
        self.contextMenuTableView =
            [[YALContextMenuTableView alloc] initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.08;
        self.contextMenuTableView.yalDelegate = self;
        self.contextMenuTableView.menuItemsSide = Right;
        self.contextMenuTableView.menuItemsAppearanceDirection = FromTopToBottom;
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:kMenuCellIdentifier];
    }
    
    [self.contextMenuTableView showInView:self.navigationController.view
                           withEdgeInsets:UIEdgeInsetsZero
                                 animated:YES];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}


- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
}


// *************************************************************************************************
// # MARK: iBPMSettingsViewControllerDelegate


- (void)logOutButtonDidPress {
    [[self.mm_drawerController presentingViewController] dismissViewControllerAnimated:YES
                                                                            completion:nil];
}


@end
