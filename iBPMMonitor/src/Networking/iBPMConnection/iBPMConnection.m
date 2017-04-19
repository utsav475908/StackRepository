// *************************************************************************************************
// # MARK: Imports


#import "iBPMConnection.h"

#import "iBPMAuthenticationManager.h"


// *************************************************************************************************
// # MARK: Private Interface


@interface iBPMConnection () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>


// *************************************************************************************************
// # MARK: Private Properties


@property (nonatomic, strong) NSURLSession *_currentSession;
@property (nonatomic, strong) NSURLSessionTask *_currentSessionTask;
@property (nonatomic, strong) NSMutableData *_data;
@property (nonatomic, copy) iBPMConnectionErrorCompletion _errorCompletion;
@property (nonatomic, assign) NSInteger _errorCode;
@property (nonatomic, assign) BOOL _isError;
@property (atomic, strong) dispatch_queue_t _queue;
@property (nonatomic, copy) iBPMConnectionCompletion _successCompletion;
@property (nonatomic, strong) NSURL *_url;


@end


// *************************************************************************************************
// # MARK: Private Implementation


@implementation iBPMConnection


- (instancetype)init {
    if (self = [super init]) {
        self._queue = dispatch_get_main_queue();
    }
    
    return self;
}


// *************************************************************************************************
// # MARK: NSURLSessionTask Delegate Methods


- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode >= 400) {
        self._isError = YES;
        self._errorCode = httpResponse.statusCode;
    } else {
        self._isError = NO;
        NSArray* cookies =
            [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields]
                                                   forURL:self._url];
        if (cookies.count > 0 && [iBPMAuthenticationManager sharedManager].authCookies == nil) {
            [[iBPMAuthenticationManager sharedManager] setAuthCookies:cookies];
        }
    }
    
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [self._data appendData:data];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler {
    completionHandler(nil);
}


- (void)URLSession:(NSURLSession *)session
        task:(NSURLSessionTask *)task
        didCompleteWithError:(NSError *)error {
    NSError *errors;
    NSDictionary *response;
    
    if (error && self._errorCompletion) {
        self._errorCompletion(task.originalRequest, nil, error);
    }
    
    if (self._isError) {
        if (self._errorCompletion) {
            response =
                [NSJSONSerialization JSONObjectWithData:self._data options:kNilOptions error:&errors];
            NSError *httpError = [NSError errorWithDomain:NSURLErrorDomain code:self._errorCode userInfo:nil];
            self._errorCompletion(task.originalRequest, response, httpError);
        }
        [self _reset];
        return;
    }
    
    if (self._data) {
        response =
            [NSJSONSerialization JSONObjectWithData:self._data options:kNilOptions error:&error];
    }
    
    if (self._successCompletion) {
        self._successCompletion(task.originalRequest, response);
    }
    
    [self _reset];
}


// *************************************************************************************************
// # MARK: Public Methods


- (void)doDELETERequest:(NSString *)url
       httpHeaderFields:(NSDictionary *)httpHeaderFields
             parameters:(id)parameters
                success:(iBPMConnectionCompletion)onCompletion
                failure:(iBPMConnectionErrorCompletion)onFailure {
    dispatch_async(self._queue, ^{
        [self _reset];
        self._successCompletion = onCompletion;
        self._errorCompletion = onFailure;
        self._data = [[NSMutableData alloc] init];
        if (!self._url) {
            self._url = [NSURL URLWithString:url];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url];
        request.HTTPMethod = @"DELETE";
        if (httpHeaderFields) {
            [request setAllHTTPHeaderFields:httpHeaderFields];
        }
        if (parameters) {
            [request setHTTPBody:parameters];
        }
        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [self _createSessionTask:request];
    });
}


- (void)doGETRequest:(NSString *)url
    httpHeaderFields:(NSDictionary *)httpHeaderFields
          parameters:(id)parameters
             success:(iBPMConnectionCompletion)onCompletion
             failure:(iBPMConnectionErrorCompletion)onFailure {
    
    @try {
        dispatch_async(self._queue, ^{
            [self _reset];
            self._successCompletion = onCompletion;
            self._errorCompletion = onFailure;
            self._data = [[NSMutableData alloc] init];
            if (!self._url) {
                self._url = [NSURL URLWithString:url];
            }
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url];
            if (httpHeaderFields) {
                [request setAllHTTPHeaderFields:httpHeaderFields];
            }
            if (parameters) {
                [request setHTTPBody:parameters];
            }
            request.HTTPMethod = @"GET";
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [self _createSessionTask:request];
        });
    } @catch (NSException *exception) {
        NSLog(@"%@ %@ url %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), url);
    }
}


