// *************************************************************************************************
// # MARK: Imports


#import "iBPMLocalDataProvider.h"

#import "iBPMAuthenticationManager.h"
#import "iBPMDataParserUtils.h"
#import "iBPMDataProviderInterface.h"
#import "iBPMDataProvider+PostProcessor.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMLocalDataProvider


// *************************************************************************************************
// # MARK: Class Methods


+ (id)sharedProvider {
    static iBPMLocalDataProvider *sharedLocalDataProvider = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocalDataProvider = [[self alloc] init];
    });
    
    return sharedLocalDataProvider;
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)getDomainsIn:(NSString *)lifeCycle
             success:(iBPMRequestData)success
             failure:(iBPMRequestDataError)failure {
    if (lifeCycle) {
        [self getStatus:^(id results) {
            for (NSDictionary *lifeCycleDict in results) {
                if ([[lifeCycleDict allKeys] containsObject:lifeCycle]) {
                    success(lifeCycleDict);
                    break;
                }
            }
        } failure:^(NSArray *errors) {
        }];
    } else {
        failure(nil);
    }
}


- (void)getLifeCycles:(iBPMRequestData)success failure:(iBPMRequestDataError)failure {
    [self getStatus:^(id results) {
        NSMutableArray *lifeCycles = [NSMutableArray new];
        for (NSDictionary *lifeCycle in results) {
            [lifeCycles addObjectsFromArray:[lifeCycle allKeys]];
        }
        success(lifeCycles);
    } failure:^(NSArray *errors) {
        
    }];
}


- (void)getStatus:(iBPMRequestData)success failure:(iBPMRequestDataError)failure {
    NSArray *localJson = [iBPMDataParserUtils parseDataFromFile:@"status"];
    [self processStatusWithServerResponse:localJson
                          completionBlock:^(id results) {
                              success(results);
                          }];
}


- (void)getStatusForDomain:(NSString *)domain
                  infoType:(NSString *)infoType
                      SRID:(NSString *)SRID
                   success:(iBPMRequestData)success
                   failure:(iBPMRequestDataError)failure {
    success (nil);
}


- (void)loginWithUserID:(NSString *)userID
               password:(NSString *)password
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure {
    NSArray *authCookies = @[@"", @"", @""];
    [[iBPMAuthenticationManager sharedManager] setAuthCookies:authCookies];
    success (nil);
}


- (void)sendDeviceToken:(NSString*)token
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure {
    NSArray *authCookies = @[@"", @"", @""];
    [[iBPMAuthenticationManager sharedManager] setAuthCookies:authCookies];
    success(nil);
/// Remote access needs all these connections done below.
//    NSString *uri = [NSString stringWithFormat:@"/prd2/brmsadmin/storetoken"];
//    NSString *url_ = [self _createURLWithUri:uri andParameters:nil];
//    NSString *requestString = [NSString stringWithFormat:@"token=%@",token];
//    NSData *bodyData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
//    [self _sendPOSTRequestWithUrl:url_ bodyParameters:bodyData success:success failure:failure];
}


- (void)logOut {
    
}


@end
