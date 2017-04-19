// *************************************************************************************************
// # MARK: Imports


#import "iBPMDetailedStatusViewController.h"
#import "iBPMSideDrawerSectionHeaderView.h"
#import "iBPMSideDrawerTableViewCell.h"


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMDetailedStatusViewController () <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (strong, nonatomic) NSDictionary *selected;
@property (strong, nonatomic) NSString *keySelected;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDetailedStatusViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMDetailedStatusViewController *)newViewController {
    iBPMDetailedStatusViewController *statusViewController
        = [[iBPMDetailedStatusViewController alloc] initWithNibName:@"iBPMDetailedStatusViewController"
                                                 bundle:nil];
    
    return statusViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Details";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// *************************************************************************************************
// # MARK: Table View Datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 0;
    
    if (self.detailType == iBPMStatusDetailTypeArray) {
        numberOfSections = ((NSArray *)self.detailsArray).count;
    } else if (self.detailType == iBPMStatusDetailTypeDictionary) {
        numberOfSections = ((NSDictionary *)self.detailsDictionary).allKeys.count;
    }
    
    return numberOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if (self.detailType == iBPMStatusDetailTypeArray) {
        numberOfRows = ((NSDictionary *)self.detailsArray[section]).count;
    } else if (self.detailType == iBPMStatusDetailTypeDictionary) {
        NSLog(@"%@",self.detailsDictionary.allKeys[section]);
        NSString *tempStr = [self.detailsDictionary.allKeys objectAtIndex:section];
        self.selected = [self.detailsDictionary valueForKey:tempStr];
        if ([self.selected isKindOfClass:[NSString class]]) {
            numberOfRows = self.detailsDictionary.allKeys.count;
        }
        else if ([self.selected isKindOfClass:[NSDictionary class]]){
            numberOfRows = self.selected.count;
        }
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"statusTableCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[iBPMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel setFont:[UIFont iBPMApplicationTextFontWithSizeWithFontSize:14]];
    NSString *key = [[NSString alloc] init];
    NSString *value = [[NSString alloc] init];
    NSMutableString *mutatingStr = [[NSMutableString alloc] init];
    
    if (self.detailType == iBPMStatusDetailTypeArray) {
        NSDictionary *detailsDict = self.detailsArray[indexPath.section];
        key = detailsDict.allKeys[indexPath.row];
        value = detailsDict[key];
        if ([value isKindOfClass:[NSArray class]]) {
            for (NSDictionary *temp in (NSArray *)value) {
                [mutatingStr appendFormat:@"%@",temp];
            }
            mutatingStr = (NSMutableString *)[mutatingStr stringByReplacingOccurrencesOfString:@"{"
                                                                                    withString:@""];
            mutatingStr = (NSMutableString *)[mutatingStr stringByReplacingOccurrencesOfString:@"}"
                                                                                    withString:@""];
            mutatingStr = (NSMutableString *)[mutatingStr stringByReplacingOccurrencesOfString:@"\n"
                                                                                    withString:@""];
            [cell.textLabel setText:mutatingStr];
        }
        else if ([value isKindOfClass:[NSString class]]) {
            NSString *displayString = [NSString stringWithFormat:@"%@ : %@", key, value];
            [cell.textLabel setText:displayString];
        }
        else if ([value isKindOfClass:[NSDictionary class]]){
            NSString *displayString = [NSString stringWithFormat:@"%@",value];
            displayString = [displayString stringByReplacingOccurrencesOfString:@"{"
                                                                     withString:@""];
            displayString = [displayString stringByReplacingOccurrencesOfString:@"}"
                                                                     withString:@""];
            displayString = [displayString stringByReplacingOccurrencesOfString:@"\n"
                                                                     withString:@""];
            displayString = [displayString stringByReplacingOccurrencesOfString:@"\""
                                                                     withString:@""];
            displayString = [displayString stringByReplacingOccurrencesOfString:@"="
                                                                     withString:@" : "];
            displayString = [displayString stringByReplacingOccurrencesOfString:@";"
                                                                     withString:@""];
            [cell.textLabel setText:displayString];
        }
    } else if (self.detailType == iBPMStatusDetailTypeDictionary) {
        NSDictionary *temp = [[NSDictionary alloc] init];
        if ([self.selected isKindOfClass:[NSDictionary class]]) {
            if (self.selected.allKeys.count >= indexPath.row) {
                key =  self.selected.allKeys[indexPath.row];
                temp = [self.selected valueForKey:key];
            }
            
        } else {
            key =  self.detailsDictionary.allKeys[indexPath.row];
            temp = [self.detailsDictionary valueForKey:key];
        }
        
        if ([self.detailsDictionary[key] isKindOfClass:[NSString class]]) {
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ : %@", key,
                                     [self.detailsDictionary valueForKey:key]]];
        }
        else if ([self.detailsDictionary[key] isKindOfClass:[NSDictionary class]]){
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ : %@", temp.allKeys[indexPath.row],
                                     temp[temp.allKeys[indexPath.row]]]];
        }
        else if ([self.detailsDictionary[key] isKindOfClass:[NSArray class]]){
            [cell.textLabel setText:[NSString stringWithFormat:@"%@",
                                     (self.detailsDictionary[key])[indexPath.row]]];
        }
    }

    return cell;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = self.detailsDictionary.allKeys[section];
    
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
    NSInteger height = 40;
    
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45.0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
