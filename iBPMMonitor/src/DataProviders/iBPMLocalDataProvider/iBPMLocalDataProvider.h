// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProvider.h"
#import "iBPMDataProviderInterface.h"


// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMLocalDataProvider : iBPMDataProvider <iBPMDataProviderInterface>


+ (id)sharedProvider;


@end
