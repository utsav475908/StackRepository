// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataProvider+PostProcessor.h"

#import "iBPMAppModel.h"
#import "iBPMOperationQueueUtils.h"
#import "iBPMDomainModel.h"



// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDataProvider (PostProcessor)


- (void)processStatusWithServerResponse:(NSArray *)response
                        completionBlock:(CompletionBlock)completion {
    [[iBPMOperationQueueUtils utilityQueue] addOperationWithBlock:^{
        NSMutableArray *results = [NSMutableArray new];
        for (NSDictionary *lifeCycle in response) {
            NSMutableDictionary *lifeCycleDict = [NSMutableDictionary new];
            for (NSString *lifeCycleKey in [lifeCycle allKeys]) {
                NSDictionary *domains = lifeCycle[lifeCycleKey];
                NSMutableDictionary *domainDict = [NSMutableDictionary new];
                for (NSString *domainKey in [domains allKeys]) {
                    iBPMDomainModel *domain = [[iBPMDomainModel alloc]
                                               initWithDictionary:domains[domainKey]];
                    domain.name = domainKey;
                    [domainDict setObject:domain forKey:domainKey];
                }
                [lifeCycleDict setObject:domainDict forKey:lifeCycleKey];
            }
            [results addObject:lifeCycleDict];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(results);
        }];
    }];
}


@end
