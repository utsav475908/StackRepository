// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProviderInterface.h"


// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMDataProviderManager : NSObject


+ (id<iBPMDataProviderInterface>)dataProvider;


@end
