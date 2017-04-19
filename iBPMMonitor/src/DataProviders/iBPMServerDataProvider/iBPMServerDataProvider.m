// *************************************************************************************************
// # MARK: Imports


#import "iBPMServerDataProvider.h"

#import "iBPMAuthenticationManager.h"
#import "iBPMConnection.h"
#import "iBPMDataProviderInterface.h"
#import "iBPMDataProvider+PostProcessor.h"
#import "iBPMOperationQueueUtils.h"
#import <arpa/inet.h>
#import <netdb.h>
#import <netinet/in.h>
#import <sys/socket.h>
#import <SystemConfiguration/SCNetworkReachability.h>


// *************************************************************************************************
// # MARK: Inline Functions


static inline NSString * _baseUrl() {
    return @"https://ibpm.cisco.com";
//    return @"http://brms-test-5:7010";
}


// *************************************************************************************************
// # MARK: Private Interfaces


@interface iBPMServerDataProvider ()


@end

// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMServerDataProvider


// *************************************************************************************************
// # MARK: Class Methods


+ (id)sharedProvider {
    static iBPMServerDataProvider *sharedServerDataProvider = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedServerDataProvider = [[self alloc] init];
    });
    
    return sharedServerDataProvider;
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)getDomainsIn:(NSString *)lifeCycle
             success:(iBPMRequestData)success
             failure:(iBPMRequestDataError)failure {
    if (lifeCycle) {
        [self getStatus:^(id results) {
            for (NSDictionary *domains in results) {
                if ([[domains allKeys] containsObject:lifeCycle]) {
                    success(domains);
                    break;
                }
            }
        } failure:failure];
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
    } failure:failure];
}



- (void)getStatus:(iBPMRequestData)success failure:(iBPMRequestDataError)failure {
    NSString *uri = [NSString stringWithFormat:@"/prd2/brmsadmin/status"];
    NSString *url_ = [self _createURLWithUri:uri andParameters:nil];
    
    [self _sendGETRequestWithUrl:url_
                  bodyParameters:nil
                         success:^(id response) {
                             [self processStatusWithServerResponse:response
                                                   completionBlock:^(id results) {
                                                       success(results);
                                                   }];
                         }
                         failure:failure];
}


- (void)getStatusForDomain:(NSString *)domain
                  infoType:(NSString *)infoType
                      SRID:(NSString *)SRID
                   success:(iBPMRequestData)success
                   failure:(iBPMRequestDataError)failure {
    NSString *uri = [NSString stringWithFormat:@"/prd2/brmsadmin/work/info/%@", domain];
    if ([infoType isEqualToString:@"history"]) {
        uri = [uri stringByAppendingString:@"/history"];
    }
    NSString *url_ = [self _createURLWithUri:uri andParameters:nil];
    NSMutableDictionary *bodyDic = [NSMutableDictionary new];
    SRID ? [bodyDic setObject:SRID forKey:@"_id"]
    : [bodyDic setObject:[NSNull null] forKey:@"_id"];
    NSData *bodyData = [self _getDataFromDictionary:bodyDic];
    [self _sendPOSTRequestWithUrl:url_
                   bodyParameters:bodyData
                          success:success
                          failure:failure];
}


- (void)loginWithUserID:(NSString *)userID
               password:(NSString *)password
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure {
    NSString *uri = [NSString stringWithFormat:@"/cpe/cs/login"];
    NSString *url_ = [self _createURLWithUri:uri andParameters:nil];
    NSString *requestString = [NSString stringWithFormat:@"userid=%@&password=%@", userID, password];
    NSData* bodyData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [self _sendPOSTRequestWithUrl:url_
                   bodyParameters:bodyData
                          success:success
                          failure:failure];
}


- (void)sendDeviceToken:(NSString*)token
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure {
    NSString *uri = [NSString stringWithFormat:@"/prd2/brmsadmin/storetoken"];
    NSString *url_ = [self _createURLWithUri:uri andParameters:nil];
    NSString *requestString = [NSString stringWithFormat:@"token=%@",token];
    NSData *bodyData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    [self _sendPOSTRequestWithUrl:url_ bodyParameters:bodyData success:success failure:failure];
}

// *************************************************************************************************
// # MARK: Private Methods


