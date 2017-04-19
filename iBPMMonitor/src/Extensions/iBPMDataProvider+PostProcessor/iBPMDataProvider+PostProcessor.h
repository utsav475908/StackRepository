// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProvider.h"


// *************************************************************************************************
// # MARK: Completion Block Declaration


typedef void (^CompletionBlock)(id results);


// *************************************************************************************************
// # MARK: Pbulic Interfaces


@interface iBPMDataProvider (PostProcessor)


- (void)processStatusWithServerResponse:(NSArray *)response
                        completionBlock:(CompletionBlock)completion;


@end
