// *************************************************************************************************
// # MARK: Imports


#import "iBPMDataParserUtils.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation iBPMDataParserUtils


+ (id)parseDataFromFile:(NSString *) fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSError *err;
    NSString *staticJSON = [[NSString alloc] initWithContentsOfFile:filePath
                                                           encoding:NSUTF8StringEncoding
                                                              error:&err];
    if (err) {
        NSLog(@"iBPMLocalDataProvider : Error - %@", err);
        return nil;
    }
    NSData *jsonData = [staticJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:kNilOptions
                                                               error:&err];
    if (err) {
        NSLog(@"iBPMLocalDataProvider : Error - %@", err);
        return nil;
    }
    
    return jsonDict;
}


@end
