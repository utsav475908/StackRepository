// *************************************************************************************************
// # MARK: Imports


#import "iBPMDomainModel.h"

#import "iBPMAppModel.h"
#import "iBPMColorUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDomainModel


// *************************************************************************************************
// # MARK: Initialization


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    
    @try {
        self.appsDictionary = dict[@"Apps"];
        NSMutableArray *appsArray = [NSMutableArray new];
        for (NSString *appKey in self.appsDictionary) {
            iBPMAppModel *app
                = [[iBPMAppModel alloc] initWithDictionary:self.appsDictionary[appKey]];
            app.name = appKey;
            [appsArray addObject:app];
        }
        self.appsArray = appsArray;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception = %@", exception);
    }
    @finally {
        return self;
    }
}


// *************************************************************************************************
// # MARK: Public Methods


- (NSString *)getDetailedDescription {
    return [NSString stringWithFormat:@"Status: %@ \t Time: %@", self.status, self.dateTime];
}


- (NSAttributedString *)getAttributedDetails {
    UIFont *arialFont = [UIFont fontWithName:@"arial" size:14.0];
    UIColor *statusColor = [iBPMColorUtils statusLabelBackgroundColor:self.status];
    NSDictionary *arialDict
        = @{NSForegroundColorAttributeName: statusColor, NSFontAttributeName: arialFont};
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:self.status
                                                                                    attributes: arialDict];
    UIFont *VerdanaFont = [UIFont fontWithName:@"verdana" size:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
    NSMutableAttributedString *timeTag = [[NSMutableAttributedString alloc] initWithString:@"\t  "
                                                                                attributes: verdanaDict];
    [aAttrString appendAttributedString:timeTag];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: self.dateTime
                                                                                   attributes:verdanaDict];
    [vAttrString addAttribute:NSForegroundColorAttributeName
                        value:[UIColor blackColor]
                        range:(NSMakeRange(0, self.dateTime.length - 1))];
    [aAttrString appendAttributedString:vAttrString];
    
    return aAttrString;
}


@end
