//
//  SHXMLParser+Convertation.m
//  ExchangeRates
//
//  Created by Elvis on 3/11/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "SHXMLParser+Convertation.h"

@implementation SHXMLParser (Convertation)


+ (NSArray *)convertDictionaryArray:(NSArray *)dictionaryArray toObjectArrayWithClassName:(NSString *)className {
    
    NSMutableArray *objectArray = [NSMutableArray array];
    
    for (NSDictionary *dict in dictionaryArray) {
        Class klass = NSClassFromString(className);
        id <Mappable> object = [[klass alloc] init];
        [object map:dict];
        [objectArray addObject:object];
    }
    return objectArray;
}

@end
