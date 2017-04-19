// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProviderManager.h"

#import "iBPMDataProviderInterface.h"
#import "iBPMLocalDataProvider.h"
#import "iBPMServerDataProvider.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDataProviderManager


+ (id <iBPMDataProviderInterface>)dataProvider {
    NSString *schemeName = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"SchemeName"];
    
    if ([schemeName containsString:@"Localdata"]) {
        return [iBPMLocalDataProvider sharedProvider];
    } else {
        return [iBPMServerDataProvider sharedProvider];
    }
}


@end
