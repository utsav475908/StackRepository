// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMAuthenticationManager : NSObject


// *************************************************************************************************
// # MARK: Class Methods


+ (iBPMAuthenticationManager *)sharedManager;


// *************************************************************************************************
// # MARK: Public Methods


- (NSDictionary *)getAuthenticationHeader;
- (BOOL)isAuthenticated;


// *************************************************************************************************
// # MARK: Public Properties


@property (strong, atomic) NSArray* authCookies;


@end
