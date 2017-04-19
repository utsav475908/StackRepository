// *************************************************************************************************
// # MARK: public Interface


@interface iBPMOperationQueueUtils : NSObject


// *************************************************************************************************
// # MARK: Class Methods


+ (NSOperationQueue *)backgroundQueue;
+ (NSOperationQueue *)utilityQueue;


@end
