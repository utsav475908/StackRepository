// *************************************************************************************************
// # MARK: Imports


#import "iBPMAuthenticationManager.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMAuthenticationManager



// *************************************************************************************************
// # MARK: Class Methods


+ (iBPMAuthenticationManager *)sharedManager {
    static iBPMAuthenticationManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[iBPMAuthenticationManager alloc] init];
    });
    
    return _sharedManager;
}



// *************************************************************************************************
// # MARK: Public Methods


- (NSDictionary *)getAuthenticationHeader {
    NSDictionary* headers = nil;
    
    if (self.authCookies) {
        headers = [NSHTTPCookie requestHeaderFieldsWithCookies:self.authCookies];
    }
    
    return headers;
}


- (BOOL)isAuthenticated {
    
    return self.authCookies > 0 ? YES : NO;
}

@end