- (void)doPostRequest:(NSString *)url
     httpHeaderFields:(NSDictionary *)httpHeaderFields
           parameters:(id)parameters
              success:(iBPMConnectionCompletion)onCompletion
              failure:(iBPMConnectionErrorCompletion)onFailure {
    dispatch_async(self._queue, ^{
        [self _reset];
        self._successCompletion = onCompletion;
        self._errorCompletion = onFailure;
        self._data = [[NSMutableData alloc] init];
        if (!self._url) {
            self._url = [NSURL URLWithString:url];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url];
        request.HTTPMethod = @"POST";
        if (httpHeaderFields) {
            [request setAllHTTPHeaderFields:httpHeaderFields];
        }

        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        if (parameters) {
            [request setHTTPBody:parameters];
        }
        [self _createSessionTask:request];
    });
}


- (void)doPutRequest:(NSString *)url
    httpHeaderFields:(NSDictionary *)httpHeaderFields
          parameters:(id)parameters
             success:(iBPMConnectionCompletion)onCompletion
             failure:(iBPMConnectionErrorCompletion)onFailure {
    dispatch_async(self._queue, ^{
        [self _reset];
        self._successCompletion = onCompletion;
        self._errorCompletion = onFailure;
        self._data = [[NSMutableData alloc] init];
        if (!self._url) {
            self._url = [NSURL URLWithString:url];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url];
        request.HTTPMethod = @"PUT";
        if (httpHeaderFields) {
            [request setAllHTTPHeaderFields:httpHeaderFields];
        }
        if (parameters) {
            [request setHTTPBody:parameters];
        }
        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [self _createSessionTask:request];
    });
}


- (void)doPostRequestWithFormData:(NSString *)url
                 httpHeaderFields:(NSDictionary *)httpHeaderFields
                        filePaths:(NSArray *)paths
                          success:(iBPMConnectionCompletion)onCompletion
                          failure:(iBPMConnectionErrorCompletion)onFailure {
    dispatch_async(self._queue, ^{
        [self _reset];
        self._successCompletion = onCompletion;
        self._errorCompletion = onFailure;
        self._data = [[NSMutableData alloc] init];
        if (!self._url) {
            self._url = [NSURL URLWithString:url];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url];
        request.HTTPMethod = @"POST";
        if (httpHeaderFields) {
            [request setAllHTTPHeaderFields:httpHeaderFields];
        }
        NSString *boundary = @"---BOUNDARY---";
        if (paths) {
            request.HTTPBody = [self _createBodyWithBoundary:boundary
                                                       paths:paths
                                                   fieldName:@"file"];
        }
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        [self _createSessionTask:request];
    });
}


// *************************************************************************************************
// # MARK: Private Methods


- (NSData *)_createBodyWithBoundary:(NSString *)boundary
                              paths:(NSArray *)paths
                          fieldName:(NSString *)fieldName {
    NSMutableData *httpBody = [NSMutableData data];
    for (NSString *path in paths) {
        NSString *filename = [path lastPathComponent];
        
        // Convert The Filepath to UNIX file path
        NSString *unixFilePath = [[NSURL URLWithString:path] path];
        NSData *data = [NSData dataWithContentsOfFile:unixFilePath];
        
        [httpBody appendData:
            [[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:
            [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                fieldName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:
            [@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:data];
        [httpBody appendData:[@"\r\n" dataUsingEncoding: NSUTF8StringEncoding]];
    }
    [httpBody appendData:
        [[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding: NSUTF8StringEncoding]];
    
    return httpBody.copy;
}


- (void)_createSessionTask:(NSMutableURLRequest *)request {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Set timeinterval for request to 3 minutes
    configuration.timeoutIntervalForRequest = 180.0;
    configuration.timeoutIntervalForResource = 180.0;
    
    self._currentSession = [NSURLSession sessionWithConfiguration:configuration
                                                        delegate:self
                                                   delegateQueue:[NSOperationQueue currentQueue]];
    self._currentSessionTask = [self._currentSession dataTaskWithRequest:request];
    [self._currentSessionTask resume];
}


- (void)_reset {
    self._successCompletion = nil;
    self._errorCompletion = nil;
    self._data = nil;
}


@end
