// *************************************************************************************************
// # MARK: Imports


#import "iBPMOperationQueueUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMOperationQueueUtils


// *************************************************************************************************
// # MARK: Class Methods


+ (NSOperationQueue *)backgroundQueue {
    static NSOperationQueue *backgroundQueue;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        backgroundQueue = [[NSOperationQueue alloc] init];
        backgroundQueue.maxConcurrentOperationCount = 10;
        backgroundQueue.qualityOfService = NSQualityOfServiceBackground;
    });
    
    return backgroundQueue;
}


+ (NSOperationQueue *)utilityQueue {
    static NSOperationQueue *utilityQueue;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        utilityQueue = [[NSOperationQueue alloc] init];
        utilityQueue.maxConcurrentOperationCount = 10;
        utilityQueue.qualityOfService = NSQualityOfServiceUtility;
    });
    
    return utilityQueue;
}


@end
