//
//  PzIndexes.h
//
//  Created by   on 6/6/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PzIndexes : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *indexDRDWork;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
