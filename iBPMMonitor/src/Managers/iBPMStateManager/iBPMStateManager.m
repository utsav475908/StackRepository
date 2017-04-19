// *************************************************************************************************
// # MARK: Imports


#import "iBPMStateManager.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMStateManager


// *************************************************************************************************
// # MARK: Class Methods


+ (iBPMStateManager *)sharedManager {
    static iBPMStateManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[iBPMStateManager alloc] init];
    });
    
    return _sharedManager;
}


@end
