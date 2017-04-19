// *************************************************************************************************
// # MARK: Imports


#import "iBPMStatusViewController.h"

#import "iBPMHistoryViewController.h"
#import "iBPMDataProviderManager.h"
#import "iBPMDetailedStatusViewController.h"
#import "iBPMSideDrawerTableViewCell.h"
#import "UITextField+Extension.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMStatusViewController () <UITextFieldDelegate,
                                        UIPickerViewDataSource,
                                        UIPickerViewDelegate>


// *************************************************************************************************
// # MARK: Private IBOutlets

@property (weak, nonatomic) IBOutlet UILabel *_domainLabel;
@property (weak, nonatomic) IBOutlet UITextField *_domainTextField;
@property (weak, nonatomic) IBOutlet UILabel *_idLabel;
@property (weak, nonatomic) IBOutlet UITextField *_idTextField;
@property (weak, nonatomic) IBOutlet UIButton *_searchButton;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;


// *************************************************************************************************
// # MARK: Private Properties


@property (strong, nonatomic) NSArray *_allKeys;
@property (strong, nonatomic) UIPickerView *_domainPickerView;
@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) NSDictionary *statusDict;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMStatusViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMStatusViewController *)newViewController {
    iBPMStatusViewController *statusViewController
        = [[iBPMStatusViewController alloc] initWithNibName:@"iBPMStatusViewController"
                                                  bundle:nil];
    
    return statusViewController;
}


// *************************************************************************************************
// # MARK: View Controller Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self._domainTextField addBottomLine];
    [self._idTextField addBottomLine];
    [self _addPickerView];
    self._tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self._domainLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:16]];
    [self._domainLabel setTextColor:[iBPMColorUtils domainLabelTextColor]];
    [self._idLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:16]];
    [self._idLabel setTextColor:[iBPMColorUtils domainLabelTextColor]];
    [self._searchButton.titleLabel setFont:[UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:16]];
    [self._searchButton setTintColor:[iBPMColorUtils loginButtonTitleColor]];
    [self._tableView setBackgroundColor:[iBPMColorUtils mainTableViewBackgroundColor]];
    
    if (self.notificationFlag == TRUE) {
        self._idTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"SR_ID"];
        self._domainTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"domain"];
        [self _loadStatusData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)clearTableView {
    self.statusDict = nil;
    self._allKeys = nil;
    [self._tableView reloadData];
}


// *************************************************************************************************
// # MARK: IBAction


- (IBAction)pickerDoneClicked:(id)sender {
    [self._domainPickerView removeFromSuperview];
    [self._domainTextField resignFirstResponder];
}


- (IBAction)searchButtonDidPress:(id)sender {
    [self _loadStatusData];
}


// *************************************************************************************************
// # MARK: Text field delegates


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
    }
}


// *************************************************************************************************
// # MARK: Picker View Data source


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}


// *************************************************************************************************
// # MARK: Picker View Delegate


-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    [self._domainTextField setText:[self.pickerArray objectAtIndex:row]];
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self._allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    iBPMTableViewCell *cell = nil;
    static NSString *CellIdentifier = @"statusTableCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[iBPMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    [cell setBackgroundColor:[iBPMColorUtils mainTableViewCellBackgroundColor]];
    [cell.layer setBorderWidth:1];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.textLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:14]];
    
    if ([self.statusDict[self._allKeys[indexPath.row]] isKindOfClass: [NSString class]]) {
        NSString *key = self._allKeys[indexPath.row];
        NSString *displayString = [NSString stringWithFormat:@"%@ : %@", key, self.statusDict[key]];
        if ([key isEqualToString:@"Language"]) {
            NSLog(@"%@", @"Language");
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        [cell.textLabel setText:displayString];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else if ([self.statusDict[self._allKeys[indexPath.row]] isKindOfClass: [NSArray class]]) {
        NSArray *temp = self.statusDict[self._allKeys[indexPath.row]];
        if (temp.count == 0) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setDisclosureIndicatorColor: [UIColor iBPMPrimaryBlueColor]];
        }
        NSString *displayString = self._allKeys[indexPath.row];
        [cell.textLabel setText:displayString];
        
    } else if ([self.statusDict[self._allKeys[indexPath.row]] isKindOfClass: [NSDictionary class]]) {
        NSLog(@"%@", self.statusDict[self._allKeys[indexPath.row]]);
        [cell.textLabel setText:self._allKeys[indexPath.row]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setDisclosureIndicatorColor: [UIColor iBPMPrimaryBlueColor]];
    }
    
    return cell;
}


