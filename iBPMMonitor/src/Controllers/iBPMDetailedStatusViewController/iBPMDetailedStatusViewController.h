// *************************************************************************************************
// # MARK: Type Definition


typedef NS_ENUM(NSInteger, iBPMStatusDetailType) {
    iBPMStatusDetailTypeArray,
    iBPMStatusDetailTypeDictionary
};


// *************************************************************************************************
// # MARK: Imports


#import "iBPMDomainViewController.h"


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMDetailedStatusViewController : iBPMDomainViewController


// *************************************************************************************************
// # MARK: Factory Methods


+ (iBPMDetailedStatusViewController *)newViewController;


// *************************************************************************************************
// # MARK: Public Properties


@property (strong, nonatomic) NSArray *detailsArray;
@property (strong, nonatomic) NSDictionary *detailsDictionary;
@property (assign, nonatomic) iBPMStatusDetailType detailType;


@end
