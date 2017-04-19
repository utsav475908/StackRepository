// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataModel.h"


// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMDomainModel : iBPMDataModel


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic, strong, readwrite) NSDictionary *appsDictionary;
@property (nonatomic, strong, readwrite) NSArray *appsArray;


// *************************************************************************************************
// # MARK: Initialization


- (instancetype)initWithDictionary:(NSDictionary *)dict;


// *************************************************************************************************
// # MARK: Public Methods


- (NSString *)getDetailedDescription;
- (NSAttributedString *)getAttributedDetails;


@end
