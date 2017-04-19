// *************************************************************************************************
// # MARK: Blocks


typedef void (^iBPMConnectionCompletion)(NSURLRequest *request, NSDictionary *response);
typedef void (^iBPMConnectionErrorCompletion)(NSURLRequest *request, NSDictionary *response, NSError *error);


// *************************************************************************************************
// # MARK: Public Interface


@interface iBPMConnection : NSObject


- (void)doDELETERequest:(NSString *)url
       httpHeaderFields:(NSDictionary *)httpHeaderFields
             parameters:(id)parameters
                success:(iBPMConnectionCompletion)onCompletion
                failure:(iBPMConnectionErrorCompletion)onFailure;
- (void)doGETRequest:(NSString *)url
    httpHeaderFields:(NSDictionary *)httpHeaderFields
          parameters:(id)parameters
             success:(iBPMConnectionCompletion)onCompletion
             failure:(iBPMConnectionErrorCompletion)onFailure;
- (void)doPostRequest:(NSString *)url
     httpHeaderFields:(NSDictionary *)httpHeaderFields
           parameters:(id)parameters
              success:(iBPMConnectionCompletion)onCompletion
              failure:(iBPMConnectionErrorCompletion)onFailure;
- (void)doPostRequestWithFormData:(NSString *)url
                 httpHeaderFields:(NSDictionary *)httpHeaderFields
                        filePaths:(NSArray *)paths
                          success:(iBPMConnectionCompletion)onCompletion
                          failure:(iBPMConnectionErrorCompletion)onFailure;
- (void)doPutRequest:(NSString *)url
    httpHeaderFields:(NSDictionary *)httpHeaderFields
          parameters:(id)parameters
             success:(iBPMConnectionCompletion)onCompletion
             failure:(iBPMConnectionErrorCompletion)onFailure;


@end