- (BOOL)_checkConnectivity {
    if (![self _connectedToNetwork]) {
        return NO;
    } else {
        return YES;
    }
}


- (BOOL)_connectedToNetwork {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress)); zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


- (NSString *)_createURLWithUri:(NSString *)uri andParameters:(NSDictionary *)parameters {
    NSString *url_ = [_baseUrl() stringByAppendingString:uri];
    NSMutableString *queryString = @"".mutableCopy;
    if (parameters) {
        for (NSString *key in parameters.allKeys) {
            [queryString appendString:[NSString stringWithFormat:@"%@=%@&",
                                       key,
                                       [parameters objectForKey:key]]];
        }
        [queryString deleteCharactersInRange:NSMakeRange([queryString length]-1, 1)];
        url_ = [NSString stringWithFormat:@"%@?%@", url_, queryString];
    }
    return url_;
}


- (NSData *)_getDataFromDictionary:(NSDictionary *)dictionary {
    NSData *dataFromDict;
    NSError *error;
    
    if (dictionary) {
        dataFromDict = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions
                                                         error:&error];
    }
    if (!error) {
        return dataFromDict;
    } else {
        return nil;
    }
}


- (NSData *)_getDataFromArray:(NSArray *)array {
    NSData *dataFromDict;
    NSError *error;
    
    if (array) {
        dataFromDict = [NSJSONSerialization dataWithJSONObject:array
                                                       options:kNilOptions
                                                         error:&error];
    }
    if (!error) {
        return dataFromDict;
    } else {
        return nil;
    }
}


- (NSArray *)_getErrorsFromResponse:(NSDictionary *)response {
    NSMutableArray *errors = [NSMutableArray new];
    
    NSDictionary *resultJson = [response objectForKey:@"status"];
    NSNumber *isSuccess = [resultJson objectForKey:@"success"];
    if ([isSuccess integerValue] == 0) {
        NSArray *errorArray = [resultJson objectForKey:@"errors"];
        for (NSDictionary *eachError in errorArray) {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(eachError[@"errorMessage"], nil),
                                       };
            NSError *error = [NSError errorWithDomain:@"iBPMServerErrorDomain"
                                                 code:[eachError[@"errorCode"] integerValue]
                                             userInfo:userInfo];
            [errors addObject:error];
            
        }
    }
    
    return errors;
}


- (void)_sendDELETERequestWithUrl:(NSString *)url
                   bodyParameters:(NSData *)bodyParameters
                          success:(iBPMRequestData)success
                          failure:(iBPMRequestDataError)failure  {
    if (!url) {
        failure(@[[NSError new]]);
        return;
    }
    NSDictionary *httpHeaderField = [[iBPMAuthenticationManager sharedManager] getAuthenticationHeader];
    [[iBPMOperationQueueUtils backgroundQueue] addOperationWithBlock:^{
        iBPMConnection *connection = [[iBPMConnection alloc] init];
        
        NSLog(@"%@ %@ url %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url);
        
        [connection doDELETERequest:url
                   httpHeaderFields:httpHeaderField
                         parameters:bodyParameters
                            success:^(NSURLRequest *request, NSDictionary *response) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    success(response);
                                }];
                            }
                            failure:^(NSURLRequest *request, NSDictionary *response, NSError *error) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    if (error) {
                                        failure(@[error, [self _getErrorsFromResponse:response]]);
                                    } else {
                                        failure([self _getErrorsFromResponse:response]);
                                    }
                                }];
                            }];
    }];
}


- (void)_sendGETRequestWithUrl:(NSString *)url
                bodyParameters:(NSData *)bodyParameters
                       success:(iBPMRequestData)success
                       failure:(iBPMRequestDataError)failure  {
    @try {
        if (!url) {
            failure(@[[NSError new]]);
            return;
        }
        NSDictionary *httpHeaderField =
            [[iBPMAuthenticationManager sharedManager] getAuthenticationHeader];

        [[iBPMOperationQueueUtils backgroundQueue] addOperationWithBlock:^{
            iBPMConnection *connection = [[iBPMConnection alloc] init];
            
            NSLog(@"%@ %@ url %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url);
            
            [connection doGETRequest:url
                    httpHeaderFields:httpHeaderField
                          parameters:bodyParameters
                             success:^(NSURLRequest *request, NSDictionary *response) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     success(response);
                                 }];
                             }
                             failure:^(NSURLRequest *request, NSDictionary *response, NSError *error) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     if (error) {
                                         failure(@[error, [self _getErrorsFromResponse:response]]);
                                     } else {
                                         failure([self _getErrorsFromResponse:response]);
                                     }
                                 }];
                             }];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ %@ url %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url);
    }
}


