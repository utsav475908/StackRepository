// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataModel.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDataModel


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    @try {
        self.dateTime = dict[@"DateTime"];
        self.hosts = dict[@"Hosts"];
        self.proxyURL = dict[@"ProxyURL"];
        self.status = dict[@"Status"];
        self.originalData = dict;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception = %@", exception);
    }
    @finally {
        return self;
    }
}


@end
