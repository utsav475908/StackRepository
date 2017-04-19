// *************************************************************************************************
// # MARK: Blocks


typedef void (^iBPMRequestDataError)(NSArray *errors);
typedef void (^iBPMRequestData)(id results);


// *************************************************************************************************
// # MARK: DataProvider Interface


@protocol iBPMDataProviderInterface <NSObject>


- (void)getDomainsIn:(NSString *)lifeCycle
             success:(iBPMRequestData)success
             failure:(iBPMRequestDataError)failure;
- (void)getLifeCycles:(iBPMRequestData)success failure:(iBPMRequestDataError)failure;
- (void)getStatus:(iBPMRequestData)success failure:(iBPMRequestDataError)failure;
- (void)getStatusForDomain:(NSString *)domain
                  infoType:(NSString *)infoType
                      SRID:(NSString *)SRID
                   success:(iBPMRequestData)success
                   failure:(iBPMRequestDataError)failure;
- (void)loginWithUserID:(NSString *)userID
               password:(NSString *)password
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure;
- (void)sendDeviceToken:(NSString*)token
                success:(iBPMRequestData)success
                failure:(iBPMRequestDataError)failure;


@end