// *************************************************************************************************
// # MARK: Table View delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iBPMDetailedStatusViewController *detailedStatusViewController = [iBPMDetailedStatusViewController newViewController];
    iBPMHistoryViewController *historyViewController = [iBPMHistoryViewController newViewController];
    
    NSString *indexStr = self._allKeys[indexPath.row];
    NSLog(@"Key : %@",indexStr);
    
    if ([indexStr caseInsensitiveCompare:@"History"] == NSOrderedSame) {
        historyViewController.historyArray = self.statusDict[self._allKeys[indexPath.row]];
        historyViewController.domainName = self._domainTextField.text;
        [self.navigationController pushViewController:historyViewController animated:YES];
    }
    else {
        if ([self.statusDict[self._allKeys[indexPath.row]] isKindOfClass: [NSArray class]]) {
            NSArray *temp = self.statusDict[self._allKeys[indexPath.row]];
            if (temp.count != 0) {
                detailedStatusViewController.detailsArray = temp;
                detailedStatusViewController.detailType = iBPMStatusDetailTypeArray;
                [self.navigationController pushViewController:detailedStatusViewController animated:YES];
            }
        } else if ([self.statusDict[self._allKeys[indexPath.row]] isKindOfClass: [NSDictionary class]]) {
            detailedStatusViewController.detailsDictionary = self.statusDict[self._allKeys[indexPath.row]];
            detailedStatusViewController.detailType = iBPMStatusDetailTypeDictionary;
            [self.navigationController pushViewController:detailedStatusViewController animated:YES];
        }
    }
    
    [tableView selectRowAtIndexPath:indexPath
                           animated:NO
                     scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// *************************************************************************************************
// # MARK: Private Interfaces


-(void)_addPickerView {
    [self _loadPickerViewData];
    self._domainTextField.delegate = self;
    [self._domainTextField setPlaceholder:@"Pick a Domain"];
    self._domainPickerView = [[UIPickerView alloc]init];
    self._domainPickerView.dataSource = self;
    self._domainPickerView.delegate = self;
    self._domainPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(pickerDoneClicked:)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [toolBar setBarStyle:UIBarStyleDefault];
    [toolBar setBackgroundColor:[iBPMColorUtils navigationBarBackgroundColor]];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    self._domainTextField.inputView = self._domainPickerView;
    self._domainTextField.inputAccessoryView = toolBar;
}


- (void)_loadStatusData {
    [MBProgressHUD showWaitIndicator:self.view];
    [[iBPMDataProviderManager dataProvider]
     getStatusForDomain:self._domainTextField.text
     infoType:[iBPMStateManager sharedManager].currentInfoType
     SRID:self._idTextField.text
     success:^(id results) {
         self.statusDict = results;
         self._allKeys = self.statusDict.allKeys;
         [self._tableView reloadData];
         [MBProgressHUD hideWaitIndicator:self.view];
         NSLog(@"Results from Server : %@", results);
     } failure:^(NSArray *errors) {
         NSLog(@"%@", errors);
     }];
}


/*!
 @brief Loads Picker View.
 
 @discussion This method loads the domain data for the picker view.
 
 To use it, simply call @code [self _loadPickerViewData]; @endcode
 */
- (void)_loadPickerViewData {
    [[iBPMDataProviderManager dataProvider]
        getDomainsIn:[iBPMStateManager sharedManager].currentLifeCycle
             success:^(id results) {
                 NSDictionary *domains = results[[iBPMStateManager sharedManager].currentLifeCycle];
                 self.pickerArray
                    = [domains.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    } failure:^(NSArray *errors) {
        NSLog(@"%@", errors);
    }];
}


@end
