// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProvider.h"
#import "iBPMDataProviderInterface.h"


// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMServerDataProvider : iBPMDataProvider <iBPMDataProviderInterface>


+ (id)sharedProvider;


@end