- (void)_sendPOSTRequestWithUrl:(NSString *)url
                 bodyParameters:(NSData *)bodyParameters
                        success:(iBPMRequestData)success
                        failure:(iBPMRequestDataError)failure  {
    
    @try {
        if (!url) {
            failure(@[[NSError new]]);
            return;
        }
        
        NSDictionary *httpHeaderField =
            [[iBPMAuthenticationManager sharedManager] getAuthenticationHeader];
        [[iBPMOperationQueueUtils backgroundQueue] addOperationWithBlock:^{
            iBPMConnection *connection = [[iBPMConnection alloc] init];
            
            NSLog(@"%@ %@ url %@ request %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url, [[NSString alloc] initWithData:bodyParameters encoding:NSUTF8StringEncoding]);
            
            [connection doPostRequest:url
                     httpHeaderFields:httpHeaderField
                           parameters:bodyParameters
                              success:^(NSURLRequest *request, NSDictionary *response) {
                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                      success(response);
                                      NSLog(@"%@",response);
                                  }];
                              }
                              failure:^(NSURLRequest *request, NSDictionary *response, NSError *error) {
                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                      if (error) {
                                          failure(@[error, [self _getErrorsFromResponse:response]]);
                                          NSLog(@"%@",error.localizedDescription);
                                      } else {
                                          failure([self _getErrorsFromResponse:response]);
                                          NSLog(@"%@",error.localizedDescription);
                                      }
                                  }];
                              }];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ %@ url %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url);
    }
}


- (void)_sendPOSTRequestForFormDataWithUrl:(NSString *)url
                                 filePaths:(NSArray *)paths
                                   success:(iBPMRequestData)success
                                   failure:(iBPMRequestDataError)failure {
    if (!url) {
        failure(@[[NSError new]]);
        return;
    }
    
    NSDictionary *httpHeaderField =
        [[iBPMAuthenticationManager sharedManager] getAuthenticationHeader];
    [[iBPMOperationQueueUtils backgroundQueue] addOperationWithBlock:^{
        iBPMConnection *connection = [[iBPMConnection alloc] init];
        
        NSLog(@"%@ %@ url %@ paths %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url, [paths description]);
        
        [connection
         doPostRequestWithFormData:url
         httpHeaderFields:httpHeaderField
         filePaths:paths
         success:^(NSURLRequest *request, NSDictionary *response) {
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 success(response);
             }];
         }
         failure:^(NSURLRequest *request, NSDictionary *response, NSError *error) {
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 if (error) {
                     failure(@[error, [self _getErrorsFromResponse:response]]);
                 } else {
                     failure([self _getErrorsFromResponse:response]);
                 }
             }];
         }];
    }];
}


- (void)_sendPUTRequestWithUrl:(NSString *)url
                bodyParameters:(NSData *)bodyParameters
                       success:(iBPMRequestData)success
                       failure:(iBPMRequestDataError)failure  {
    if (!url) {
        failure(@[[NSError new]]);
        return;
    }
    
    NSDictionary *httpHeaderField =
        [[iBPMAuthenticationManager sharedManager] getAuthenticationHeader];
    [[iBPMOperationQueueUtils backgroundQueue] addOperationWithBlock:^{
        iBPMConnection *connection = [[iBPMConnection alloc] init];
        
        NSLog(@"%@ %@ url %@ request %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url, [[NSString alloc] initWithData:bodyParameters encoding:NSUTF8StringEncoding]);
        
        [connection
         doPutRequest:url
         httpHeaderFields:httpHeaderField
         parameters:bodyParameters
         success:^(NSURLRequest *request, NSDictionary *response) {
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 success(response);
             }];
         }
         failure:^(NSURLRequest *request, NSDictionary *response, NSError *error) {
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 if (error) {
                     failure(@[error, [self _getErrorsFromResponse:response]]);
                 } else {
                     failure([self _getErrorsFromResponse:response]);
                 }
             }];
         }];
    }];
}


@end
