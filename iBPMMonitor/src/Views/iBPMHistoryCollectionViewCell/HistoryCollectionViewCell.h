// *************************************************************************************************
// # MARK: Imports


#import <UIKit/UIKit.h>


// *************************************************************************************************
// # MARK: Interfaces


@interface HistoryCollectionViewCell : UICollectionViewCell


// *************************************************************************************************
// # MARK: Public Properties


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *attribute1;
@property (weak, nonatomic) IBOutlet UILabel *attribute2;
@property (weak, nonatomic) IBOutlet UILabel *attribute3;
@property (weak, nonatomic) IBOutlet UILabel *attr1Value;
@property (weak, nonatomic) IBOutlet UILabel *attr2Value;
@property (weak, nonatomic) IBOutlet UILabel *attr3Value;
@property (weak, nonatomic) IBOutlet UILabel *Attribute4;
@property (weak, nonatomic) IBOutlet UILabel *attr4Value;


// *************************************************************************************************
// # MARK: Public Interface


- (void)setID:(NSString *)tempName;
- (void)setAttributes:(NSMutableDictionary *)tempAttrDictionay withDomain:(NSString*)domain;


@end
