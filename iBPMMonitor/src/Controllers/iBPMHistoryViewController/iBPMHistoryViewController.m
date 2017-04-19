// *************************************************************************************************
// # MARK: Imports


#import "iBPMHistoryViewController.h"
#import "HistoryCollectionViewCell.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMHistoryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


// *************************************************************************************************
// # MARK: Private Properties


@property (weak, nonatomic) IBOutlet UICollectionView *_myCollectionView;
@property (strong, nonatomic) NSArray *_sortedArray;
@property (weak, nonatomic) IBOutlet UIView *_mySubView;
@property (strong, nonatomic) NSDictionary *_selectedDictionary;
@property (weak, nonatomic) IBOutlet UITextView *_detailsTextView;
@property (strong, nonatomic) NSDictionary *plistAttributes;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMHistoryViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMHistoryViewController *)newViewController {
    iBPMHistoryViewController *historyViewController = [[iBPMHistoryViewController alloc]
                                                        initWithNibName:@"iBPMHistoryViewController"
                                                        bundle:nil];
    return historyViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self._myCollectionView registerNib:[UINib nibWithNibName:@"iBPMHistoryViewController"
                                                       bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self._myCollectionView.delegate = self;
    self._myCollectionView.dataSource = self;
    self._mySubView.layer.borderWidth = 1;
    self._mySubView.hidden = true;
    self._mySubView.layer.cornerRadius = 10;
    self._mySubView.layer.masksToBounds = YES;
    self._detailsTextView.editable = NO;
    NSSortDescriptor *sortValues = [NSSortDescriptor sortDescriptorWithKey:@"pxTimeCreated" ascending:NO];
    self._sortedArray = [_historyArray sortedArrayUsingDescriptors:@[sortValues]];
    NSDictionary *plistDictionary = [NSDictionary
                                     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource:@"HistoryFilters"
                                                                   ofType:@"plist"]];
    self.plistAttributes = [plistDictionary valueForKey:self.domainName];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Detailed History";
}


// *************************************************************************************************
// # MARK: Collection View DataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self._sortedArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    HistoryCollectionViewCell *cell;
    if (cell == nil) {
        [collectionView registerNib:[UINib nibWithNibName:@"HistoryCollectionViewCell" bundle:nil]
         forCellWithReuseIdentifier:cellIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                         forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    NSDictionary *sortedDictionary = [self._sortedArray objectAtIndex:indexPath.row];
    NSString *keyValue = [sortedDictionary valueForKey:@"pxTimeCreated"];
    [cell setID:keyValue];
    NSDictionary *selected = [self._sortedArray objectAtIndex:indexPath.row];
    
    __block NSMutableDictionary *displayDictionary = [[NSMutableDictionary alloc] init];
    [selected enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.plistAttributes.allKeys containsObject:key]) {
            [displayDictionary setValue:obj forKey:key];
        }
    }];
    [cell setAttributes:displayDictionary withDomain:self.domainName];
    return cell;
}


// *************************************************************************************************
// # MARK: Collection View Delegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self._mySubView.hidden = false;
    NSDictionary *selected = [self._sortedArray objectAtIndex:indexPath.row];
    
    __block NSMutableString *strToDisplay = [[NSMutableString alloc] init];
    [selected enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.plistAttributes.allKeys containsObject:key]) {
            [strToDisplay appendFormat:@"%@ = %@\n\n\n",[self.plistAttributes valueForKey:key],obj];
        }
    }];
    NSLog(@"%@",strToDisplay);
    self._detailsTextView.text = strToDisplay;
}


// *************************************************************************************************
// # MARK: Action Methods


- (IBAction)closeBtnAction:(id)sender {
    self._mySubView.hidden = true;
}

@end
