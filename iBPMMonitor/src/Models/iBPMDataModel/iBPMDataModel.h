// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMDataModel : NSObject


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *dateTime;
@property (nonatomic, strong, readwrite) NSArray *hosts;
@property (nonatomic, strong, readwrite) NSString *proxyURL;
@property (nonatomic, strong, readwrite) NSString *status;


// *************************************************************************************************
// # MARK: Original Data


@property (nonatomic, strong, readwrite) NSDictionary *originalData;


// *************************************************************************************************
// # MARK: Public Properties


- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
